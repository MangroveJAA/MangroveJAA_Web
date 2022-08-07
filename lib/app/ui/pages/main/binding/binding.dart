import 'package:get/get.dart';

import '../controller/controller.dart';


class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
    );
  }
}
