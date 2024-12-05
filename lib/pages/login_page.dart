import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrisionist_app/bloc/login/login_bloc.dart';
import 'package:nutrisionist_app/bloc/login/login_event.dart';
import 'package:nutrisionist_app/bloc/login/login_state.dart';
import 'package:nutrisionist_app/pages/home_page.dart';
import 'package:nutrisionist_app/pages/register_page.dart';
import 'package:nutrisionist_app/widget/form_field.dart';
import 'package:nutrisionist_app/widget/password_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[400],
      body: Container(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            }
            if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Login Error: ${state.error}")));
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return loginForm();
            },
          ),
        ),
      ),
    );
  }

  Widget loginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
          child: Form(
            key: globalKey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Login To Your Account",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                MyFormField(
                  hint: "Email",
                  textEditingController: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please type Your Email Address";
                    }
                    return null;
                  },
                ),
                PasswordFormField(
                  hintText: "Password",
                  textEditingController: passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please type your Password";
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () {
                          if (globalKey.currentState!.validate()) {
                            context.read<LoginBloc>().add(LoginSubmitted(
                                password: passwordController.text,
                                username: emailController.text));
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.green[400],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(child: Text('Login')),
                        ),
                      )),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    child: Text(
                      "Don't Have An Account?",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
