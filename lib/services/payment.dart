import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:giki_tuc/controllers/dark_theme_controller.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    final darkThemeController = Get.find<DarkThemeController>();
    return Scaffold(
      backgroundColor: darkThemeController.darkMode.value? Colors.black:Colors.white,
    );
  }
}
