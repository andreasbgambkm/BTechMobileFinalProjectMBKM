
class LoginData {
  final String username;
  final String password;
  final User user;

  LoginData({
    required this.username,
    required this.password,
    required this.user,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      username: json['username'],
      password: json['password'],
      user: User.fromJson(json['user']),
    );
  }


}

class User {
  final String name;
  final String position;
  final String division;

  User({
    required this.name,
    required this.position,
    required this.division,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      position: json['position'],
      division: json['division'],
    );
  }


}
