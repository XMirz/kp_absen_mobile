import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kp_mobile/app/modules/root/controllers/root_controller.dart';
import 'package:kp_mobile/app/utils/helper.dart';
import 'package:kp_mobile/app/values/colors.dart';
import 'package:kp_mobile/app/widgets/layouts/modal_layout.dart';
import 'package:kp_mobile/app/widgets/text.dart';

class UpdatePasswordModal extends StatelessWidget {
  UpdatePasswordModal({Key? key}) : super(key: key);
  final controller = Get.find<RootController>();
  final formKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ModalLayout(
        title: 'Ubah password',
        onTapSubmit: () {
          submitForm();
        },
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextBody(title: 'Password lama'),
              spaceY(8),
              buildTextFormField(
                  errorMessage: 'Masukkan password lama!',
                  textController: oldPasswordController),
              spaceY(24),
              TextBody(title: 'Password baru'),
              spaceY(8),
              buildTextFormField(
                  errorMessage: 'Masukkan password baru!',
                  textController: newPasswordController),
              spaceY(24),
              TextBody(title: 'Konfirmasi password.'),
              spaceY(8),
              buildTextFormField(
                  errorMessage: 'Password dan konfirmasi tidak cocok',
                  textController: confirmPasswordController,
                  validator: (value, errorMessage) {
                    if (newPasswordController.text !=
                        confirmPasswordController.text) {
                      return errorMessage;
                    }
                    return null;
                  }),
              spaceY(24),
            ],
          ),
        ));
  }

  Widget buildTextFormField(
      {required String errorMessage,
      required TextEditingController textController,
      Function? validator}) {
    return TextFormField(
      controller: textController,
      obscureText: controller.updatePasswordObsecured.value,
      decoration: InputDecoration(
        focusColor: AppColor.accent,
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: buildSuffixIcon(),
      ),
      validator: validator != null
          ? (value) {
              return validator(value, errorMessage);
            }
          : (value) {
              if (value == null || value.isEmpty) {
                return (value == null || value.isEmpty) ? errorMessage : null;
              }
              return null;
            },
    );
  }

  Widget buildSuffixIcon() {
    return IconButton(
      onPressed: () {
        controller.updatePasswordObsecured.value =
            !controller.updatePasswordObsecured.value;
      },
      icon: (controller.updatePasswordObsecured.value)
          ? HeroIcon(
              HeroIcons.eyeOff,
              color: AppColor.secondary,
            )
          : HeroIcon(
              HeroIcons.eye,
              color: AppColor.secondary,
            ),
    );
  }

  void submitForm() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    final Map<String, String> data = {
      "oldPassword": oldPasswordController.text,
      "newPassword": newPasswordController.text,
    };
    await controller.updatePassword(data);
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }
}
