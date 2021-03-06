import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kp_mobile/app/data/models/presence.dart';
import 'package:kp_mobile/app/modules/root/controllers/root_controller.dart';
import 'package:kp_mobile/app/utils/helper.dart';
import 'package:kp_mobile/app/values/colors.dart';
import 'package:kp_mobile/app/widgets/layouts/modal_layout.dart';
import 'package:kp_mobile/app/widgets/text.dart';
import 'package:map_launcher/map_launcher.dart';

class PresenceDetailModal extends StatelessWidget {
  final Presence presence;
  PresenceDetailModal({Key? key, required this.presence}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    inspect(presence);

    final controller = Get.find<RootController>();

    return ModalLayout(
      title: 'Rincian presensi',
      onTapSubmit: () {
        Get.back();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextBodyExtraLarge(
            title:
                DateFormat('EEEE, dd MMMM yyyy').format(presence.checkInTime!),
          ),
          //Masuk
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextBodyLargeBold(
                title: 'Presensi masuk',
              ),
              TextButton(
                onPressed: () async {
                  await controller.openMap(
                    title: 'Lokasi presensi',
                    coords: Coords(
                      presence.checkInLocation!['latitude']!,
                      presence.checkInLocation!['longitude']!,
                    ),
                  );
                },
                child:
                    TextBodyBold(title: 'Lihat lokasi', color: AppColor.accent),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              // boxShadow: [shadowExtraSmall],
              color: AppColor.accent,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextBodyBold(title: 'Waktu presensi', color: Colors.white),
                spaceY(4),
                TextHeadingSmall(
                    title:
                        '${DateFormat('HH:mm').format(presence.checkInTime!)} WIB',
                    color: Colors.white),
                spaceY(12),
                TextBodyBold(title: 'Status presensi', color: Colors.white),
                spaceY(4),
                TextHeadingSmall(
                    title: getPresenceTypeText(presence.type ?? ''),
                    color: Colors.white),
                spaceY(12),
                TextBodyBold(
                    title: isPresent(presence.type ?? '')
                        ? 'Jarak ke kantor'
                        : 'Keterangan',
                    color: Colors.white),
                spaceY(4),
                TextBodyLarge(
                    title: isPresent(presence.type ?? '')
                        ? controller.getDistanceFromOfficeText(
                            presence.checkInDistance!.toInt())
                        : presence.description ?? '',
                    color: Colors.white),
              ],
            ),
          ),
          spaceY(12),
          // Keluar
          isPresent(presence.type!) && presence.checkOutTime != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextBodyLargeBold(
                      title: 'Keluar',
                    ),
                    TextButton(
                      onPressed: () async {
                        await controller.openMap(
                          title: 'Lokasi presensi',
                          coords: Coords(
                            presence.checkOutLocation!['latitude']!,
                            presence.checkOutLocation!['longitude']!,
                          ),
                        );
                      },
                      child: TextBodyBold(
                          title: 'Lihat lokasi', color: AppColor.accent),
                    )
                  ],
                )
              : Container(),
          isPresent(presence.type!) && presence.checkOutTime != null
              ? Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    // boxShadow: [shadowExtraSmall],
                    border: Border.all(
                        color: Colors.black.withOpacity(
                          0.25,
                        ),
                        width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextBody(
                          title: 'Waktu presensi',
                          color: AppColor.secondaryLight),
                      spaceY(4),
                      TextHeadingSmall(
                          title:
                              '${DateFormat('HH:mm').format(presence.checkOutTime!)} WIB'),
                      spaceY(12),
                      TextBody(
                          title: 'Status presensi',
                          color: AppColor.secondaryLight),
                      spaceY(4),
                      TextHeadingSmall(
                        title: getPresenceTypeText(presence.type ?? ''),
                      ),
                      spaceY(12),
                      TextBody(
                          title: 'Jarak ke kantor',
                          color: AppColor.secondaryLight),
                      spaceY(4),
                      TextHeadingSmall(
                        title: controller.getDistanceFromOfficeText(
                            presence.checkOutDistance!.toInt()),
                      ),
                    ],
                  ),
                )
              : Container(),
          spaceY(16)
        ],
      ),
    );
  }
}
