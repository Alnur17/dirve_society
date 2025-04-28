import 'package:dirve_society/common/app_text_style/styles.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_circular_container.dart';

class SavedView extends GetView {
  const SavedView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: CustomCircularContainer(
            imagePath: AppImages.back,
            onTap: () {
              Get.back();
            },
            padding: 4,
          ),
        ),
        scrolledUnderElevation: 0,
        title:  Text('Saved',style: appBarStyle,),
        centerTitle: true,
        actions: [
          CustomCircularContainer(
            imagePath: AppImages.addCircle,
            onTap: () {
              Get.back();
            },
            //padding: 4,
          ),
          sw8,
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sh12,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'All Posts',
              style: h1.copyWith(fontSize: 20),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                padding: EdgeInsets.only(
                  top: 12,
                  bottom: 20,
                ),
                shrinkWrap: true,
                //primary: false,
                itemCount: 24,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 150,
                ),
                itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    AppImages.carImageThree,
                    scale: 4,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
