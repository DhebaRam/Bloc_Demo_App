import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:untitled/auth/bloc/login_bloc.dart';
import 'package:untitled/auth/ragister_bloc/register_bloc.dart';
import 'package:untitled/mongo_db_screen/model/data_model.dart';

import '../../api_manager/api_manager.dart';
import '../../api_manager/api_model.dart';
import '../../mongo_db/dbHelper/mongo_db_connect.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class AuthRepos {
  APIManager apiManager = APIManager();

  Future<ApiResponseModel> authLogin(Map<String, dynamic> map) async {
    const url = 'https://fakestoreapi.com/auth/login';
    final response = await apiManager.request(url, Method.post, map);
    log('API Response in Repo File ---- > ${response.data}');
    if (response.status) {
      return response;
    } else {
      log('API Response in Repo File ---- > ${response.data}');
      throw response.error?.title ?? 'Something went wrong! Please try again';
    }
  }

  Future<ApiResponseModel> fetchSingleProduct(String id) async {
    final url = 'https://fakestoreapi.com/products/$id';
    final response = await apiManager.request(url, Method.get, {});
    log('API Response in Repo File ---- > ${response.data}');
    if (response.status) {
      return response;
    } else {
      log('API Response in Repo File ---- > ${response.data}');
      throw response.error?.title ?? 'Something went wrong! Please try again';
    }
  }

  Future<WriteResult> registerUser(RegisterUserDataEvent event) async {
    final createUserModel = CreateUserModel(M.ObjectId(),
        userEmail: event.userEmail.trim(),
        userName: event.userName.trim(),
        userPhone: event.userPhone.trim(),
        userPassword: event.userPassword.trim(),
        userProfileImage: []);
    try {
      WriteResult result = await MongodbDataBase.createUser(createUserModel);
      return result;
    } catch (e) {
      log(e.toString());
      throw e.toString();
    }
  }

  Future<Map<String, dynamic>?> loginUser(LoginAuthEvent event) async {
    try {
      final result = await MongodbDataBase.loginUser(event);
      return result;
    } catch (e) {
      log(e.toString());
      throw e.toString();
    }
  }
}
