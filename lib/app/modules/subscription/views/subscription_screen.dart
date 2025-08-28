import 'package:dirve_society/app/modules/subscription/controllers/all_package_controller.dart';
import 'package:dirve_society/app/modules/subscription/controllers/payment_controller.dart';
import 'package:dirve_society/app/modules/subscription/controllers/payment_services.dart';
import 'package:dirve_society/app/modules/subscription/controllers/subscription_controller.dart';
import 'package:dirve_society/common/widgets/custom_button.dart';
import 'package:dirve_society/common/widgets/custom_snackbar_widget.dart';
import 'package:dirve_society/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final AllPackageController allPackageController =
      Get.put(AllPackageController());
  final SubscriptionController subscriptionController =
      Get.put(SubscriptionController());
  final PaymentService paymentService = PaymentService();
  final PaymentController paymentController = Get.put(PaymentController());

  @override
  void initState() {
    super.initState();
    allPackageController.getAllPackage();
  }

  @override
  Widget build(BuildContext context) {
    var packageId = allPackageController.allPackageList?[0].id;
    return Scaffold(
      body: GetBuilder<AllPackageController>(builder: (controller) {
        if (controller.inProgress) {
          return SizedBox(
            height: 700,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back, size: 24)),
                  Text(
                    'Subscription',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    width: 24,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Premium Membership',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 130,
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.red)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Lifetime Access',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.deepOrange)),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 3,
                                  backgroundColor: Colors.black,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Unlimited club member',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '\$20',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 30,
                                  color: Colors.redAccent),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => CustomButton(
                        text: 'Buy Now',
                        isLoading: subscriptionController.inProgress,
                        onPressed: () {
                          if (!subscriptionController.inProgress) {
                            getPackage(controller.allPackageList?[0].id ?? '');
                            print(
                                'Package ID: ${controller.allPackageList?[0].id}');
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Future<void> getPackage(String packageId) async {
    final bool isSuccess =
        await subscriptionController.getSubscription(packageId);

    if (isSuccess) {
      if (mounted) {
        paymentService.payment(
            context,
            StorageUtil.getData(StorageUtil.profileId),
            subscriptionController.subcriptionId ?? '');
        print('Subscription ID: ${subscriptionController.subcriptionId}');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          subscriptionController.errorMessage ??
              'Failed to create subscription',
          true,
        );
      }
    }
  }

  // Future<void> getPaymentLink(String id) async {
  //   final bool isSuccess = await paymentController.getPayment(id);

  //   if (isSuccess) {
  //     if (mounted) {
  //       print('link ID:');
  //     }
  //   } else {
  //     if (mounted) {
  //       showSnackBarMessage(
  //         context,
  //         paymentController.errorMessage ?? 'Failed to create club',
  //         true,
  //       );
  //     }
  //   }
  // }
}
