import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nutrisionist_app/bloc/register/register_bloc.dart';
import 'package:nutrisionist_app/bloc/register/register_event.dart';
import 'package:nutrisionist_app/bloc/register/register_state.dart';
import 'package:nutrisionist_app/pages/home_page.dart';
import 'package:nutrisionist_app/widget/form_field.dart';
import 'package:nutrisionist_app/widget/password_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  // Nilai awal dropdown
  String? selectedGender;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    birthDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        birthDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: Scaffold(
        backgroundColor: Colors.green[400],
        body: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            } else if (state is RegisterFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: Center(
            child: registerForm(context),
          ),
        ),
      ),
    );
  }

  Widget registerForm(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Form(
            key: globalKey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Register",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                MyFormField(
                  hint: "Username",
                  textEditingController: usernameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please type your username";
                    }
                    return null;
                  },
                ),
                MyFormField(
                  hint: "Email",
                  textEditingController: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please type your email address";
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                  ),
                  value: selectedGender,
                  items: gender
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.7),
                            child: Text(
                              e,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGender = newValue!;
                    });
                  },
                ),
                TextFormField(
                  controller: birthDateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Date of Birth",
                    hintText: "Select your birth date",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () => _selectDate(context),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select your date of birth";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                PasswordFormField(
                  hintText: "Password",
                  textEditingController: passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please type your password";
                    }
                    return null;
                  },
                ),
                PasswordFormField(
                  hintText: "Confirm Password",
                  textEditingController: confirmPasswordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please type your confirm password";
                    }
                    if (value != passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (globalKey.currentState!.validate()) {
                          try {
                            context.read<RegisterBloc>().add(
                                  RegisterSubmitted(
                                    username: usernameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    gender: selectedGender!,
                                    dob: birthDateController.text,
                                  ),
                                  
                                );
                                
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Registration failed: $e")),
                            );
                            print(e);
                          }
                        }

                      },
                      child: Text("Register"),
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

List<String> gender = ['Male', 'Female'];
