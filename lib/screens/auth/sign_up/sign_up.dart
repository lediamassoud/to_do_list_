import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/extention_function/extention_function_l10n.dart';
import 'package:to_do_list/model/my_user.dart';
import 'package:to_do_list/screens/auth/login/login.dart';
import 'package:to_do_list/utilities/app_theme.dart';
import 'package:to_do_list/utilities/dialog_utilities.dart';

class SignUp extends StatefulWidget {
  static const String routeName = "sign_up";

  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.app_title),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  context.l10n.sign_up,
                  style: AppTheme.taskTitleTextStyle,
                ),
                TextFormField(
                  controller: userNameController,
                  decoration:
                      InputDecoration(labelText: context.l10n.user_name),
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return context.l10n.error_message;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: context.l10n.email),
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return context.l10n.error_message;
                    }
                    final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(text);
                    if (!emailValid) {
                      return context.l10n.error_message;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: context.l10n.password,
                  ),
                  validator: (text) {
                    if (text == null ||
                        text.trim().isEmpty ||
                        text.length < 6) {
                      return context.l10n.error_message;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: confirmPasswordController,
                  decoration:
                      InputDecoration(labelText: context.l10n.confirm_password),
                  validator: (text) {
                    if (text == null ||
                        text.trim().isEmpty ||
                        text.length < 6) {
                      return context.l10n.error_message;
                    }
                    if (text != passwordController.text) {
                      return context.l10n.error_message;
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      signUpAction();
                    },
                    child: Row(
                      children: [
                        Text(context.l10n.sign_up),
                        const Spacer(),
                        const Icon(Icons.arrow_forward),
                      ],
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Login.routeName);
                    },
                    child: Text(
                      context.l10n.go_to_login,
                      style: TextStyle(decoration: TextDecoration.underline),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUpAction() async {
    if (!formKey.currentState!.validate()) return;
    try {
      DialogUtilities.showLoading(context);
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      MyUser.currentUser = MyUser(
          id: userCredential.user!.uid,
          userName: userNameController.text,
          email: emailController.text);
      await signUpUserToFirebase(MyUser.currentUser!);
      DialogUtilities.hideLoading(context);
      Navigator.pushReplacementNamed(context, Login.routeName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        DialogUtilities.showError(context, '');
      } else if (e.code == 'email-already-in-use') {
        DialogUtilities.showError(
            context, 'The account already exists for that email.');
      } else
        DialogUtilities.showError(context, context.l10n.error_message);
    }
  }

  Future<void> signUpUserToFirebase(MyUser user) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(MyUser.collectionName);
    DocumentReference documentReference = collectionReference.doc(user.id);
    documentReference.set(user.toJson());
  }
}
