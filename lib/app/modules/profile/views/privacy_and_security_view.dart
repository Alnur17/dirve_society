import 'package:flutter/material.dart';

import 'package:get/get.dart';

class PrivacyAndSecurityView extends GetView {
  const PrivacyAndSecurityView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PrivacyAndSecurityView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PrivacyAndSecurityView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
