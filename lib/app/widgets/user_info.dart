import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kp_mobile/app/modules/root/controllers/root_controller.dart';
import 'package:kp_mobile/app/values/colors.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RootController>();
    return Obx(
      () => Container(
        height: 64,
        child: Row(
          children: [
            ClipOval(
              child: Container(
                height: 48,
                width: 48,
                child: HeroIcon(HeroIcons.user),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome back,',
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColor.secondaryLight),
                ),
                Text(
                  controller.user.value.name ?? '',
                  style: GoogleFonts.inter(
                      color: AppColor.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}