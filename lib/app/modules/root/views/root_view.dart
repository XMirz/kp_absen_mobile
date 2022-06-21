import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kp_mobile/app/modules/root/fragments/history.dart';
import 'package:kp_mobile/app/modules/root/fragments/home_fragment.dart';
import 'package:kp_mobile/app/modules/root/fragments/profile_fragment.dart';
import 'package:kp_mobile/app/modules/root/fragments/schedule.dart';
import 'package:kp_mobile/app/values/colors.dart';
import 'package:kp_mobile/app/widgets/bottom_navbar.dart';

import '../controllers/root_controller.dart';

class RootView extends GetView<RootController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: SafeArea(
          child: Obx(
            () => IndexedStack(
              index: controller.fragmentIndex.value,
              children: [
                HomeFragment(),
                HistoryFragment(),
                ScheduleFragment(),
                ProfileFragment()
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: controller.fragmentIndex.value != 0 ||
                controller.configuration.value.eligible != true
            ? null
            : FloatingActionButton(
                backgroundColor:
                    // Check if its a check out time or check in time
                    controller.todayPresence.value!.checkInTime != null &&
                            controller.todayPresence.value!.checkOutTime == null
                        ? AppColor.error
                        : AppColor.success,
                onPressed: () {
                  controller.todayPresence.value!.checkInTime != null &&
                          controller.todayPresence.value!.checkOutTime == null
                      ? controller.checkOut()
                      : controller.handleFab();
                },
                child: HeroIcon(
                  controller.todayPresence.value!.checkInTime != null &&
                          controller.todayPresence.value!.checkOutTime == null
                      ? HeroIcons.x
                      : HeroIcons.check,
                  size: 32,
                ),
              ),
      ),
    );
  }
}
