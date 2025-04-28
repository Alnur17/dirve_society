import 'package:dirve_society/app/modules/profile/views/create_club_view.dart';
import 'package:dirve_society/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/helper/group_card.dart';
import '../../../../common/size_box/custom_sizebox.dart';

class MyClubsView extends GetView {
  const MyClubsView({super.key});

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
              Positioned(
                bottom: -25,
                left: 20,
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: AppColors.white,
                  backgroundImage: AssetImage(AppImages.carImageFive),
                ),
              ),
              Positioned(
                right: 20,
                left: Get.width * 0.32,
                bottom: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nissan R35 GTR',
                      style: h1.copyWith(
                        fontSize: 20,
                        color: AppColors.darkRed,
                      ),
                    ),
                    sw8,
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 22,
                          color: AppColors.darkRed,
                        ),
                        sw5,
                        Text(
                          '4.7',
                          style: h3.copyWith(
                            color: AppColors.darkRed,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    //sh5,
                    // Text(
                    //   '5.0L V8 • 460HP • Custom Exhaust Clean, powerful, and ready to roar. Only 38k miles. DM to take it for a spin!',
                    //   style: h6,
                    //   maxLines: 3,
                    //   overflow: TextOverflow.ellipsis,
                    // )
                  ],
                ),
              ),
            ],
          ),
          sh40,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Descriptions',
                      style: h5.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.orange[600],
                      ),
                      child: Center(
                        child: Text(
                          '190 Points',
                          style: h5,
                        ),
                      ),
                    ),
                  ],
                ),
                sh5,
                ReadMoreText(
                  '5.0L V8 • 460HP • Custom Exhaust Clean, powerful, and ready to roar. Only 38k miles. DM to take it for a spin!',
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show More',
                  trimExpandedText: ' Show Less',
                  style: h6,
                  moreStyle: h6.copyWith(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                  lessStyle: h6.copyWith(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          sh20,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Clubs',
                  style: h1.copyWith(fontSize: 20),
                ),
                CustomButton(
                  width: 160,
                  height: 38,
                  text: 'Create Club',
                  onPressed: () {
                    Get.to(()=> CreateClubView());
                  },
                  imageAssetPath: AppImages.add,
                  iconColor: AppColors.white,
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.only(
                top: 12,
                bottom: 20,
                left: 20,right: 20
              ),
              shrinkWrap: true,
              //primary: false,
              itemCount: 24,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 200,
              ),
              itemBuilder: (context, index) => GroupCard(
                title: 'SUPER CAR',
                memberCount: '10.1K Members',
                isPublic: true,
                isJoined: false,
                showButton: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
