import 'package:flutter/material.dart';
import 'package:kp_mobile/app/values/colors.dart';

class HomeFragment extends StatelessWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // color: AppColor.accentLight,
          ),
      child: Center(
        child: Text(
          'Andre Ganteng TAIK',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: AppColor.accent),
        ),
      ),
    );
  }
}
