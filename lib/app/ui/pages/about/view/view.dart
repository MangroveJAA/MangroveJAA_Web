import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mjaa_web/base/resource/_index.dart';

import '../controller/controller.dart';


class AboutView extends GetView<AboutController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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

  _buildTabMenu() {
    return Container(
      width: Get.width,
      height: 85,
      color: colorDarkBlue,
      padding: EdgeInsets.only(top: Get.height * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTabItem(
            title: 'Home',
            isShow: false,
            onTap: () {
              controller.goToHome();
            }
          ),
          SizedBox(width: Get.width * 0.025,),
          _buildTabItem(
            title: 'About',
            isShow: true,
            onTap: () {
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