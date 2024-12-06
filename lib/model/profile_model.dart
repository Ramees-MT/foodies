class Profile {
  int? id;
  String? username;
  String? email;
  String? password;
  String? phone;
  String? role;
  int? loginId;

  Profile(
      {this.id,
      this.username,
      this.email,
      this.password,
      this.phone,
      this.role,
      this.loginId});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    role = json['role'];
    loginId = json['login_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['role'] = this.role;
    data['login_id'] = this.loginId;
    return data;
  }
}
