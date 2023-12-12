import 'package:flutter/foundation.dart';
import 'package:time_control_app/domain/entities/user.dart';
import 'package:time_control_app/domain/repositories/user_repository.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository userRepository;

  UserProvider({required this.userRepository});

  bool initialLoading = true;
  List<User> users = [];

  Future<void> loadUser() async {
    final newUsers = await userRepository.getUser();

    users.addAll(newUsers);
    initialLoading = false;

    notifyListeners();
  }

  Future<bool> ValidarIngreso(String? email) async {
    bool validado = false;

    users.forEach((element) {
      if (element.gmail == email) {
        validado = element.isValidate;
      }
    });

    return validado;
  }

  bool isOperador(String? email) {
    bool operator = false;

    users.forEach((element) {
      if (element.gmail == email) {
        element.rol == 'OPERARIO' ? operator = true : operator = false;
      }
    });

    return operator;
  }
}
