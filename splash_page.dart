import 'package:flutter/material.dart';
import 'package:sanzhyra/app/build_context_ext.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            // Image.asset(
            //   AppConst.icLogo,
            //   height: Get.height * 0.15,
            //   // width: Get.width * 0.15,
            //   fit: BoxFit.contain,
            // ),
            SizedBox(
              height: 40,
            ),
            CircularProgressIndicator(
              color: context.color.primary,
              strokeWidth: 2,
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
