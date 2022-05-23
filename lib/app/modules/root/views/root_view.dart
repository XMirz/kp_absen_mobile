import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kp_mobile/app/modules/root/fragments/history.dart';
import 'package:kp_mobile/app/modules/root/fragments/home_fragment.dart';
import 'package:kp_mobile/app/modules/root/fragments/profile_fragment.dart';
import 'package:kp_mobile/app/modules/root/fragments/schedule.dart';
import 'package:kp_mobile/app/widgets/bottom_navbar.dart';

import '../controllers/root_controller.dart';

class RootView extends GetView<RootController> {
  @override
  RootController get controller => super.controller;

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
        floatingActionButton: controller.fragmentIndex.value != 0
            ? null
            : FloatingActionButton(
                onPressed: () {},
                child: HeroIcon(
                  HeroIcons.fingerPrint,
                  size: 40,
                ),
              ),
      ),
    );
  }
}
