class Employee {
  int? id;
  String firstName;
  String lastName;
  String mobileNo;

  Employee(
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.mobileNo});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'mobile_no': mobileNo,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      mobileNo: map['mobile_no'],
    );
  }
}
