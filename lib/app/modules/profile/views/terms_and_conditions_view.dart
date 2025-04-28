import 'package:flutter/material.dart';

import 'package:get/get.dart';

class TermsAndConditionsView extends GetView {
  const TermsAndConditionsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TermsAndConditionsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TermsAndConditionsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
