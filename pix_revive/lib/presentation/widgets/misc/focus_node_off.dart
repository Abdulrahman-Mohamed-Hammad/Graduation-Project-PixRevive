import 'package:flutter/material.dart';

class FocusNodeOff extends StatelessWidget {
  const FocusNodeOff({super.key, this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: child,
    );
  }
}
