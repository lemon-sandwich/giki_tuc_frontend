import 'package:get/get.dart';

class DarkThemeController extends GetxController{
  Rx<bool> darkMode = false.obs;
  
  void brightTheme() {
    darkMode = darkMode.toggle();
  }
}