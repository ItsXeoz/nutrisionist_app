import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final _storage = const FlutterSecureStorage();

  UserBloc() : super(UserInitial()) {
    on<FetchUserData>(_onFetchUserData);
  }

  Future<void> _onFetchUserData(FetchUserData event, Emitter<UserState> emit) async {
    emit(UserLoading());

    try {
      // Ambil token dari Flutter Secure Storage
      final token = await _storage.read(key: "auth_token");
      if (token == null) throw Exception("Token not found");

      // Kirim permintaan API untuk mendapatkan data pengguna
      final response = await http.get(
        Uri.parse("https://backend-nutrisionist-production.up.railway.app/api/v1/auth"),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        emit(UserLoaded(data));
      } else {
        final errorData = json.decode(response.body);
        emit(UserError(errorData['message'] ?? "Failed to fetch user data"));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
