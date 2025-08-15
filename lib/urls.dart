class Urls {
  // static const String _baseUrl = 'http://10.10.10.16:5006/api/v1';
  static const String _baseUrl = 'http://172.252.13.83:5006/api/v1';
  static const String socketUrl = 'http://172.252.13.74:4010/';
  // static const String socketUrl = 'http://192.168.10.144:4001/';
  static const String signUpUrl = '$_baseUrl/profiles/register';
  static const String otpVerifyUrl = '$_baseUrl/otp/verify-otp';
  static const String loginUrl = '$_baseUrl/auth/login';
  static const String forgotPasswordUrl = '$_baseUrl/auth/forget-password';
  static const String changePasswordUrl = '$_baseUrl/auth/change-password';
  static const String profileUrl = '$_baseUrl/profiles/my-profile';
  static const String editProfileUrl = '$_baseUrl/profiles/update-my-profile';
  static const String allfeedUrl = '$_baseUrl/feeds';
  static const String myfeedUrl = '$_baseUrl/feeds/my-feed';
  static const String carRatingUrl = '$_baseUrl/car-ratings';
  static const String myGarageUrl = '$_baseUrl/cars/my-car';
  static const String myClubUrl = '$_baseUrl/clubs/my-club';
  static const String myFavouriteUrl = '$_baseUrl/favorite/my-favorite';
  static const String createClubUrl = '$_baseUrl/clubs';
  static const String allPendingConnection =
      '$_baseUrl/connect-requests/my-connection';
  static const String allmarketPlaceUrl = '$_baseUrl/cars';
  static const String contentUrl = '$_baseUrl/contents';
  static const String addCarUrl = '$_baseUrl/cars';
  static const String reviewUrl = '$_baseUrl/reviews';
  static const String favouriteUrl = '$_baseUrl/favorite';

  static String getMarketPlaceUrlById(
    String id,
  ) {
    return '$_baseUrl/cars/$id';
  }

  static String getReviewById(
    String id,
  ) {
    return '$_baseUrl/reviews/reference/$id';
  }

  static String updateUserByUrl(
    String id,
  ) {
    return '$_baseUrl/users/update/$id';
  }

  // old package
  static const String savePostUrl = '$_baseUrl/watch-later';
  static const String addChatUrl = '$_baseUrl/chats';
  static const String feedPostUrl = '$_baseUrl/feeds';
  static const String reelsPostUrl = '$_baseUrl/reels';
  static const String createWishListUrl = '$_baseUrl/wishlists';
  static const String allWishListUrl = '$_baseUrl/wishlists/my-wishlist';
  static const String allFriendsChatnUrl = '$_baseUrl/chats/my-chat-list';
  static const String reportUserUrl = '$_baseUrl/reports';
  static const String sendMessageUrl = '$_baseUrl/messages/send-messages';
  static const String notificationUrl = '$_baseUrl/notification';
  static const String mySavePostUrl = '$_baseUrl/watch-later/my-watch-later';
  static const String allBlockersUrl = '$_baseUrl/profile-block/my-block';
  static const String allUserssUrl = '$_baseUrl/users/public';
  static const String sendCommentUrl = '$_baseUrl/comments';

  static String commentByContentId(
    String id,
  ) {
    return '$_baseUrl/comments/content/$id';
  }

  static String postDetailsById(
    String id,
  ) {
    return '$_baseUrl/feeds/$id';
  }

  static String allFollowersById(
    String id,
  ) {
    return '$_baseUrl/connection/followers/$id';
  }

  static String allFollowingById(
    String id,
  ) {
    return '$_baseUrl/connection/following/$id';
  }

  static String othersWishlistById(
    String id,
  ) {
    return '$_baseUrl/wishlists/user/$id';
  }

  static String allFeedById(
    String id,
  ) {
    return '$_baseUrl/feeds/user/$id';
  }

  static String otherUserByUrl(
    String id,
  ) {
    return '$_baseUrl/users/$id';
  }

  static String confirmedPaymentUrlsById(
    String id,
  ) {
    return '$_baseUrl/payments/reference/$id';
  }

  static String followRequestById(
    String id,
  ) {
    return '$_baseUrl/connection/follow/$id';
  }

  static String unfollowRequestById(
    String id,
  ) {
    return '$_baseUrl/connection/unfollow/$id';
  }

  static String reactById(
    String id,
  ) {
    return '$_baseUrl/content-meta/like/$id';
  }

  static String disReactById(
    String id,
  ) {
    return '$_baseUrl/content-meta/unlike/$id';
  }

  static String wishlistById(
    String id,
  ) {
    return '$_baseUrl/wishlists/$id';
  }

  static String blockUserById(
    String id,
  ) {
    return '$_baseUrl/profile-block/block/$id';
  }

  static String getMessagesUrl(
    String id,
  ) {
    return '$_baseUrl/messages/my-messages/$id';
  }

  static String deleteAccountById(
    String id,
  ) {
    return '$_baseUrl/users/$id';
  }

  static String deleteSavePostById(
    String id,
  ) {
    return '$_baseUrl/watch-later/$id';
  }

  static String deleteChatDataById(
    String id,
  ) {
    return '$_baseUrl/messages/chat/$id';
  }

  static String unSavePostById(
    String id,
  ) {
    return '$_baseUrl/favorite/$id';
  }

  static String userUnblockById(
    String id,
  ) {
    return '$_baseUrl/profile-block/unblock/$id';
  }
}
