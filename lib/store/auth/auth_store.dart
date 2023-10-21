import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_state.dart';

class AuthStore extends Cubit<AuthState> {
  AuthStore()
      : super(const AuthState(
          name: '',
        ));

  Future init() async {
    final preference = await SharedPreferences.getInstance();
    final name = preference.getString('auth-name') ?? '';
    emit(state.copyWith(name: name));
  }

  Future setName({
    required String name,
  }) async {
    final preference = await SharedPreferences.getInstance();
    await preference.setString('auth-name', name);
    emit(state.copyWith(name: name));
  }
}
