import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; 
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  Future<void> _onRegisterSubmitted(
      RegisterSubmitted event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());

    try {
      final response = await http.post(
        Uri.parse(
            'https://backend-nutrisionist-production.up.railway.app/api/v1/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': event.username,
          'email': event.email,
          'password': event.password,
          'gender': event.gender,
          'dob': event.dob,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['status'] == 'Success') {
          // Simpan token JWT ke secure storage
          final storage = FlutterSecureStorage();
          await storage.write(key: "auth_token", value: responseData["data"]["token"]);

          emit(RegisterSuccess());
        } else {
          emit(RegisterFailure(
              error: responseData['message'] ?? 'Registration failed'));
        }
      } else {
        final errorResponse = json.decode(response.body);
        emit(RegisterFailure(
            error: errorResponse['message'] ?? 'Registration failed'));
      }
    } catch (error) {
      emit(RegisterFailure(error: error.toString()));
    }
  }
}
