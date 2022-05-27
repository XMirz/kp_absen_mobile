import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kp_mobile/app/utils/helper.dart';
import 'package:kp_mobile/app/values/colors.dart';
import 'package:kp_mobile/app/widgets/text.dart';

class ModalLayout extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? submitIcon;
  final Function? onTapCancel;
  final Function? onTapSubmit;
  ModalLayout(
      {Key? key,
      required this.title,
      this.onTapCancel,
      this.onTapSubmit,
      this.submitIcon,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Modal title
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      onTapCancel != null ? onTapCancel!() : Get.back();
                    },
                    child: HeroIcon(HeroIcons.x)),
                spaceX(8),
                TextHeading(title: title),
                Spacer(),
                onTapSubmit != null
                    ? InkWell(
                        onTap: () {
                          onTapSubmit != null ? onTapSubmit!() : null;
                        },
                        child: submitIcon ??
                            HeroIcon(
                              HeroIcons.check,
                              color: AppColor.accent,
                              size: 28,
                            ),
                      )
                    : Container(),
                spaceX(8),
              ],
            ),
            spaceY(16),
            // modal content
            Flexible(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
