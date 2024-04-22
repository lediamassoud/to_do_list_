class MyUser {
  static const String collectionName = "users";
  static MyUser? currentUser;
  late String id;
  late String userName;
  late String email;

  MyUser({required this.id, required this.userName, required this.email});

  MyUser.fromJson(Map json) {
    id = json["id"];
    userName = json["username"];
    email = json["email"];
  }

  Map<String, String> toJson() {
    return {"id": id, "email": email, "username": userName};
  }
}
