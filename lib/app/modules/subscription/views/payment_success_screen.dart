import 'package:dirve_society/app/modules/subscription/views/payment_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class PaymentSuccessScreen extends StatefulWidget {
  static const String routeName = '/payment-success-screen';
  const PaymentSuccessScreen({super.key});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  @override
  void initState() {
    _movetoNewScreen();
    super.initState();
  }

  Future<void> _movetoNewScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.to(PaymentDetailsScreen());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Center(
            //   child: Container(
            //     height: 100,
            //     width: 100,
            //     decoration: BoxDecoration(
            //         image: DecorationImage(
            //             image: AssetImage(AssetsPath.payment),
            //             fit: BoxFit.fill)),
            //   ),
            // ),
                             SizedBox(height: 10),
            
            Text(
              'Congratulation',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
                             SizedBox(height: 10),
           
            SizedBox(
              width: 280,
              child: Text(
                textAlign: TextAlign.center,
                'Payment completed successfully. A confirmation has been sent to your email.',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      
    );
  }
}
