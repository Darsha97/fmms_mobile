import 'package:mongo_dart/mongo_dart.dart';
import 'package:fmms_mobile_app/models/user.dart';
import 'dart:developer';

class MongoDatabase {
  static var db, userCollection;

  static connect() async {
    db = await Db.create("mongodb+srv://facultymaintenance:fmms123@fmms.zwouah7.mongodb.net/fmms?retryWrites=true&w=majority&tls=true&tlsAllowInvalidCertificates=true>");
    await db.open();
    userCollection = db.collection('users');
  }

  static Future<String> insert(User user) async {
    try {
      await userCollection.insertOne(user.toMap());
      return "User added successfully";
    } catch (e) {
      return "Error: $e";
    }
  }

  static Future<User?> getUserByRegNoAndPassword(String regNo, String password) async {
    var user = await userCollection.findOne(where.eq('regNo', regNo).eq('password', password));
    if (user != null) {
      return User.fromMap(user);
    }
    return null;
  }
}
