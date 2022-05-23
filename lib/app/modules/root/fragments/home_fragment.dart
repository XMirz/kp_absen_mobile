import 'package:flutter/material.dart';
import 'package:kp_mobile/app/utils/helper.dart';
import 'package:kp_mobile/app/widgets/presence_card.dart';
import 'package:kp_mobile/app/widgets/user_info.dart';

class HomeFragment extends StatelessWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final controller = Get.find<RootController>();
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      children: [
        UserInfo(),
        spaceY(24),
        PresenceCard(),
      ],
    );
  }
}
