// ignore_for_file: non_constant_identifier_names

import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kp_mobile/app/values/colors.dart';

class TextHeading extends StatelessWidget {
  final String title;
  const TextHeading({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 18,
        color: AppColor.secondary,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

Widget TextHeadingSmall({required String title, Color? color}) {
  return Text(
    title,
    style: GoogleFonts.poppins(
      fontSize: 16,
      color: color ?? AppColor.secondary,
      fontWeight: FontWeight.w600,
    ),
  );
}

Widget TextBodyLargeBold({required String title, Color? color}) {
  return Text(
    title,
    style: GoogleFonts.nunito(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: color ?? AppColor.secondary,
    ),
  );
}

Widget TextBodyLarge({required String title, Color? color}) {
  return Text(
    title,
    style: GoogleFonts.nunito(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: color ?? AppColor.secondary,
    ),
  );
}

Widget TextBody({required String title}) {
  return Text(
    title,
    style: GoogleFonts.nunito(
      fontSize: 14,
      color: AppColor.secondary,
    ),
  );
}

Widget TextBodySmall({required String title}) {
  return Text(
    title,
    style: GoogleFonts.nunito(
      fontSize: 12,
      color: AppColor.secondary,
    ),
  );
}
