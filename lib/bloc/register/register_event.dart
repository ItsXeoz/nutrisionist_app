import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterSubmitted extends RegisterEvent {
  final String username;
  final String email;
  final String password;
  final String gender;
  final String dob;

  const RegisterSubmitted({
    required this.username,
    required this.email,
    required this.password,
    required this.gender,
    required this.dob,
  });

  @override
  List<Object> get props => [username, email, password, gender, dob];
}
