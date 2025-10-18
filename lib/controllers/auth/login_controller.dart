import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flatten/app_constant.dart';
import 'package:flatten/controllers/my_controller.dart';
import 'package:flatten/helpers/services/auth_service.dart';
import 'package:flatten/helpers/widgets/my_form_validator.dart';
import 'package:flatten/helpers/widgets/my_validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flatten/models/user.dart';

class LoginController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();

  bool showPassword = false;
  bool loading = false;

  UserModel userModel = UserModel();
  String? userImage;

  final String _dummyEmail = "jayasuryaarulselvam26@gmail.com";
  final String _dummyPassword = "Mvdf@2025";

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    _fetchUser();
    basicValidator.addField(
      'email',
      required: true,
      label: "Email",
      validators: [MyEmailValidator()],
      controller: TextEditingController(text: _dummyEmail),
    );

    basicValidator.addField(
      'password',
      required: true,
      label: "Password",
      validators: [MyLengthValidator(min: 6, max: 10)],
      controller: TextEditingController(text: _dummyPassword),
    );
  }

  Future<void> _fetchUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userId = pref.getString("email");
    if (userId != null) {
      fetchUserByEmail(userId);
    }
  }

  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  Future<void> onLogin() async {
    String nextUrl =
        Uri.parse(
          ModalRoute.of(Get.context!)?.settings.name ?? "",
        ).queryParameters['next'] ??
        "/dashboard";
    Get.toNamed(nextUrl);

    // if (basicValidator.validateForm()) {
    //   loading = true;
    //   update();
    //   var errors = await AuthService.loginUser(basicValidator.getData());
    //   if (errors != null) {
    //     basicValidator.addErrors(errors);
    //     basicValidator.validateForm();
    //     basicValidator.clearErrors();
    //   } else {
    //     String nextUrl =
    //         Uri.parse(
    //           ModalRoute.of(Get.context!)?.settings.name ?? "",
    //         ).queryParameters['next'] ??
    //             "/dashboard";
    //     Get.toNamed(nextUrl);
    //   }
    //   loading = false;
    //   update();
    // }
  }

  // ===============================
  // LOGIN via Node.js Backend
  // ===============================

  Future<void> loginNodeErpnext() async {
    // if (!basicValidator.validateForm()) return;

    loading = true;
    update();

    Map<String, dynamic> data = basicValidator.getData();
    String email = data['email'];
    String password = data['password'];

    final url = Uri.parse("$backendUrl/login");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final session = body['session']; // ✅ fixed

        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString("session_id", session);
        await pref.setString("email", email);
        AuthService.sessionId = session;

        print("✅ Session stored: $session");
        await fetchUserByEmail(email);
        loading = false;
        update();
        goToDashboard();
      } else {
        loading = false;
        update();
        print('❌ Login failed: ${response.body}');
      }
    } catch (e) {
      loading = false;
      update();
      print('⚠️ Error during login: $e');
    }

    loading = false;
    update();
  }

  Future<void> fetchUserByEmail(String email) async {
    if (AuthService.sessionId == null) {
      print("❌ No session found. Please login first.");
      return;
    }

    final url = Uri.parse("$backendUrl/get_user");

    final Map<String, dynamic> body = {
      'cookie': AuthService.sessionId,
      'email': email,
    };

    try {
      final response = await http.post(
        url,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data.containsKey('error')) {
          print("❌ Error: ${data['error']}");
          return;
        }

        // Create User model from JSON
        userModel = UserModel.fromJson(data);
        await fetchImageBase64();

        print(
          "User fetched: ${userModel!.stockUser}, ${userModel!.accountUser}, ${userModel!.company}, ${userModel!.image}",
        );

        update(); // if inside GetX controller
      } else {
        print("❌ HTTP Error ${response.statusCode}: ${response.body}");
      }
    } on SocketException {
      print("⚠️ Connection Error: Cannot reach backend ($backendUrl)");
    } catch (e) {
      print("⚠️ Unexpected Error: ${e.toString()}");
    }
  }

  Future<void> fetchImageBase64() async {
    String? imagePath = userModel.image;
    String? sessionId = AuthService.sessionId;

    if (sessionId != null && imagePath != null) {
      final url = Uri.parse(
        "$backendUrl/user_image_base64?image_path=$imagePath&cookie=$sessionId",
      );

      print("url$url");
      try {
        final response = await http.get(url);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          userImage = data['image_base64'];
          update();
        }
      } catch (e) {
        print("Error fetching image: $e");
      }
    }
  }

  void goToForgotPassword() {
    Get.toNamed('/auth/forgot_password');
  }

  void gotoRegister() {
    Get.toNamed('/auth/register');
  }

  void goToDashboard() {
    Get.toNamed('/default');
  }
}
