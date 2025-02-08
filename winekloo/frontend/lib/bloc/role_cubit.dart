import 'package:bloc/bloc.dart';

class RoleCubit extends Cubit<String> {
  RoleCubit() : super('');

  void updateRole(String role) {
    print("Role updated to: $role");
    emit(role);
  }
}
