import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../employees/employees_bloc.dart';
import 'add_employee_page.dart';
import 'edit_employee_page.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  // final String username;
  final String email;
  const HomePage({super.key,  required this.email});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<EmployeesBloc>().add(FetchAllEmployee(widget.email));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocConsumer<EmployeesBloc, EmployeesState>(
                  listener: (context, state) {
                    if (state is HomePageFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error)),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is HomePageLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is HomePageSuccess) {
                      return Column(
                        children: [
                          SizedBox(height: 36.h),
                          Text(
                            "Welcome!",
                            style: TextStyle(fontSize: 24),
                          ),
                          SizedBox(height: 24.h),

                          // Logout Button
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                              );
                            },
                            child: Text("Logout", style: TextStyle(color: Colors.red)),
                          ),
                          SizedBox(height: 36.h),

                          // Add Employee Button
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AddEmployeePage(email:widget.email)),
                              ).then((_) =>
                                  context.read<EmployeesBloc>().add(FetchAllEmployee(widget.email)));
                            },
                            child: Text("Add Employee", style: TextStyle(color: Colors.blue)),
                          ),
                          SizedBox(height: 36.h),

                          // Employee List Title
                          Text('List of all employees', style: TextStyle(color: Colors.green)),

                          // Employee List
                          SizedBox(
                            height:500.h,
                            child: ListView.builder(
                              itemCount: state.allUsers.length,
                              itemBuilder: (context, index) {
                                final employee = state.allUsers[index];

                                return Card(
                                  margin: EdgeInsets.all(10),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      child: Text("${employee['id']}"),
                                    ),
                                    title: Text(
                                      "Name: ${employee['name'] ?? "No Name"}",
                                    ),
                                    subtitle: Text(
                                      "Age: ${employee['age'] ?? "No Age"}",
                                    ),
                                    trailing: SizedBox(
                                      width: 100,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [

                                          IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              color: Colors.blue,
                                              size: 18.r,
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => EditEmployeePage(
                                                    id: employee['id'],
                                                    // name: employee['name'],
                                                    // age: employee['age'],
                                                    email: widget.email,
                                                  ),
                                                ),
                                              ).then((_) =>
                                                  context.read<EmployeesBloc>().add(FetchAllEmployee(widget.email)));
                                            },
                                          ),

                                          IconButton(
                                            icon: Icon(
                                              Icons.delete_forever,
                                              color: Colors.red,
                                              size: 18.r,
                                            ),
                                            onPressed: () {
                                              context.read<EmployeesBloc>().add(
                                                DeleteEmployee(employee['id'], widget.email),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }

                    return Center(child: Text("No users found"));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
