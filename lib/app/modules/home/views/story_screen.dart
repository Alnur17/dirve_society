import 'dart:async';
import 'package:dirve_society/app/modules/home/controllers/specific_user_story_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class StoryScreen extends StatefulWidget {
  final String userId;
  const StoryScreen({super.key, required this.userId});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen>
    with AutomaticKeepAliveClientMixin {
  // final List<String> storyImages = [
  //   'https://fastly.picsum.photos/id/221/200/300.jpg?hmac=vFrrajnPFCrr5ttjepVTsUDWzoo-orpnXOsqdqAd0LU',
  //   'https://fastly.picsum.photos/id/884/200/300.jpg?hmac=VnWK-J-znCMSx2FSelz3LtT1DXhrxRLtzsX6-hkZDJk',
  //   'https://fastly.picsum.photos/id/906/200/200.jpg?hmac=jQ-m5xgglMRMPvZhK3539qEkxPG1FVUae6AeV_HKQfg',
  // ];

  final GetStoryController getStoryController = Get.put(GetStoryController());

  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    getStoryController.getSpecificStory(widget.userId);
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      var l = getStoryController.specificStoryModel!.data!.user!.stories.length;
      if (_currentPage < l - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<GetStoryController>(builder: (controller) {
              if (controller.inProgress) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount:
                    controller.specificStoryModel!.data!.user?.stories.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(controller.specificStoryModel?.data!
                                .user?.stories[index].content ??
                            ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.specificStoryModel!.data
                                                ?.user?.name ??
                                            '',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                      Text(
                                        '9h',
                                        style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                controller.specificStoryModel!.data!.user
                                        ?.stories[index].text ??
                                    '',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
