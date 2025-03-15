import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../user_auth/user_auth_bloc.dart';
import '../widgets/text_form_assets.dart';
import 'home_page.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: BlocConsumer<UserAuthBloc, UserAuthState>(

              listener: (context, state) {
                if (state is RegisterPageSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                } else if (state is LoginPageFailed) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("failed to register")));
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 52.h),
                    const Center(
                      child: Text(
                        "Register Form",
                        style: TextStyle(
                          fontFamily: 'SourceSansPro',
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),
                    TextFormAssets(
                      str: "Email:",
                      controller: emailController,
                      textHint: "Enter your email",
                      obscureText: false,
                      numKeyBoardType: false,
                      suffixText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter the name";
                        } else if (!RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        ).hasMatch(value)) {
                          return "enter a valid email id";
                        }
                        return null;
                      },
                    ),
        
                    SizedBox(height: 12.h),
        
                    TextFormAssets(
                      str: "Username:",
                      textHint: "Enter your Username",
                      controller: userNameController,
                      suffixText: true,
                      obscureText: false,
                      numKeyBoardType: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter Username";
                        }
                        return null;
                      },
                    ),
        
                    SizedBox(height: 12.h),
        
                    TextFormAssets(
                      str: "Mobile number:",
                      textHint: "Enter your mobile number",
                      obscureText: false,
                      controller: numberController,
                      numKeyBoardType: true,
                      suffixText: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter mobile number';
                        } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {}
                        return null;
                      },
                    ),
        
                    SizedBox(height: 12.h),
                    TextFormAssets(
                      str: "Password:",
                      controller: passwordController,
                      obscureText: true,
                      textHint: "Enter your Password",
                      numKeyBoardType: false,
                      suffixText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter the Password";
                        } else if (!RegExp(
                          r'^[A-Z][a-z]+\d+[@$!%*?&]$',
                        ).hasMatch(value)) {
                          return "Password must initial letter uppercase then small must contain one number and spl char";
                        }
                        return null;
                      },
                    ),
        
                    SizedBox(height: 12.h),
                    TextFormAssets(
                      str: "Re-Enter the password:",
                      controller: rePasswordController,
                      textHint: "Enter your password again",
                      obscureText: true,
                      suffixText: true,
                      numKeyBoardType: false,
        
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter the password again";
                        } else if (!RegExp(
                          r'^[A-Z][a-z]+\d+[@$!%*?&]$',
                        ).hasMatch(value)) {
                          return "Password must initial letter uppercase then small must contain one number and spl char";
                        } else if (passwordController.text !=
                            rePasswordController.text) {
                          return "Please enter the Correct password";
                        }
                        return null;
                      },
                    ),
        
                    SizedBox(height: 32.h),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          BlocProvider.of<UserAuthBloc>(context).add(
                            AuthRegisterButton(
                              username: userNameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Please fill in all fields correctly")));
                        }
                      },
                      child: Container(
                        height: 52.h,
                        width: 328.w,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            "Submit",
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Already a user? ",
                                style: GoogleFonts.poppins(color: Colors.black),
                              ),
                              TextSpan(
                                text: " Login here",
                                style: TextStyle(
                                  fontFamily: 'SourceSansPro',
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
