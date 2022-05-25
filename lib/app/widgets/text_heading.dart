import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
