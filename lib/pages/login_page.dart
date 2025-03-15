import 'package:employee_data/pages/home_page.dart';
import 'package:employee_data/pages/register_page.dart';
import 'package:employee_data/user_auth/user_auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/text_form_assets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
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
            child: BlocConsumer<UserAuthBloc,UserAuthState>(
              listener: (context, state){
                  if(state is LoginPageSuccess){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(email: loginEmailController.text)));
                  }else if(state is LoginPageFailed){
                    Future.delayed(Duration.zero, () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("failed to login")),
                    );
                  });
                  }
                },
              builder: (context , state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 52.h),
                      const Center(
                        child: Text(
                          "Login Form for website",
                          style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      SizedBox(height: 138.h),
                      TextFormAssets(
                        str: "Email:",
                        controller: loginEmailController,
                        textHint: "Enter your email",
                        obscureText: false,
                        numKeyBoardType: false,
                        suffixText: true,
                        validator: (value){
                          if (value!.isEmpty){
                            return "please enter email";
                          }
                          else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)){
                            return "enter correct email";
                          }
                          return null;
                        },
        
                      ),
                      SizedBox(height: 32.h),
                      TextFormAssets(
                        obscureText: true,
                        controller: loginPasswordController,
                        textHint: "Enter your password",
                        str: "Password",
                        suffixText: true,
                        numKeyBoardType: false,
                        validator: (value){
                          if (value!.isEmpty){
                            return"enter the password";
                          }
                          else if (!RegExp(r'^[A-Z][a-z]+\d+[@$!%*?&]$').hasMatch(value)){
                            return"Password must initial letter uppercase then small must contain one number and spl char";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 32.h),
                      GestureDetector(
                        onTap: (){
                          if(_formKey.currentState?.validate() ?? false){
                            print("Dispatching AuthLoginButton event");
                            BlocProvider.of<UserAuthBloc>(context).add(
                              AuthLoginButton(email: loginEmailController.text, password: loginPasswordController.text)
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
                          child: Center(child: Text("submit",
                              style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              color: Colors.white,)),
                        ),
                      ),
                      ),
                      SizedBox(height: 16.h),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterPage()),
                          );
                        },
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Not a user? ",
                                  style: GoogleFonts.poppins(color: Colors.black),
                                ),
                                TextSpan(
                                  text: " Register here",
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
