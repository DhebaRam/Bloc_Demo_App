import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:untitled/auth/bloc/login_bloc.dart';
import 'package:untitled/mongo_db_screen/model/data_model.dart';

import '../../product/models/product_list_model.dart';
import 'db_helper.dart';

class MongodbDataBase {
  static var db, userCollection;

  static connect() async {
    db = await Db.create(mangoConnUrl);
    log('mongodb Data Base Connect ----->');
    await db.open();
    inspect(db);
    // userCollection = db.collection(userCollectionName);
    log('userCollection --- >  $userCollection');
  }

  static Future<String> insert(School data) async {
    try {
      userCollection = db.collection(userCollectionName);
      var result = await userCollection.insert(data.toJson());
      log('message---- >  ${result}');
      if (result.isSuccess) {
        return "Data Inserted";
      } else {
        return "Something went while inserting wrong";
      }
    } catch (e) {
      log('Catch ----> ${e.toString()}');
      return e.toString();
    }
  }

  static Future<WriteResult> createUser(CreateUserModel data) async {
    try {
      DbCollection userCollection = db.collection(userDataTableCollection);
      await userCollection.createIndex(keys: {"userEmail": 1}, unique: true);
      WriteResult result = await userCollection.insertOne(data.toJson());
      return result;
    } catch (e) {
      log('Create User Result ----> ${e.toString()}');
      throw e.toString();
    }
  }

  static Future<Map<String, dynamic>?> loginUser(LoginAuthEvent event) async {
    Map<String, dynamic>? result;
    // final loginUserModel = LoginUserModel(
    //     userEmail: event.userEmail.trim(),
    //     userName: '',
    //     userPhone: '',
    //     userPassword: event.password.trim(),
    //     userProfileImage: '');
    try {
      DbCollection userCollection = db.collection(userDataTableCollection);
      var userFromDb =
          await userCollection.findOne({'userEmail': event.userEmail});
      print('userFromDb ----> ${userFromDb}');
      print('userFromDb ----> ${userFromDb?['userPassword']}');
      if (userFromDb != null) {
        if (verifyPassword(event.password, userFromDb['userPassword'])) {
          result = {'message': 'Login Successful', 'status': true};
        } else {
          result = {'message': 'Password is Not Match', 'status': false};
        }
      } else {
        result = {'message': 'Record not found', 'status': false};
      }
      print('REs---- ${result}');
      print('REs---- ${result['message']}');
      return result;
    } catch (e) {
      log('Create User Result ----> ${e.toString()}');
      throw e.toString();
    }
  }

  static bool verifyPassword(String password, userFromDb) {
    if (password == userFromDb) {
      return true;
    }
    return false;
  }

  //Product Insert
  static Future<String> insertProduct(ProductModel data) async {
    try {
      // Check if the collection exists
      final collectionExists = await db.collection(productDataTableCollection);
      print('collectionExists ---- ${collectionExists.db.isConnected}');
      if (collectionExists.db.isConnected) {
        userCollection = await db.collection(productDataTableCollection);
      } else {
        await db.createCollection(productDataTableCollection);
        userCollection = await db.collection(productDataTableCollection);
      }
      print(
          'da--- ${data.category} .. ${data.title} ... ${data.price} .. ${data.id} ... ${data.description} ... ${data.rating}');

      var result = await userCollection.insertOne(data.toJson());
      log('message---- >  ${result}');
      if (result.isSuccess) {
        return "Data Inserted";
      } else {
        return "Something went while inserting wrong";
      }
    } catch (e) {
      log('Catch ----> ${e.toString()}');
      return e.toString();
    }
  }

  static Future<Map<String, dynamic>> fetchProduct() async {
    Map<String, dynamic>? resultData;
    try {
      // Check if the collection exists
      DbCollection collectionExists =
          await db.collection(productDataTableCollection);
      print('collectionExists ---- ${collectionExists.db.isConnected}');
      if (collectionExists.db.isConnected) {
        userCollection = await db.collection(productDataTableCollection);
      } else {
        await db.createCollection(productDataTableCollection);
        userCollection = await db.collection(productDataTableCollection);
      }

      List<Map<String, Object?>> result = await userCollection.find().toList();
      print('resultresult.... ${result}');
      if (result.isNotEmpty) {
        resultData = {
          'message': 'Successful Fetch',
          'data': result,
          'status': true
        };
      } else {
        resultData = {
          'message': 'No Data Found',
          'data': '',
          'status': false
        };
      }
      return resultData;
    } catch (e) {
      log('Catch ----> ${e.toString()}');
      throw e.toString();
    }
  }
}
