import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:streaming_app/presentation/constant/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 120,
          height: 120,
          child: Image.asset(
            'assets/images/loading_indicator.gif',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
