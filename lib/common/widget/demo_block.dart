import 'package:flutter/material.dart';
import 'package:bobofood/common/widget/app_text.dart';

class DemoBlock extends StatelessWidget {
  const DemoBlock({super.key, this.title, required this.child});

  final String? title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          if (title != null)
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: AppText(title!, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          child,
        ],
      ),
    );
  }
}
