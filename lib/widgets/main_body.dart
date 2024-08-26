import 'package:flutter/material.dart';

class MainBody extends StatelessWidget {
  final Widget child;
  const MainBody({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: child));
  }
}
