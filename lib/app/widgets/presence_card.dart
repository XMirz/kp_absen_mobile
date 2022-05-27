import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kp_mobile/app/data/models/presence.dart';
import 'package:kp_mobile/app/modules/root/controllers/root_controller.dart';
import 'package:kp_mobile/app/utils/helper.dart';
import 'package:kp_mobile/app/values/colors.dart';
import 'package:kp_mobile/app/widgets/presence_detail_modal.dart';

class PresenceCard extends StatelessWidget {
  final Presence presence;
  PresenceCard({Key? key, required this.presence}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RootController>();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: Colors.black.withOpacity(
              0.1,
            ),
            width: 0.5),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => PresenceDetailModal(presence: presence),
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('EEEE, dd MMMM yyyy')
                          .format(presence.checkInTime!),
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    spaceY(8),
                    Text(presence.inArea == true ? 'Kantor' : 'Lapangan'),
                    spaceY(4),
                    RichText(
                      text: TextSpan(
                          style: TextStyle(color: AppColor.secondary),
                          children: <TextSpan>[
                            TextSpan(text: 'Sekitar '),
                            TextSpan(
                                text: controller.getDistanceFromOfficeText(
                                  presence.checkInDistance?.toInt(),
                                ),
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            TextSpan(text: ' dari kantor', style: TextStyle())
                          ]),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text('Masuk', style: TextStyle(fontSize: 12)),
                      spaceY(12),
                      Text('Keluar', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  spaceX(12),
                  Column(
                    children: [
                      Text(
                        '${DateFormat('HH:mm').format(presence.checkInTime!)} WIB',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      Text(
                        '${presence.checkOutTime != null ? DateFormat('HH:mm').format(presence.checkOutTime!) : '-'} ${presence.checkOutTime != null ? 'WIB' : ''}',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
