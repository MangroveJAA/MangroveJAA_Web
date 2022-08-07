import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mjaa_web/base/networking/_index.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app/router/app_pages.dart';
import 'app/ui/widgets/_index.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  setPathUrlStrategy();
  runApp(
    GetMaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),
      scrollBehavior: MyBehavior(),
      debugShowCheckedModeBanner: false,
      title: "Mangrove Jembatan Api-Api",
      initialRoute: Pages.MAIN,
      getPages: Pages.routes,
      // navigatorObservers: [AnalyticsService().getAnalyticsObserver()],
    ),
  );
}

Future<void> _injectDependency() async {
  // Services di inject saat dibutuhkan saja .
  Get.lazyPut<HttpService>(() => HttpService());

  // Repo
}
