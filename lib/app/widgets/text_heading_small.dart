import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kp_mobile/app/values/colors.dart';

class TextHeadingSmall extends StatelessWidget {
  final String title;
  const TextHeadingSmall({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 16,
        color: AppColor.secondary,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
