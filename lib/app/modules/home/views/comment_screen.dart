// ignore_for_file: deprecated_member_use

import 'package:dirve_society/app/modules/home/controllers/comment_controller.dart';
import 'package:dirve_society/app/modules/home/controllers/send_comment_controller.dart';
import 'package:dirve_society/app/modules/profile/controllers/profile_controller.dart';
import 'package:dirve_society/common/widgets/custom_snackbar_widget.dart';
import 'package:dirve_society/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentScreen extends StatefulWidget {
  final String postId;
  final String postType;
  const CommentScreen(
      {super.key, required this.postId, required this.postType});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  // AllPostController allPostController = Get.put(AllPostController());
  ProfileController profileController = Get.put(ProfileController());

  final CommentController commentController = Get.put(CommentController());
  final SendCommentController sendCommentController =
      Get.put(SendCommentController());
  final TextEditingController commentCtrl = TextEditingController();
  final TextEditingController replyCtrl = TextEditingController();
  int? selectedCommentIndex; // নতুন স্টেট ভেরিয়েবল

  @override
  void initState() {
    // profileController.getMyProfile();
    commentController.getAllComment(widget.postId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () {
                  Get.back();
                }, icon: Icon(Icons.arrow_back_ios)),
                Center(
                    child: Text(
                  'All Comment',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                )),
                Container(width: 60,)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: GetBuilder<CommentController>(builder: (cController) {
                print(
                    "Comment Data: ${cController.commentData?.length}"); // ডিবাগ
                if (cController.inProgress) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (cController.commentData == null ||
                    cController.commentData!.isEmpty) {
                  return const Center(
                    child: Text(
                      'No comments yet.',
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.all(0),
                  itemCount: cController.commentData?.length,
                  itemBuilder: (context, index) {
                    final comment = cController.commentData![index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(comment
                                        .user?.photoUrl ??
                                    'https://fastly.picsum.photos/id/471/200/300.jpg?hmac=N_ZXTRU2OGQ7b_1b8Pz2X8e6Qyd84Q7xAqJ90bju2WU'),
                              ),
                              //widthBox8,
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      comment.user?.name ?? '',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                    Text(
                                      comment.comment ?? '',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    if (comment.reply.isNotEmpty)
                                      Padding(
                                        padding: EdgeInsets.only(top: 5),
                                        child: ListView.builder(
                                          padding: EdgeInsets.all(0),
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: comment.reply.length,
                                          itemBuilder: (context, replyIndex) {
                                            final reply =
                                                comment.reply[replyIndex];
                                            return Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CircleAvatar(
                                                    radius: 14,
                                                    backgroundImage:
                                                        NetworkImage(reply.user
                                                                ?.photoUrl ??
                                                            'https://fastly.picsum.photos/id/471/200/300.jpg?hmac=N_ZXTRU2OGQ7b_1b8Pz2X8e6Qyd84Q7xAqJ90bju2WU'),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        reply.user?.name ?? '',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      Text(
                                                        reply.comment ?? '',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedCommentIndex = index;
                                          replyCtrl.text = '';
                                        });
                                      },
                                      child: Text(
                                        'Reply..',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (selectedCommentIndex == index &&
                            replyCtrl.text.isEmpty)
                          Padding(
                            padding: EdgeInsets.only(left: 40, top: 5),
                            child: SizedBox(
                              width: 200,
                              child: TextFormField(
                                controller: replyCtrl,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  hintText: 'Write a reply...',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                onFieldSubmitted: (value) {
                                  if (value.isNotEmpty) {
                                    sendReply(
                                      contentId: widget.postId,
                                      modelType: widget.postType == 'feed'
                                          ? 'Feed'
                                          : widget.postType == 'reels'
                                              ? 'Reels'
                                              : 'Wishlist',
                                      comment: value,
                                      isReply: true,
                                      userId: StorageUtil.getData(
                                          StorageUtil.profileId),
                                      replyRef: comment.id ?? '',
                                    );
                                    setState(() {
                                      selectedCommentIndex = null;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                );
              }),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 213, 210, 210).withOpacity(0.32),
                ),
                height: 82,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(StorageUtil.getData(
                                StorageUtil.profilePhotoUrl) ??
                            'https://fastly.picsum.photos/id/471/200/300.jpg?hmac=N_ZXTRU2OGQ7b_1b8Pz2X8e6Qyd84Q7xAqJ90bju2WU'),
                      ),
                      SizedBox(
                        width: 250,
                        child: TextFormField(
                          controller: commentCtrl,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.black),
                            fillColor: Colors.transparent,
                            hintText: 'Writes a comment',
                            contentPadding: EdgeInsets.all(10),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (commentCtrl.text.isNotEmpty) {
                            sendComment(
                                contentId: widget.postId,
                                modelType: widget.postType == 'feed'
                                    ? 'Feed'
                                    : widget.postType == 'reels'
                                        ? 'Reels'
                                        : 'Wishlist',
                                comment: commentCtrl.text,
                                isReply: false,
                                userId:
                                    StorageUtil.getData(StorageUtil.profileId));
                          }
                        },
                        child: Icon(
                          Icons.send,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendComment(
      {required String userId,
      required String modelType,
      required String contentId,
      required String comment,
      required bool isReply,
      String? repReference}) async {
    final bool isSuccess = await sendCommentController.sendComment(
        userId, modelType, contentId, comment, isReply, repReference);
    if (isSuccess) {
      //  allPostController.updatePostHide(contentId, true);
      commentController.getAllComment(contentId);
      if (mounted) {
        // showSnackBarMessage(context, 'Comment successfully posted');
        commentCtrl.clear();
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, sendCommentController.errorMessage ?? 'Failed', true);
      }
    }
  }

  Future<void> sendReply(
      {required String userId,
      required String modelType,
      required String contentId,
      required String comment,
      required bool isReply,
      required String replyRef,
      String? repReference}) async {
    if (replyRef.isEmpty) {
      if (mounted) {
        showSnackBarMessage(context, 'Reply reference is invalid!', true);
      }
      return;
    }
    final bool isSuccess = await sendCommentController.sendComment(
        userId, modelType, contentId, comment, isReply, replyRef);
    if (isSuccess) {
      commentController.getAllComment(contentId);
      if (mounted) {
        //   allPostController.updatePostHide(contentId, true);
        // showSnackBarMessage(context, 'Reply successfully posted');
        replyCtrl.clear();
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, sendCommentController.errorMessage ?? 'Failed', true);
      }
    }
  }
}
