import 'package:flutter/material.dart';

class CenterProgressIndicatorWithStack extends StatelessWidget {
  const CenterProgressIndicatorWithStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(
        alpha: 0.5,
      ), // Transparent black background
      child: Center(
        child: CircularProgressIndicator(), // Loading Indicator
      ),
    );
  }
}
