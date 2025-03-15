import 'package:employee_data/database/employee_repository.dart';
import 'package:employee_data/employees/employees_bloc.dart';
import 'package:employee_data/pages/login_page.dart';
import 'package:employee_data/user_auth/user_auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserAuthBloc(employeeRepository: EmployeeRepository())),
        BlocProvider(create: (context) => EmployeesBloc(employeeRepository: EmployeeRepository())),
      ], child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LoginPage(),
        );
      },
    );
  }
}
