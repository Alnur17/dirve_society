import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/meets_controller.dart';

class MeetsView extends GetView<MeetsController> {
  const MeetsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MeetsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MeetsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
