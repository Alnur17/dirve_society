import 'package:dirve_society/app/modules/club/views/club_view.dart';
import 'package:dirve_society/app/modules/profile/controllers/my_club_controller.dart';
import 'package:dirve_society/app/modules/profile/views/create_club_view.dart';
import 'package:dirve_society/common/widgets/custom_button.dart';
import 'package:dirve_society/get_storage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/helper/group_card.dart';
import '../../../../common/size_box/custom_sizebox.dart';

class MyClubsView extends StatefulWidget {
  const MyClubsView({super.key});

  @override
  State<MyClubsView> createState() => _MyClubsViewState();
}

class _MyClubsViewState extends State<MyClubsView> {
  final MyClubController myClubController = Get.put(MyClubController());

  @override
  void initState() {
    myClubController.getMyClub();
    super.initState();
  }

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
                  child: Image.network(
                    StorageUtil.getData(StorageUtil.profileCoverPhoto)!,
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
                  backgroundImage: NetworkImage(
                      StorageUtil.getData(StorageUtil.profilePhotoUrl)!),
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
                      '${StorageUtil.getData(StorageUtil.profileName)}',
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
                          '${StorageUtil.getData(StorageUtil.profileAvgRating)}',
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
                  '${StorageUtil.getData(StorageUtil.profileBio)}',
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
                    Get.to(() => CreateClubView());
                  },
                  imageAssetPath: AppImages.add,
                  iconColor: AppColors.white,
                ),
              ],
            ),
          ),
          GetBuilder<MyClubController>(builder: (controller) {
            if (myClubController.inProgress) {
              return const Center(child: CircularProgressIndicator());
            }
            return Expanded(
              child: GridView.builder(
                padding:
                    EdgeInsets.only(top: 12, bottom: 20, left: 20, right: 20),
                shrinkWrap: true,
                //primary: false,
                itemCount: controller.myClubList?.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 210,
                ),
                itemBuilder: (context, index) => GroupCard(

                  ontap: () {
                    Get.to(() => ClubView());
                  },
                  imageUrl: controller.myClubList?[index].profilePhoto ?? '',
                  title: controller.myClubList?[index].name ?? 'Nissan R35 GTR',
                  memberCount:
                      '${controller.myClubList?[index].member ?? 0} Members',
                  isPublic: true,
                  isJoined: false,
                  showButton: false,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
