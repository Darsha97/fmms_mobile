import 'package:fmms_mobile_app/models/user.dart';
import 'package:fmms_mobile_app/models/request.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'dart:developer';

class MongoDatabase {
  static Db? db;
  static final String userCollectionName = 'users';
  static final String maintenanceCollectionName = 'maintenancerequests';

  static Future<void> connect() async {
    try {
      String connectionString = 'mongodb+srv://facultymaintenance:fmms123@fmms.zwouah7.mongodb.net/test?retryWrites=true&w=majority&tls=true&tlsAllowInvalidCertificates=true';

      db = await Db.create(connectionString);
      await db!.open();
      inspect(db);
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> close() async {
    try {
      await db!.close();
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<User?> login(String username, String password) async {
    try {
      // Ensure that the database connection is established
      if (db == null) {
        await connect();
      }

      var userCollection = db!.collection(userCollectionName);
      var userDoc = await userCollection.findOne({'regNo': username, 'password': password});

      if (userDoc != null) {
        // Return the user object if the user exists
        return User.fromJson(userDoc); // Assuming User has a fromJson constructor
      } else {
        // Return null if the user does not exist or the credentials are incorrect
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null; // Return null in case of any error
    }
  }

  static Future<String> insert(User data) async {
    try {
      // Ensure that the database connection is established
      if (db == null) {
        await connect();
      }

      var userCollection = db!.collection(userCollectionName);
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Sign Up Successful";
      } else {
        return "Sign Up Failed.";
      }
    } catch (e) {
      print(e.toString());
      return "Sign Up Failed.";
    }
  }

  static Future<String> insertMaintenanceRequest(MaintenanceRequest request) async {
    try {
      if (db == null) {
        await connect();
      }

      var maintenanceCollection = db!.collection(maintenanceCollectionName);
      var result = await maintenanceCollection.insertOne(request.toJson());
      if (result.isSuccess) {
        return "Maintenance Request Added Successfully";
      } else {
        return "Failed to add Maintenance Request";
      }
    } catch (e) {
      log(e.toString());
      return "Failed to add Maintenance Request";
    }
  }


  static Future<List<Map<String, dynamic>>> getRequestDetailsByUser(String userId) async {
    try {
      if (db == null) {
        await connect();
      }

      var requests = await db!
          .collection('maintenance_requests')
          .find(where.eq('submittedBy', userId))
          .toList();

      return requests.map((request) => request as Map<String, dynamic>).toList();
    } catch (e) {
      log(e.toString());
      return [];
    } finally {
      if (db != null) {
        await db!.close();
      }
    }
  }

  static Future<String?> getUserId(String email) async {
    try {
      if (db == null) {
        await connect();
      }

      final userCollection = db!.collection(userCollectionName);
      final user = await userCollection.findOne(where.eq('email', email));

      if (user != null) {
        return user['_id'].toString();
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
