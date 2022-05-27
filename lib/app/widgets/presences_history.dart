import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kp_mobile/app/modules/root/controllers/root_controller.dart';
import 'package:kp_mobile/app/utils/helper.dart';
import 'package:kp_mobile/app/widgets/presence_card.dart';
import 'package:kp_mobile/app/widgets/text.dart';

class PresencesHistory extends StatelessWidget {
  const PresencesHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RootController>();
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextHeading(title: 'Presensi terakhir'),
          spaceY(8),
          ...controller.presencesHistory
              .map((presence) => PresenceCard(presence: presence))
        ],
      ),
    );
  }
}
