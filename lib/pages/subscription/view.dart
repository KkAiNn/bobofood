import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class SubscriptionPage extends GetView<SubscriptionController> {
  const SubscriptionPage({super.key});

  // 主视图
  Widget _buildView() {
    return const Center(
      child: Text("SubscriptionPage"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionController>(
      init: SubscriptionController(),
      id: "subscription",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("subscription")),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
