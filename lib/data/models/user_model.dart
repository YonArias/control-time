import 'package:time_control_app/domain/entities/user.dart';

class UserModel {
  //final String id;
  final String name;
  final String lastname;
  final String rol;
  final String gmail;
  final bool isActive;
  final bool isValidate;

  UserModel({
    //required this.id,
    required this.name,
    required this.lastname,
    required this.rol,
    required this.gmail,
    required this.isActive,
    required this.isValidate,
  });

  factory UserModel.fromJasonMap(Map<String, dynamic> json) => UserModel(
        //id: json['id'],
        name: json['name'],
        lastname: json['lastname'],
        rol: json['rol'],
        gmail: json['gmail'],
        isActive: json['isActive'],
        isValidate: json['isValidate'],
      );

  User toUserEntity() => User(
        //id: id,
        name: name,
        lastname: lastname,
        rol: rol,
        gmail: gmail,
        isActive: isActive,
        isValidate: isValidate,
      );
}