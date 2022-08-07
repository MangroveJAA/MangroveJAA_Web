import 'package:mjaa_web/app/router/app_pages.dart';
import 'package:mjaa_web/base/lifecycle/_index.dart';

class GalleryController extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  goToHome() {
    Get.toNamed(Pages.MAIN);
  }

  goToAbout() {
    Get.toNamed(Pages.ABOUT);
  }
}