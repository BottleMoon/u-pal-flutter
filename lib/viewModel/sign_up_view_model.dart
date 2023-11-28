import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SignUpViewModel with ChangeNotifier {
  bool isEmailSent = false;
  bool? isCodeCorrect = null;
  bool isEmailDuplicate = false;
  int sendCount = 0;
  int checkCount = 0;
  final Dio dio = Dio();

  Future<bool> sign_up(String email, String password, String nickName, int age,
      String country) async {
    Map<String, dynamic> data = {
      "email": email,
      "password": password,
      "nickName": nickName,
      "age": age,
      "country": country
    };
    try {
      Response res =
      await dio.post(dotenv.env["SIGN_UP_URL"] as String, data: data);
      print(res.data);
      return true;
    } on DioException catch (e) {
      return false;
    }
  }

  sendEmail(String email) async {
    sendCount++;
    try {
      var res = await dio
          .post(dotenv.env["SEND_EMAIL_URL"] as String, data: {"email": email});
      if (res.statusCode == HttpStatus.ok) {
        isEmailSent = true;
      }
    } on DioException catch (e) {
      if (e.response?.data["message"] == "EMAIL_DUPLICATE") {
        print("duplicate");
        isEmailDuplicate = true;
      }
    }
    //TODO: try catch로 이메일 중복 확인 여부 불러오기.
    notifyListeners();
  }

  authenticateEmail(String email, String code) async {
    Map<String, dynamic> data = {"email": email, "code": code};
    try {
      var res = await dio.post(dotenv.env["AUTHENTICATE_EMAIL_URL"] as String,
          data: data);
      if (res.statusCode == HttpStatus.ok) {
        isCodeCorrect = true;
      }
    } on DioException catch (e) {
      print(e.message);
      isCodeCorrect = false;
    }
    notifyListeners();
  }
}
