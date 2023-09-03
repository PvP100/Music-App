import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/features/presentation/blocs/register/register_bloc.dart';
import 'package:music_app/features/presentation/ui/common_widgets/widgets.dart';
import 'package:music_app/features/presentation/ui/screen/base_screen_state.dart';
import '../../../../../core/core.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState
    extends BaseScreenState<RegisterScreen, RegisterBloc, RegisterState> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget buildContent(BuildContext context) {
    return Column(
      children: [
        HaMusicAppBar(title: localizations.register),
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            CommonTextField(
              controller: _usernameController,
              hintText: localizations.emailOrPhone,
            ),
            CommonTextField(
              controller: _passwordController,
              hintText: localizations.password,
              isPassword: true,
              margin: const EdgeInsets.symmetric(vertical: 12),
            ),
            CommonTextField(
              controller: _rePasswordController,
              isPassword: true,
              hintText: localizations.reEnterPassword,
            ),
            CommonTextField(
              controller: _fullNameController,
              margin: const EdgeInsets.symmetric(vertical: 12),
              hintText: localizations.fullName,
            ),
            Container(
              height: 45,
              padding: const EdgeInsets.only(left: 13),
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                color: AppColors.color3E3E3E,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: BlocSelector<RegisterBloc, RegisterState, String?>(
                  selector: (state) => state.birthday?.convertToString(),
                  builder: (context, value) {
                    return Text(
                      value ?? localizations.birthday,
                      style: AppTextStyles.medium.copyWith(
                        color: value != null
                            ? Colors.white
                            : AppColors.color999999,
                        fontSize: 14,
                      ),
                    );
                  }),
            ).onCupertinoClick(() {
              context.showDatePicker((date) {
                bloc.add(OnBirthdaySelectedEvent(date));
              }, initialDate: bloc.state.birthday, maxDate: DateTime.now());
            }),
            CommonButton(
                margin: const EdgeInsets.only(top: 50),
                title: localizations.register,
                onClick: () {
                  bloc.add(OnRegisterEvent(
                    username: _usernameController.text.trim(),
                    password: _passwordController.text.trim(),
                    rePassword: _rePasswordController.text.trim(),
                    fullName: _fullNameController.text.trim(),
                  ));
                })
          ]),
        ).expanded()
      ],
    );
  }
}
