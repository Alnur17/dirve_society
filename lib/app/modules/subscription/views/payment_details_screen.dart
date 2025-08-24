import 'package:dirve_society/app/modules/dashboard/views/dashboard_view.dart';
import 'package:dirve_society/app/modules/subscription/controllers/confirmed_payment_controller.dart';
import 'package:dirve_society/app/modules/subscription/widgets/price_row.dart';
import 'package:dirve_society/get_storage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';


class PaymentDetailsScreen extends StatefulWidget {
  static const String routeName = '/payment-details-screen';
  const PaymentDetailsScreen({super.key});

  @override
  State<PaymentDetailsScreen> createState() => _PaymentDetailsScreen();
}

class _PaymentDetailsScreen extends State<PaymentDetailsScreen> {
  final ConfirmedPaymentController confirmedPaymentController =
      Get.put(ConfirmedPaymentController());

  @override
  void initState() {
    super.initState();
    // Confirm payment on the page load
    confirmedPaymentController
        .confirmPaymentfunction(StorageUtil.getData('payment-reference-id'));

    print('Details page data ....................');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ConfirmedPaymentController>(builder: (controller) {
          // Checking if the request is still in progress
          if (controller.inProgress) {
            return Center(child: CircularProgressIndicator());
          }

          // If an error occurred, display the error message
          if (controller.errorMessage != null) {
            return Center(child: Text('Error: ${controller.errorMessage}'));
          }

          DateTime? isoDate =
              controller.confirmedPaymentResponseModel?.data?.createdAt;
          String readableDate = isoDate != null
              ? DateFormat('MMMM dd, yyyy').format(isoDate)
              : 'Date not available';

          // Displaying the payment details once data is loaded
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Card(
                      color: Colors.transparent,
                      elevation: 0.5,
                      child: Container(
                        height: 444,
                        width: 315,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xffA062FA),
                                  Color(0xffB389EF),
                                  Color(0xffA386F0),
                                  Color(0xff6CC7FF).withOpacity(0.9),
                                ]),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                             SizedBox(height: 100),
                              PriceRow(
                                name: 'Date',
                                price: readableDate,
                                nameSize: 14,
                                priceSize: 14,
                              ),
                             SizedBox(height: 8),
                              
                              PriceRow(
                                name: 'Transaction ID',
                                price:
                                    '${controller.confirmedPaymentResponseModel?.data?.dataId}',
                                nameSize: 14,
                                priceSize: 14,
                              ),
                             SizedBox(height: 8),
                              
                              PriceRow(
                                name: 'Amount',
                                price:
                                    '${controller.confirmedPaymentResponseModel?.data?.amount}',
                                nameSize: 14,
                                priceSize: 14,
                              ),
                                                           SizedBox(height: 10),

                              PriceRow(
                                name: 'Name',
                                price:
                                    '${controller.confirmedPaymentResponseModel!.data?.account?.name}',
                                nameSize: 14,
                                priceSize: 14,
                              ),
                             SizedBox(height: 10),
                             
                              Container(
                                height: 1,
                                width: 315,
                                color: Colors.white,
                              ),
                             SizedBox(height: 20),
                            
                              PriceRow(
                                name: 'Total',
                                price:
                                    '${controller.confirmedPaymentResponseModel?.data?.amount}',
                                nameSize: 14,
                                priceSize: 14,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: -30,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.blue.withOpacity(0.7), width: 3),
                            color: Colors.blue,
                            shape: BoxShape.circle),
                        child: Center(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),                             SizedBox(height: 50),

             
              // InkWell(
              //   onTap: () {
              //     pdfController.generateAndSavePDF(
              //         readableDate,
              //         '${controller.confirmedPaymentResponseModel?.data?.transactionId}',
              //         '${controller.confirmedPaymentResponseModel?.data?.amount}',
              //         '${controller.confirmedPaymentResponseModel?.data!.account?.name}');
              //   },
              //   child: Container(
              //     height: 48,
              //     width: 315,
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(50),
              //         border: Border.all(color: AppColors.iconButtonThemeColor)),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Icon(
              //           Icons.file_download_outlined,
              //           color: AppColors.iconButtonThemeColor,
              //         ),
              //         widthBox8,
              //         Text(
              //           'Get pdf reciept',
              //           style: TextStyle(color: AppColors.iconButtonThemeColor),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
                             SizedBox(height: 50),
              
              GestureDetector(
                onTap: () {
                  Get.to(() => DashboardView());
                },
                child: Container(
                  height: 48,
                  width: 315,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                             SizedBox(width: 8),
                      
                      Text(
                        'Go to homepage',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      
    );
  }

  @override
  void dispose() {
    StorageUtil.getData('payment-reference-id');
    super.dispose();
  }
}
