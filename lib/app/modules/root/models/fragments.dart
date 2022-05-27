import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kp_mobile/app/modules/root/fragments/history.dart';
import 'package:kp_mobile/app/modules/root/fragments/home_fragment.dart';
import 'package:kp_mobile/app/modules/root/fragments/profile_fragment.dart';
import 'package:kp_mobile/app/modules/root/fragments/schedule.dart';

class Fragments {
  final String name;
  final Widget fragment;
  final HeroIcons icon;
  final int index;
  Fragments({
    required this.name,
    required this.fragment,
    required this.icon,
    required this.index,
  });
  static List<List<Fragments>> fragmentRows = [
    [
      Fragments(
        name: 'Absensi',
        fragment: HomeFragment(),
        icon: HeroIcons.home,
        index: 0,
      ),
      // Fragments(
      //   name: 'Riwayat',
      //   fragment: HistoryFragment(),
      //   icon: HeroIcons.calendar,
      //   index: 1,
      // )
    ],
    [
      // Fragments(
      //   name: 'Jadwal',
      //   fragment: ScheduleFragment(),
      //   icon: HeroIcons.clipboardList,
      //   index: 2,
      // ),
      Fragments(
        name: 'Profile',
        fragment: ProfileFragment(),
        icon: HeroIcons.user,
        index: 3,
      ),
    ]
  ];
}
