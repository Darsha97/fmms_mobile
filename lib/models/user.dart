import 'package:mongo_dart/mongo_dart.dart';

class User {
  ObjectId id;
  String fullName;
  String email;
  String regNo;
  String password;
  String confirmPassword;
  String contactNumber;
  String role;
  String department;
  String status;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.regNo,
    required this.password,
    required this.confirmPassword,
    required this.contactNumber,
    required this.role,
    required this.department,
    required this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: ObjectId.parse(json['_id'] as String),
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      regNo: json['regNo'] as String,
      password: json['password'] as String,
      confirmPassword: json['confirmPassword'] as String,
      contactNumber: json['contactNumber'] as String,
      role: json['role'] as String,
      department: json['department'] as String,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id.toHexString(),
      'fullName': fullName,
      'email': email,
      'regNo': regNo,
      'password': password,
      'confirmPassword': confirmPassword,
      'contactNumber': contactNumber,
      'role': role,
      'department': department,
      'status': status,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id.toHexString(),
      'fullName': fullName,
      'email': email,
      'regNo': regNo,
      'password': password,
      'confirmPassword': confirmPassword,
      'contactNumber': contactNumber,
      'role': role,
      'department': department,
      'status': status,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as ObjectId,
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      regNo: map['regNo'] as String,
      password: map['password'] as String,
      confirmPassword: map['confirmPassword'] as String,
      contactNumber: map['contactNumber'] as String,
      role: map['role'] as String,
      department: map['department'] as String,
      status: map['status'] as String,
    );
  }
}
