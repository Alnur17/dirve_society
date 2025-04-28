import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';

class MyPostView extends GetView {
  const MyPostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                child: SizedBox(
                  height: 240,
                  width: double.infinity,
                  child: Image.asset(
                    AppImages.coverImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 40,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                      decoration: ShapeDecoration(
                        shape: CircleBorder(),
                        color: AppColors.black.withOpacity(0.3),
                      ),
                      child: Image.asset(
                        AppImages.back,
                        scale: 4,
                      )),
                ),
              ),
              // Positioned(
              //   right: 20,
              //   top: 40,
              //   child: GestureDetector(
              //     onTap: () {},
              //     child: Container(
              //       padding: EdgeInsets.all(8),
              //       decoration: ShapeDecoration(
              //         shape: CircleBorder(),
              //         color: AppColors.black.withOpacity(0.3),
              //       ),
              //       child: Image.asset(
              //         AppImages.menu,
              //         scale: 4,
              //         color: AppColors.white,
              //       ),
              //     ),
              //   ),
              // ),
              Positioned(
                bottom: -50,
                left: 20,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.white,
                  backgroundImage: AssetImage(AppImages.carImageFive),
                ),
              ),
              Positioned(
                right: 20,
                left: Get.width * 0.365,
                bottom: -80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nissan R35 GTR',
                      style: h1.copyWith(
                        fontSize: 20,
                        color: AppColors.darkRed,
                      ),
                    ),
                    sh5,
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 20,
                          color: AppColors.darkRed,
                        ),
                        sw5,
                        Text(
                          '4.7',
                          style: h6,
                        ),
                      ],
                    ),
                    sh5,
                    Text(
                      '5.0L V8 • 460HP • Custom Exhaust Clean, powerful, and ready to roar. Only 38k miles. DM to take it for a spin!',
                      style: h6,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    )
                    // ReadMoreText(
                    //   '5.0L V8 • 460HP • Custom Exhaust Clean, powerful, and ready to roar. Only 38k miles. DM to take it for a spin!',
                    //   trimLines: 2,
                    //   trimMode: TrimMode.Line,
                    //   trimCollapsedText: 'Show More',
                    //   trimExpandedText: ' Show Less',
                    //   style: h6,
                    //   moreStyle: h6.copyWith(
                    //     color: AppColors.grey,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    //   lessStyle: h6.copyWith(
                    //     color: AppColors.grey,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
                  ],
                ),
              ),
              Positioned(
                left: 20,
                bottom: -60,
                right: Get.width * 0.67,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.orange[600],
                  ),
                  child: Center(
                    child: Text(
                      '190 Points',
                      style: h6,
                    ),
                  ),
                ),
              ),
            ],
          ),
          sh87,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'My Post',
              style: h1.copyWith(fontSize: 20),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                padding: EdgeInsets.only(
                  top: 12,
                  bottom: 75,
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
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.darkRed,
          child: Icon(
            Icons.add,
            size: 32,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
