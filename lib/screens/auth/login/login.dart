import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/extention_function/extention_function_l10n.dart';
import 'package:to_do_list/model/my_user.dart';
import 'package:to_do_list/screens/auth/sign_up/sign_up.dart';
import 'package:to_do_list/utilities/dialog_utilities.dart';

import '../../../utilities/app_theme.dart';
import '../../home.dart';

class Login extends StatefulWidget {
  static const String routeName = "login";

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                  context.l10n.login,
                  style: AppTheme.taskTitleTextStyle,
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
                ElevatedButton(
                  onPressed: () {
                    loginAction();
                  },
                  child: Row(
                    children: [
                      Text(context.l10n.login),
                      const Spacer(),
                      const Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignUp.routeName);
                    },
                    child: Text(
                      context.l10n.go_to_signup,
                      style: TextStyle(decoration: TextDecoration.underline),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loginAction() async {
    if (!formKey.currentState!.validate()) return;
    try {
      DialogUtilities.showLoading(context);
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      getUserFromFireStore(credential.user!.uid).then((user) {
        MyUser.currentUser = user;
        DialogUtilities.hideLoading(context);
        Navigator.pushReplacementNamed(context, Home.routeName);
      });
    } on FirebaseAuthException catch (e) {
      DialogUtilities.hideLoading(context);
      if (e.code == 'user-not-found') {
        DialogUtilities.showError(context, context.l10n.no_email_found);
      } else if (e.code == 'wrong-password') {
        DialogUtilities.showError(context, context.l10n.wrong_password);
      } else {
        try {
          final result = await InternetAddress.lookup('example.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            print('========Internet connected==========');
          }
        } on SocketException catch (_) {
          DialogUtilities.showError(context, "Internet not connected");
        }
      }
    }
  }

  Future<MyUser> getUserFromFireStore(String id) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(MyUser.collectionName);
    DocumentReference userDoc = collectionReference.doc(id);
    print("=============== $id");
    DocumentSnapshot documentSnapshot = await userDoc.get();
    Map json = documentSnapshot.data() as Map;
    print("=============== $documentSnapshot");
    MyUser myUser = MyUser.fromJson(json);
    return myUser;
  }
}
