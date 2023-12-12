import 'package:time_control_app/domain/entities/user.dart';

class UserModel {
  final String name;
  final String lastname;
  final String rol;
  final String gmail;
  final String phone;
  final bool isValidate;

  UserModel({
    required this.name,
    required this.lastname,
    required this.rol,
    required this.gmail,
    required this.phone,
    required this.isValidate,
  });

  factory UserModel.fromJsonMap(Map<String, dynamic> json) => UserModel(
        name: json['name'] ?? 'No name',
        lastname: json['lastname'],
        rol: json['rol'],
        gmail: json['gmail'],
        phone: json['phone'],
        isValidate: json['isValidate'],
      );

  User toTranportEntity() => User(
        name: name,
        rol: lastname,
        gmail: gmail,
        phone: phone,
        isValidate: isValidate,
      );

  Map<String, dynamic> toJson() => {
    'name': name,
    'rol': lastname,
    'gmail': gmail,
    'phone': phone,
    'isValidate': isValidate,
  };
}
