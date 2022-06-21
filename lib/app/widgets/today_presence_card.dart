import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kp_mobile/app/modules/root/controllers/root_controller.dart';
import 'package:kp_mobile/app/utils/helper.dart';
import 'package:kp_mobile/app/values/colors.dart';
import 'package:kp_mobile/app/values/styles.dart';
import 'package:kp_mobile/app/widgets/presence_detail_modal.dart';

class TodayPresenceCard extends StatelessWidget {
  const TodayPresenceCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RootController>();
    return Obx(
      () => Material(
        child: Container(
          padding: EdgeInsets.fromLTRB(24, 20, 24, 16),
          decoration: BoxDecoration(
            boxShadow: [shadowSmall],
            borderRadius: BorderRadius.all(
              Radius.circular(
                12,
              ),
            ),
            color: AppColor.accent,
          ),
          child: InkWell(
            onTap: () {
              if (controller.todayPresence.value?.id != null) {
                showModalBottomSheet(
                  // useRootNavigator: true,
                  context: context,
                  builder: (context) {
                    // return Container();
                    return PresenceDetailModal(
                        presence: controller.todayPresence.value!);
                  },
                );
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.user.value.role ?? '',
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  controller.configuration.value.today ?? '',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                spaceY(16),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: Colors.white.withOpacity(0.25),
                  ),
                  child: controller.todayPresence.value?.id != null &&
                          !isPresent(controller.todayPresence.value!.type!)
                      ? Column(
                          children: [
                            Text(
                              getPresenceTypeText(
                                  controller.todayPresence.value!.type ?? ''),
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                controller.todayPresence.value!.description ??
                                    '',
                                textAlign: TextAlign.start,
                                style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Masuk',
                                    style: GoogleFonts.nunito(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    controller.todayPresence.value!
                                                .checkInTime !=
                                            null
                                        ? '${DateFormat("HH:mm").format(controller.todayPresence.value!.checkInTime!)} WIB'
                                        : '-',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 4),
                              color: Colors.white,
                              width: 1,
                              height: 48,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Keluar',
                                    style: GoogleFonts.nunito(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    controller.todayPresence.value!
                                                .checkOutTime !=
                                            null
                                        ? '${DateFormat("HH:mm").format(controller.todayPresence.value!.checkOutTime!)} WIB'
                                        : '-',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
