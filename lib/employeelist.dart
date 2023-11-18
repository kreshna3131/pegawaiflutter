import 'package:flutter/material.dart';
import 'package:pegawai/database/dbhelper.dart';
import 'package:pegawai/model/employee.dart';

class MyEmployeeList extends StatefulWidget {
  @override
  MyEmployeeListPageState createState() => MyEmployeeListPageState();
}

class MyEmployeeListPageState extends State<MyEmployeeList> {
  Future<List<Employee>>? employees;
  late String firstname;
  late String lastname;
  late String mobileno;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    employees = fetchEmployeesFromDatabase();
  }

  Future<List<Employee>> fetchEmployeesFromDatabase() async {
    var dbHelper = DBHelper();
    List<Employee> employeeList = await dbHelper.getEmployees();
    return employeeList;
  }

  void deleteEmployee(Employee employee) async {
    var dbHelper = DBHelper();
    await dbHelper.deleteEmployee(employee.id!);
    setState(() {
      employees = fetchEmployeesFromDatabase();
    });
  }

  void editEmployee(Employee employee) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Employee'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: employee.firstName,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: 'First Name'),
                    validator: (val) =>
                        val?.length == 0 ? "Enter First Name" : null,
                    onSaved: (val) => this.firstname = val!,
                  ),
                  TextFormField(
                    initialValue: employee.lastName,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: 'Last Name'),
                    validator: (val) =>
                        val?.length == 0 ? 'Enter Last Name' : null,
                    onSaved: (val) => this.lastname = val!,
                  ),
                  TextFormField(
                    initialValue: employee.mobileNo,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(labelText: 'Mobile No'),
                    validator: (val) =>
                        val?.length == 0 ? 'Enter Mobile No' : null,
                    onSaved: (val) => this.mobileno = val!,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _submitEdit(employee.id!);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _submitEdit(int id) {
    if (this.formKey.currentState!.validate()) {
      formKey.currentState!.save();
    } else {
      return null;
    }

    final editedEmployee = new Employee(
      id: id,
      firstName: firstname,
      lastName: lastname,
      mobileNo: mobileno,
    );

    var dbHelper = DBHelper();
    dbHelper.saveEmployee(editedEmployee);
    Navigator.pop(context); // Close the edit dialog
    _showSnackBar("Data updated successfully");
    setState(() {
      employees = fetchEmployeesFromDatabase();
    });
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: FutureBuilder<List<Employee>>(
          future: employees,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Employee? employee = snapshot.data![index];
                  if (employee != null) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              employee.firstName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              employee.lastName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ),
                            ),
                            Text(
                              employee.mobileNo,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.amber,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                color: Colors.white,
                                onPressed: () {
                                  editEmployee(employee);
                                },
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.delete),
                                color: Colors.white,
                                onPressed: () {
                                  deleteEmployee(employee);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return SizedBox.shrink(); // Avoiding null employee
                  }
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
