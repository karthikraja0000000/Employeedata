import 'package:employee_data/database/data_base_connection.dart';

class EmployeeRepository {

  final DataBaseHelper dbHelper = DataBaseHelper.instance;


  Future<int> registerUser(String email,String password,String username) async{
     return await dbHelper.insertUser(email, password, username);
    }
  Future<Map<String, dynamic>?> loginUser(String email,String password) async {
     return await dbHelper.getUser(email, password);

    }
  Future<Map<String, dynamic>?> createEmployeeTable(String email) async {
    return await dbHelper.createUserTable(email);
  }
  Future<List<Map<String, dynamic>>> fetchEmployee(String email) async{
    return await dbHelper.getAllUsers(email);
  }
  Future<int> addEmployeeData(String email,String name,String age) async {
    return await dbHelper.insertUserTable(email, name, age);
  }
  Future<int> editEmployeeData(String email,String name,String age,int id) async{
    return await dbHelper.updateUser(id, name, age, email);
  }
  Future<int> deleteEmployeeData(int id,String email) async{
    return await dbHelper.deleteUser(id, email);
  }
}