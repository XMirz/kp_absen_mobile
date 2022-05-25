import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kp_mobile/app/modules/root/controllers/root_controller.dart';
import 'package:kp_mobile/app/utils/helper.dart';
import 'package:kp_mobile/app/values/colors.dart';
import 'package:kp_mobile/app/widgets/office_location_card.dart';
import 'package:kp_mobile/app/widgets/presence_card.dart';
import 'package:kp_mobile/app/widgets/text_heading.dart';
import 'package:kp_mobile/app/widgets/user_info.dart';

class HomeFragment extends StatelessWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RootController>();
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      children: [
        UserInfo(),
        spaceY(24),
        TextHeading(title: 'Presensi'),
        spaceY(12),
        PresenceCard(),
        spaceY(24),
        OfficeLocationCard(),
      ],
    );
  }
}
