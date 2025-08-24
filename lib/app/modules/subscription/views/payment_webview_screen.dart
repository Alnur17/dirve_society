import 'package:dirve_society/app/modules/subscription/controllers/confirmed_payment_controller.dart';
import 'package:dirve_society/app/modules/subscription/controllers/payment_url_controller.dart';
import 'package:dirve_society/common/app_color/app_colors.dart';
import 'package:dirve_society/common/app_text_style/styles.dart';
import 'package:dirve_society/common/widgets/custom_snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentView extends StatefulWidget {
  final Map<String, dynamic> paymentData;
  final String? paymentUrl;

  static const String routeName = '/payment-webview-screen';

  const PaymentView({
    super.key,
    required this.paymentData,
    this.paymentUrl,
  });

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  // ignore: unused_field
  late WebViewController _controller;
  final ConfirmedPaymentController confirmedPaymentController =
      ConfirmedPaymentController();
  final PaymentURLController paymentURLController = PaymentURLController();

  // final SubscriptionPlanController subscriptionPlanController =
  //     Get.put(SubscriptionPlanController());

      @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            debugPrint('Page start loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            if (url.contains("verify-session-for")) {
              // subscriptionPlanController.paymentResults(paymentLink: url);
              debugPrint('::::::::::::: if condition ::::::::::::::::');
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl ?? ''));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Payment', style: titleStyle), // Updated to use translation
        centerTitle: true,
      ),
      body: WebViewWidget(controller: _controller),
    );
  }

  Future<void> confirmPayment(String reference) async {
    final bool isSuccess =
        await confirmedPaymentController.confirmPaymentfunction(reference);
    if (isSuccess) {
      if (mounted) {
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, confirmedPaymentController.errorMessage!, true);
        }
      }
    } else {
      if (mounted) {
        // print('Error show ----------------------------------');
        showSnackBarMessage(context,
            confirmedPaymentController.errorMessage ?? 'Ekhanei problem', true);
      }
    }
  }
}
