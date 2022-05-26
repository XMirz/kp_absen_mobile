import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kp_mobile/app/modules/root/controllers/root_controller.dart';
import 'package:kp_mobile/app/utils/helper.dart';
import 'package:kp_mobile/app/values/colors.dart';
import 'package:kp_mobile/app/widgets/text.dart';
import 'package:maps_launcher/maps_launcher.dart';

class OfficeLocationCard extends StatelessWidget {
  OfficeLocationCard({Key? key}) : super(key: key);
  final controller = Get.find<RootController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextHeading(title: 'Informasi kantor'),
          spaceY(8),
          Text(
            controller.configuration.value.location ?? '',
            style: GoogleFonts.nunito(
              fontSize: 14,
              color: AppColor.secondary,
            ),
          ),
          spaceY(8),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      color: Colors.black12,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Jarak dari kantor',
                          style: GoogleFonts.nunito(
                            fontSize: 12,
                            color: AppColor.secondaryLight,
                          ),
                        ),
                        spaceY(4),
                        Text(
                          controller.distanceFromOfficeText.value,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColor.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                spaceX(24),
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    onTap: () async {
                      MapsLauncher.launchCoordinates(
                          double.parse(
                              controller.configuration.value.latitude!),
                          double.parse(
                              controller.configuration.value.longitude!),
                          'Pemerintah Kota Pekanbaru');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/maps.png'),
                          fit: BoxFit.cover,
                          opacity: 0.3,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                        color: Colors.black12,
                      ),
                      child: Text(
                        'Buka maps',
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColor.secondary,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
