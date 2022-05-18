import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kp_mobile/app/modules/root/controllers/root_controller.dart';

class HomeFragment extends StatelessWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RootController>();
    return StreamBuilder(
      stream: controller.streamUser(),
      builder: (context, snapshot) {
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          children: [
            Container(
              height: 64,
              child: Row(
                children: [
                  ClipOval(
                    child: Container(
                      height: 48,
                      width: 48,
                      child: HeroIcon(HeroIcons.user),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
