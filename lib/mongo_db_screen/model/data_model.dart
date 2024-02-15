import 'package:mongo_dart/mongo_dart.dart';

class Model {
  String? fullName;
  String? code;
  String? standard;
  String? section;
  String? username;
  String? password;

  Model(
      {this.fullName,
      this.code,
      this.standard,
      this.section,
      this.username,
      this.password});
}

class School {
  String? schoolName;
  String? schoolEmail;
  String? schoolPhone;
  String? schoolWebsite;

  School(
      {this.schoolName,
      this.schoolEmail,
      this.schoolPhone,
      this.schoolWebsite});

  School.fromJson(Map<String, dynamic> json) {
    schoolName = json['schoolName'];
    schoolEmail = json['schoolEmail'];
    schoolPhone = json['schoolPhone'];
    schoolWebsite = json['schoolWebsite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['schoolName'] = schoolName;
    data['schoolEmail'] = schoolEmail;
    data['schoolPhone'] = schoolPhone;
    data['schoolWebsite'] = schoolWebsite;
    return data;
  }
}

class SchoolDet {
  String? addressOne;
  String? addressTwo;
  String? city;
  String? pincode;
  String? state;

  SchoolDet(
      {this.addressOne, this.addressTwo, this.city, this.pincode, this.state});
}

class SchoolUser {
  String? username;
  String? password;

  SchoolUser({this.username, this.password});
}

class SchoolCode {
  String? principalCode;
  String? teacherCode;
  String? studentCode;

  SchoolCode({this.principalCode, this.teacherCode, this.studentCode});
}

class CreateUserModel {
  ObjectId? _id;
  String? userName;
  String? userEmail;
  String? userPhone;
  String? userPassword;
  List<int>? userProfileImage;

  CreateUserModel(this._id,
      {this.userName,
      this.userEmail,
      this.userPhone,
      this.userPassword,
      this.userProfileImage});

  CreateUserModel.fromJson(Map<String, dynamic> json) {
    _id = json['_id'];
    userName = json['userName'];
    userEmail = json['userEmail'];
    userPhone = json['userPhone'];
    userPassword = json['userPassword'];
    userProfileImage = json['userProfileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = _id;
    data['userName'] = userName;
    data['userEmail'] = userEmail;
    data['userPhone'] = userPhone;
    data['userPassword'] = userPassword;
    data['userProfileImage'] = userProfileImage;
    return data;
  }
}

class LoginUserModel {
  String? userName;
  String? userEmail;
  String? userPhone;
  String? userPassword;
  String? userProfileImage;

  LoginUserModel(
      {this.userName,
      this.userEmail,
      this.userPhone,
      this.userPassword,
      this.userProfileImage});

  LoginUserModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    userEmail = json['userEmail'];
    userPhone = json['userPhone'];
    userPassword = json['userPassword'];
    userProfileImage = json['userProfileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['userEmail'] = userEmail;
    data['userPhone'] = userPhone;
    data['userPassword'] = userPassword;
    data['userProfileImage'] = userProfileImage;
    return data;
  }
}
