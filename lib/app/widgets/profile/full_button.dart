import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kp_mobile/app/widgets/text.dart';

class ProfileFullButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color color;
  const ProfileFullButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 0.5),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            onPressed();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextBodyLargeBold(title: text, color: color),
                HeroIcon(
                  HeroIcons.chevronRight,
                  color: color,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
