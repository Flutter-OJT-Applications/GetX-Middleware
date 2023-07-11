import 'dart:convert';

class UserModel {
  int? id;
  int? roleId;
  String? name;
  String? email;
  String? password;

  UserModel({this.id, this.name, this.email, this.password, this.roleId});
  UserModel.empty();

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'role_id': roleId,
      'name': name,
      'email': email,
      'password': password
    };
  }
  
  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      id: json['id'],
      roleId: json['role_id'],
      name: json['name'],
      email: json['email'],
      password: json['password']
    );
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}