// import 'package:flutter/material.dart';
// import 'package:pegawai/database/dbhelper.dart';
// import 'package:pegawai/model/employee.dart';
// import 'package:pegawai/employeelist.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'SQFLite DataBase Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, this.title}) : super(key: key);
//   final String? title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   Employee employee = new Employee(firstName: '', lastName: '', mobileNo: '');

//   late String firstname;
//   late String lastname;
//   late String mobileno;
//   final scaffoldKey = new GlobalKey<ScaffoldState>();
//   final formKey = new GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       appBar: AppBar(
//         title: Text('Saving Employee'),
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(Icons.view_list),
//             tooltip: 'Next choice',
//             onPressed: () {
//               navigateToEmployeeList();
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 keyboardType: TextInputType.text,
//                 decoration: InputDecoration(labelText: 'First Name'),
//                 validator: (val) => val?.length == 0 ? "Enter FirstName" : null,
//                 onSaved: (val) => this.firstname = val!,
//               ),
//               TextFormField(
//                 keyboardType: TextInputType.text,
//                 decoration: InputDecoration(labelText: 'Last Name'),
//                 validator: (val) => val?.length == 0 ? 'Enter LastName' : null,
//                 onSaved: (val) => this.lastname = val!,
//               ),
//               TextFormField(
//                 keyboardType: TextInputType.phone,
//                 decoration: InputDecoration(labelText: 'Mobile No'),
//                 validator: (val) => val?.length == 0 ? 'Enter Mobile No' : null,
//                 onSaved: (val) => this.mobileno = val!,
//               ),
//               Container(
//                 margin: const EdgeInsets.only(top: 10.0),
//                 child: ElevatedButton(
//                   onPressed: _submit,
//                   child: Text('Save Employee'),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _submit() {
//     if (this.formKey.currentState!.validate()) {
//       formKey.currentState!.save();
//     } else {
//       return null;
//     }

//     final employee = new Employee(
//       firstName: firstname,
//       lastName: lastname,
//       mobileNo: mobileno,
//     );

//     var dbHelper = DBHelper();
//     dbHelper.saveEmployee(employee);
//     _showSnackBar("Data saved successfully");

//     // Clear the input fields
//     setState(() {
//       firstname = '';
//       lastname = '';
//       mobileno = '';
//     });
//   }

//   void _showSnackBar(String text) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(text)),
//     );
//   }

//   void navigateToEmployeeList() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => MyEmployeeList()),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:pegawai/database/dbhelper.dart';
import 'package:pegawai/model/employee.dart';
import 'package:pegawai/employeelist.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFLite DataBase Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Employee employee = new Employee(firstName: '', lastName: '', mobileNo: '');

  late String firstname;
  late String lastname;
  late String mobileno;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Saving Employee'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.view_list),
            tooltip: 'Next choice',
            onPressed: () {
              navigateToEmployeeList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (val) => val?.length == 0 ? "Enter FirstName" : null,
                onSaved: (val) => this.firstname = val!,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (val) => val?.length == 0 ? 'Enter LastName' : null,
                onSaved: (val) => this.lastname = val!,
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'Mobile No'),
                validator: (val) => val?.length == 0 ? 'Enter Mobile No' : null,
                onSaved: (val) => this.mobileno = val!,
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                  onPressed: _submit,
                  child: Text('Save Employee'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (this.formKey.currentState!.validate()) {
      formKey.currentState!.save();
    } else {
      return null;
    }

    final employee = new Employee(
      firstName: firstname,
      lastName: lastname,
      mobileNo: mobileno,
    );

    var dbHelper = DBHelper();
    dbHelper.saveEmployee(employee);
    _showSnackBar("Data saved successfully");

    // Clear the input fields
    setState(() {
      firstname = '';
      lastname = '';
      mobileno = '';
    });

    // Navigate to MyEmployeeList after showing snackbar
    Future.delayed(Duration(seconds: 2), () {
      navigateToEmployeeList();
    });
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  void navigateToEmployeeList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyEmployeeList()),
    );
  }
}
