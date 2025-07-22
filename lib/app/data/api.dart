class Api {

  static const baseUrl = "http://172.252.13.83:5007/api/v1";

  static const login = "$baseUrl/auth/login"; // done
  static const userRegister = "$baseUrl/users/register"; //
  static const vendorRegister = "$baseUrl/users/register"; // done
  static const serviceProviderRegister = "$baseUrl/users/register"; // done
  static const userRegisterVerify = "$baseUrl/otp/verify-otp"; // done
  static const otpVerify = "$baseUrl/otp/verify-otp"; // done
  static const userResendOtp = "$baseUrl/otp/resend-otp";// done
  static const resetPassword = "$baseUrl/auth/reset-password";
  static const getProfileResponse = "$baseUrl/users/my-profile";//done
  static const userProfileUpdate = "$baseUrl/users/update-my-profile"; // done
  static const userChangePassword = "$baseUrl/auth/change-password"; // done
  static const getContentResponse = "$baseUrl/contents";//done
  static const deleteUserResponse = "$baseUrl/users/";//done
  static const jobCategoryResponse = "$baseUrl/job-categories?limit=1000000000";//done
  static const resendOtp = "$baseUrl/otp/resend-otp";

  static const resetForgetPassword =
      "$baseUrl/auth/reset-forgotten-password"; // done

  static const sponsor = "$baseUrl/sponsor";
  static const categories = "$baseUrl/categories";
  static const products = "$baseUrl/products";
  static const serviceProvider = "$baseUrl/users?role=service_provider";

}