import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kp_mobile/app/data/models/user.dart';
import 'package:kp_mobile/app/modules/root/controllers/root_controller.dart';
import 'package:kp_mobile/app/utils/helper.dart';
import 'package:kp_mobile/app/widgets/text.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RootController>();
    User user = controller.user.value;
    return Container(
      // padding: EdgeInsets.only(top: 24),
      alignment: Alignment.center,
      height: Get.size.height * 0.2,
      child: IntrinsicHeight(
        child: Column(
          children: [
            CircleAvatar(
              radius: 56,
              foregroundImage: NetworkImage(controller.profileUrl, scale: 1),
            ),
            spaceY(12),
            TextHeadingSmall(title: user.name ?? '-'),
            // spaceY(4),
            TextBodyLargeBold(title: user.nip ?? '-')
          ],
        ),
      ),
    );
  }
}
