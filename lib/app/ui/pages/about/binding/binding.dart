import 'package:get/get.dart';

import '../controller/controller.dart';


class AboutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutController>(
      () => AboutController(),
    );
  }
}
