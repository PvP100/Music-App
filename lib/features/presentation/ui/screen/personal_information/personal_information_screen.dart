import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_app/core/constants/image_constants.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/presentation/ui/common_widgets/widgets.dart';
import 'package:music_app/features/presentation/ui/screen/base_screen_state.dart';
import 'package:music_app/utils/app_utils.dart';

import '../../../blocs/blocs.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends BaseScreenState<
    PersonalInformationScreen,
    PersonalInformationBloc,
    PersonalInformationState> {
  _getImage() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image?.path != null) {
      bloc.updateAvatar(image!.path);
    }
  }

  @override
  Widget buildContent(BuildContext context) {
    return BlocBuilder<PersonalInformationBloc, PersonalInformationState>(
        builder: (context, state) {
      return Column(
        children: [
          const HaMusicAppBar(title: "Thông tin cá nhân"),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  child: Stack(
                    children: [
                      Container(
                        height: 90,
                        width: 90,
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: state.profile?.avatar
                            ?.filePathUrl()
                            .loadImageUrl(
                              errorWidget: ImageConstants.iconAvatarPlaceholder
                                  .loadImageAsset(height: 90, width: 90),
                            ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: ImageConstants.iconEdit
                            .loadImageAsset(height: 24, width: 24),
                      )
                    ],
                  ).onCupertinoClick(_getImage),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 10),
                  child: Text(
                    "Thông tin cá nhân",
                    style: AppTextStyles.medium.copyWith(
                      fontSize: 14,
                      color: AppColors.colorCACACA,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.color3D3D3D,
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.29, horizontal: 15),
                        child: Row(
                          children: [
                            Text(
                              "Họ",
                              style: AppTextStyles.medium.copyWith(
                                fontSize: 16,
                                color: AppColors.color999999,
                              ),
                            ),
                            Text(
                              "${state.profile?.lastName}",
                              textAlign: TextAlign.end,
                              style: AppTextStyles.medium,
                            ).expanded(),
                            ImageConstants.iconRightArrow
                                .loadImageAsset(height: 24, width: 24),
                          ],
                        ),
                      ).onCupertinoClick(() => _showPopup(
                          "Họ", "last_name", state.profile?.lastName ?? "")),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.29, horizontal: 15),
                        child: Row(
                          children: [
                            Text(
                              "Tên",
                              style: AppTextStyles.medium.copyWith(
                                fontSize: 16,
                                color: AppColors.color999999,
                              ),
                            ),
                            Text(
                              "${state.profile?.firstName}",
                              textAlign: TextAlign.end,
                              style: AppTextStyles.medium,
                            ).expanded(),
                            ImageConstants.iconRightArrow
                                .loadImageAsset(height: 24, width: 24),
                          ],
                        ),
                      ).onCupertinoClick(() => _showPopup(
                          "Tên", "first_name", state.profile?.firstName ?? "")),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 10),
                  child: Text(
                    "Thông tin tài khoản",
                    style: AppTextStyles.medium.copyWith(
                      fontSize: 14,
                      color: AppColors.colorCACACA,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.color3D3D3D,
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.29, horizontal: 15),
                        child: Row(
                          children: [
                            Text(
                              "Email",
                              style: AppTextStyles.medium.copyWith(
                                fontSize: 16,
                                color: AppColors.color999999,
                              ),
                            ),
                            Text(
                              state.profile?.email ?? "",
                              textAlign: TextAlign.end,
                              style: AppTextStyles.medium,
                            ).expanded(),
                            ImageConstants.iconRightArrow
                                .loadImageAsset(height: 24, width: 24),
                          ],
                        ),
                      ).onCupertinoClick(() => _showPopup(
                          "Email", "email", state.profile?.email ?? ""))
                    ],
                  ),
                )
              ],
            ).paddingSymmetric(horizontal: 20),
          ).expanded(),
        ],
      );
    });
  }

  _showPopup(String title, String key, [String? data]) {
    final TextEditingController controller = TextEditingController(text: data);
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: CupertinoTextField(controller: controller),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as deletion, and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                bloc.updateProfile({key: controller.text.trim()});
                controller.dispose();
                Navigator.pop(context);
              } else {
                AppUtils.showToast("Không được để trống");
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}
