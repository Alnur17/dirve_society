// ignore_for_file: avoid_print

import 'package:dirve_society/app/modules/home/model/all_feed_model.dart';
import 'package:dirve_society/get_storage.dart';
import 'package:dirve_society/services/network_caller/network_caller.dart';
import 'package:dirve_society/services/network_caller/network_response.dart';
import 'package:dirve_society/urls.dart';
import 'package:get/get.dart';

class AllFeedController extends GetxController {
  final NetworkCaller networkCaller = Get.put(NetworkCaller());

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<AllFeedItemModel> postList = [];
  List<AllFeedItemModel> get allPostList => postList;

  String? _otpToken;
  String? get otpToken => _otpToken;

  final int _limit = 5;
  int page = 0;

  int? lastPage;

  @override
  void onInit() {
    getAllFeed();
    super.onInit();
  }

  Future<bool> getAllFeed() async {
    if (_inProgress) {
      return false;
    }
    page++;

    if (lastPage != null && page > lastPage!) return false;

    bool isSuccess = false;

    _inProgress = true;
    update();

    Map<String, dynamic> queryParams = {'limit': _limit, 'page': page};
    final NetworkResponse response = await networkCaller.getRequest(
      Urls.allfeedUrl,
      queryParams: queryParams,
      accesToken: StorageUtil.getData(StorageUtil.userAccessToken),
    );

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;

      AllFeedModel allFeedModel = AllFeedModel.fromJson(response.responseData);
      postList.addAll(allFeedModel.data);

      if (allFeedModel.meta?.totalPage != null) {
        lastPage = allFeedModel.meta!.totalPage;
      }

      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  void updatePostLike(String postId, bool isLiked, int likeCount) {
    int index = postList.indexWhere((post) => post.id == postId);
    if (index != -1) {
      final post = postList[index];
      postList[index] = AllFeedItemModel(
        hideBy: post.hideBy,
        id: post.id,
        author: post.author,
        club: post.club,
        content: post.content,
        description: post.description,
        tags: post.tags,
        contentMeta: ContentMeta(
          id: post.contentMeta?.id,
          like: likeCount,
          likeBy: post.contentMeta?.likeBy ?? [],
          comment: post.contentMeta?.comment,
        ),
        isDeleted: post.isDeleted,
        createdAt: post.createdAt,
        updatedAt: post.updatedAt,
        isLiked: isLiked,
        isVisible: post.isVisible,
        isFavorite: post.isFavorite,
        isHide: post.isHide,
      );
      update();
    }
  }

  void updatePostSave(String postId, bool isSaved) {
    int index = postList.indexWhere((post) => post.id == postId);
    if (index != -1) {
      final post = postList[index];
      postList[index] = AllFeedItemModel(
        hideBy: post.hideBy,
        id: post.id,
        author: post.author,
        club: post.club,
        content: post.content,
        description: post.description,
        tags: post.tags,
        contentMeta: post.contentMeta,
        isDeleted: post.isDeleted,
        createdAt: post.createdAt,
        updatedAt: post.updatedAt,
        isLiked: post.isLiked,
        isVisible: post.isVisible,
        isFavorite: isSaved,
        isHide: post.isHide,
      );
      update();
    }
  }

  void updatePostUnSave(String postId, bool isSaved) {
    // Note: This method seems redundant with updatePostSave; consider merging or clarifying use case
    updatePostSave(postId, isSaved);
  }

  void updatePostHide(String postId, bool isHidden) {
    int index = postList.indexWhere((post) => post.id == postId);
    if (index != -1) {
      final post = postList[index];
      postList[index] = AllFeedItemModel(
        hideBy: post.hideBy,
        id: post.id,
        author: post.author,
        club: post.club,
        content: post.content,
        description: post.description,
        tags: post.tags,
        contentMeta: post.contentMeta,
        isDeleted: post.isDeleted,
        createdAt: post.createdAt,
        updatedAt: post.updatedAt,
        isLiked: post.isLiked,
        isVisible: post.isVisible,
        isFavorite: post.isFavorite,
        isHide: isHidden,
      );
      update();
    }
  }

  void updateFollowStatus(String userId, bool isFollowingNow) {
    print('Update follow status for userId: $userId');
    if (postList.isEmpty) {
      print('postList is empty');
      return;
    }

    bool updated = false;
    for (int index = 0; index < postList.length; index++) {
      final post = postList[index];
      if (post.author?.id == userId) {
        postList[index] = AllFeedItemModel(
          hideBy: post.hideBy,
          id: post.id,
          author: post.author,
          club: post.club,
          content: post.content,
          description: post.description,
          tags: post.tags,
          contentMeta: post.contentMeta,
          isDeleted: post.isDeleted,
          createdAt: post.createdAt,
          updatedAt: post.updatedAt,
          isLiked: post.isLiked,
          isVisible: post.isVisible,
          isFavorite: post.isFavorite,
          isHide: post.isHide,
        );
        updated = true;
      }
    }

    if (updated) {
      print('Post(s) updated successfully for userId: $userId');
      update();
    } else {
      print('No posts found for userId: $userId');
    }
  }
}