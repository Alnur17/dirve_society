import 'package:dirve_society/app/modules/subscription/controllers/confirmed_payment_controller.dart';
import 'package:dirve_society/app/modules/subscription/controllers/payment_url_controller.dart';
import 'package:dirve_society/common/app_color/app_colors.dart';
import 'package:dirve_society/common/app_text_style/styles.dart';
import 'package:dirve_society/common/widgets/custom_snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentView extends StatefulWidget {
  final Map<String, dynamic> paymentData;

  static const String routeName = '/payment-webview-screen';

  const PaymentView({
    super.key,
    required this.paymentData,
  });

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  late WebViewController _controller;
  final ConfirmedPaymentController confirmedPaymentController =
      ConfirmedPaymentController();
  final PaymentURLController paymentURLController = PaymentURLController();

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
          onPageFinished: (String url) async {
            debugPrint('Page finished loading: $url');
            if (url.contains("confirm-payment")) {
              debugPrint('Confirmed payment hoye geche............................');
              final bool isSuccess = await paymentURLController.paymentUrl(url);
              if (isSuccess) {
                await confirmPayment('${widget.paymentData['reference']}');
                Navigator.pushNamed(context, '/payment-success-screen'); // Adjust route name if needed
              }
              debugPrint('::::::::::::: if condition ::::::::::::::::');
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentData['link'] ?? ''));
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
        title: Text('Payment', style: titleStyle),
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
        // Success handling can be added here if needed
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            confirmedPaymentController.errorMessage ?? 'Ekhanei problem', true);
      }
    }
  }
}