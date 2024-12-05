import 'dart:async';
import 'dart:convert';
import 'dart:io'; // For handling SocketException
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  Future<void> _onRegisterSubmitted(
      RegisterSubmitted event, Emitter<RegisterState> emit) async {
    if (event.username.isEmpty ||
        event.email.isEmpty ||
        event.password.isEmpty ||
        event.gender.isEmpty ||
        event.dob.isEmpty) {
      emit(RegisterFailure(error: "All fields are required."));
      return;
    }

    emit(RegisterLoading());
    try {
      final response = await http.post(
        Uri.parse(
            'https://backend-nutrisionist-production.up.railway.app/api/v1/auth/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': event.username,
          'email': event.email,
          'password': event.password,
          'gender': event.gender,
          'dob': event.dob,
        }),
      );

      if (response.statusCode == 200) {
        emit(RegisterSuccess());
      } else {
        final errorResponse = json.decode(response.body);
        print("Error Response: ${response.body}");
        emit(RegisterFailure(error: errorResponse['message'] ?? 'Registration failed'));
      }
    } on SocketException {
      emit(RegisterFailure(error: "No Internet connection. Please try again."));
    } catch (error) {
      emit(RegisterFailure(error: "An unexpected error occurred: $error"));
    } finally {
      await Future.delayed(Duration(seconds: 2));
      emit(RegisterInitial());
    }
  }
}
