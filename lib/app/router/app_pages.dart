
import 'package:get/get.dart';
import 'package:mjaa_web/app/ui/pages/about/binding/binding.dart';
import 'package:mjaa_web/app/ui/pages/about/view/view.dart';
import 'package:mjaa_web/app/ui/pages/gallery/binding/binding.dart';
import 'package:mjaa_web/app/ui/pages/gallery/view/view.dart';
import 'package:mjaa_web/app/ui/pages/main/binding/binding.dart';
import 'package:mjaa_web/app/ui/pages/main/view/view.dart';

part 'app_routers.dart';

class Pages {
  Pages._();

  static const MAIN = Routes.MAIN;
  static const ABOUT = Routes.ABOUT;
  static const GALLERY = Routes.GALLERY;

  static final routes = [
    GetPage(
      name: _Paths.MAIN,
      page: () => MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => AboutView(),
      binding: AboutBinding(),
    ),
    GetPage(
      name: _Paths.GALLERY,
      page: () => GalleryView(),
      binding: GalleryBinding(),
    ),
  ];
}
