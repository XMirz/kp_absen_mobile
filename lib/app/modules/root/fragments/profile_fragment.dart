import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kp_mobile/app/data/models/user.dart';
import 'package:kp_mobile/app/modules/root/controllers/root_controller.dart';
import 'package:kp_mobile/app/utils/helper.dart';
import 'package:kp_mobile/app/values/colors.dart';
import 'package:kp_mobile/app/widgets/profile/full_button.dart';
import 'package:kp_mobile/app/widgets/profile/image_card.dart';
import 'package:kp_mobile/app/widgets/profile/profile_info_card.dart';
import 'package:kp_mobile/app/modules/root/views/update_password.dart';

class ProfileFragment extends StatelessWidget {
  const ProfileFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RootController>();
    User user = controller.user.value;
    return ListView(
      children: [
        spaceY(16),
        ImageCard(),
        spaceY(4),
        ProfileInfoCard(label: 'Email', value: user.email ?? '-'),
        ProfileInfoCard(
            label: 'Jenis kelamin',
            value: user.gender == 'L' ? 'Laki-laki' : 'Perempuan'),
        ProfileInfoCard(label: 'Jabatan', value: user.role ?? '-'),
        ProfileInfoCard(label: 'Alamat', value: user.address ?? '-'),
        ProfileInfoCard(
            label: 'Tanggal lahir',
            value: user.birthDate != null
                ? DateFormat('EEEE, dd MMMM yyyy').format(user.birthDate!)
                : '-'),
        ProfileFullButton(
            onPressed: () {
              Get.to(
                UpdatePasswordView(),
                transition: Transition.downToUp,
              );
            },
            text: 'Ubah password',
            color: AppColor.secondary),
        ProfileFullButton(
            onPressed: () {
              controller.logout();
            },
            text: 'Keluar',
            color: AppColor.error)
      ],
    );
  }
}
