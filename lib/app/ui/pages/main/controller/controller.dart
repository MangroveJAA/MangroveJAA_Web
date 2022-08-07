import 'package:mjaa_web/app/router/app_pages.dart';
import 'package:mjaa_web/base/lifecycle/_index.dart';

class MainController extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  goToAbout() {
    Get.toNamed(Pages.ABOUT);
  }

  goToHome() {
    Get.toNamed(Pages.MAIN);
  }

  goToGallery() {
    Get.toNamed(Pages.GALLERY);
  }
}