import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mjaa_web/base/resource/_index.dart';

import '../controller/controller.dart';


class MainView extends GetView<MainController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Stack(
          children: [
            Container(
              width: Get.width,
              height: Get.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.imgMainBg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Mangrove',
                      style: AppStyles.textStyleDefault(
                        size: 60,
                        color: Colors.amber,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    Text('Jembatan Api-Api',
                      style: AppStyles.textStyleDefault(
                        size: 45,
                        color: colorWhite,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Text('Kulon Progo',
                          style: AppStyles.textStyleDefault(
                            size: 20,
                            color: Colors.amber,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text('| The Jewel of Java',
                          style: AppStyles.textStyleDefault(
                            size: 20,
                            color: colorWhite,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.1,),
                    _buttonToLocation()
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: _buildTabMenu(),
            )
          ],
        ),
      )
    );
  }

  _buttonToLocation() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.amber, width: 2),
      ),
      child: Text(
        'Menuju Lokasi',
        style: AppStyles.textStyleDefault(
          size: 20,
          color: colorBlack,
          fontWeight: FontWeight.w700
        ),
      ),
    );
  }

  _buildTabMenu() {
    return Container(
      margin: EdgeInsets.only(top: Get.height * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTabItem(
            title: 'Home',
            isShow: true,
            onTap: () {}
          ),
          SizedBox(width: Get.width * 0.025,),
          _buildTabItem(
            title: 'About',
            isShow: false,
            onTap: () {
              controller.goToAbout();
            }
          ),
          SizedBox(width: Get.width * 0.025,),
          _buildTabItem(
            title: 'Gallery',
            isShow: false,
            onTap: () {
              controller.goToGallery();
            }
          ),
        ],
      ),
    );
  }
  
  _buildTabItem({
    required String title,
    required VoidCallback onTap,
    bool isShow = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            title,
            style: AppStyles.textStyleDefault(
              size: 20,
              color: isShow ? Colors.amber : colorWhite,
              fontWeight: FontWeight.w700
            ),
          ),
          const SizedBox(height: 5,),
          isShow ? Container(
            width: 70,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(50),
            ),
          ) : const SizedBox()
        ],
      ),
    );
  }
}