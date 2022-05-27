import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kp_mobile/app/modules/root/controllers/root_controller.dart';
import 'package:kp_mobile/app/modules/root/models/fragments.dart';
import 'package:kp_mobile/app/values/colors.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RootController>();
    return BottomAppBar(
      notchMargin: 8,
      shape: CircularNotchedRectangle(),
      // color: AppColor.accentDark,
      child: Container(
        height: 64,
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: Fragments.fragmentRows // NavigationBar Item
                .map(
                  (fragmentRow) => Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: fragmentRow
                        .map(
                          (fragment) => MaterialButton(
                            shape: CircleBorder(),
                            onPressed: () {
                              controller.fragmentIndex.value = fragment.index;
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                HeroIcon(
                                  fragment.icon,
                                  color: controller.fragmentIndex.value ==
                                          fragment.index
                                      ? AppColor.accent
                                      : AppColor.secondaryLight,
                                )
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
