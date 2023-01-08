class User {
  final String id;
  final String login;
  final String password;

  const User({
    required this.id,
    required this.login,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      login: json["login"],
      password: json["password"],
    );
  }
}
