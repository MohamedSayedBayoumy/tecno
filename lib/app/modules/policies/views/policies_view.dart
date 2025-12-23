import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/policies_controller.dart';

class PoliciesView extends GetView<PoliciesController> {
  const PoliciesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PoliciesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PoliciesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
