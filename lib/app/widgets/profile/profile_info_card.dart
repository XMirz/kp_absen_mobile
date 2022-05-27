import 'package:flutter/material.dart';
import 'package:kp_mobile/app/widgets/text.dart';

class ProfileInfoCard extends StatelessWidget {
  final String label;
  final String value;
  ProfileInfoCard({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextBodySmall(title: label),
          TextBodyLargeBold(title: value),
        ],
      ),
    );
  }
}
