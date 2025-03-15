import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../employees/employees_bloc.dart';
import '../user_auth/user_auth_bloc.dart';
import '../widgets/text_form_assets.dart';
import 'home_page.dart';

class AddEmployeePage extends StatefulWidget {
  final String email;
  const AddEmployeePage({super.key, required this.email});

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {

  TextEditingController addEmployeeNameController = TextEditingController();
  TextEditingController addEmployeeAgeController = TextEditingController();
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
              child: BlocConsumer<EmployeesBloc, EmployeesState>(

                listener: (context,state){
                  if (state is AddEmployeePageSuccess) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage( email: widget.email,)),
                    );
                  } else if (state is AddEmployeePageFailure) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("failed to register")));
                  }
                },
                builder:(context, state){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 52.h),
                    const Center(
                      child: Text(
                        "Add Employee data",
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
                      str: "Name:",
                      controller: addEmployeeNameController,
                      textHint: "Enter your name",
                      obscureText: false,
                      numKeyBoardType: false,
                      suffixText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter the name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 32.h),
                    TextFormAssets(
                      str: "Age:",
                      controller: addEmployeeAgeController,
                      textHint: "Enter your age",
                      obscureText: false,
                      numKeyBoardType: true,
                      suffixText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter the Age";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 32.h),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState?.validate() ?? false){
                          BlocProvider.of<EmployeesBloc>(context).add(
                           AddEmployee(age: addEmployeeAgeController.text, name: addEmployeeNameController.text, email: widget.email)

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
                  ],
                  );
                } ,
              )
          ),
        ),
      ),
    );
  }
}
