import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    const String apiUrl = "https://backend-nutrisionist-production.up.railway.app/api/v1/auth/login"; 

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": event.username,
          "password": event.password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["success"] == true) {
          emit(LoginSuccess(token: data["token"]));
        } else {
          emit(LoginFailure(error: data["message"] ?? "Login failed"));
        }
      } else {
        emit(LoginFailure(error: "Server error"));
      }
    } catch (e) {
      emit(LoginFailure(error: "An error occurred: $e"));
    }
  }
}
