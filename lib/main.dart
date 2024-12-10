import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrisionist_app/bloc/login/login_bloc.dart';
import 'package:nutrisionist_app/bloc/register/register_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nutrisionist_app/pages/login_page.dart';
import 'package:nutrisionist_app/pages/main_page.dart';

void main() {
  
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        // Tambahkan provider lain jika ada
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

    final _storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<String?>(
        future: _storage.read(key: "auth_token"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.data != null && snapshot.data!.isNotEmpty) {
              return MainPage();
            } else {
              return LoginPage();
            }
          }
        },
      ),
    );

  }
}
