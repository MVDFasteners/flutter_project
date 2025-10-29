import 'package:flatten/controllers/auth/login_controller.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  LoginController ctrl = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Center(
        child: InkWell(
          onTap: () async {
            await ctrl.loginToERPNext();
          },
          child: const Text("First Screen"),
        ),
      ),
    );
  }
}
