// import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/presentation/constants/color_constants.dart';
import 'package:fitness_app/presentation/constants/path_constants.dart';
import 'package:fitness_app/presentation/constants/text_constants.dart';
import 'package:fitness_app/domain/entities/user_entity.dart';
import 'package:fitness_app/presentation/screens/settings/settings_cubit.dart';
import 'package:fitness_app/presentation/widgets/app_dialogs.dart';
import 'package:fitness_app/presentation/widgets/app_loading.dart';
import 'package:fitness_app/presentation/widgets/app_settings_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsContent extends StatefulWidget {
  const SettingsContent({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsContent> createState() => _SettingsContentState();
}

class _SettingsContentState extends State<SettingsContent> {
  String? userName;
  String? email;
  String? photoUrl;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        if (state is SettingsLoadingState) {
          if (state.isShow) {
            return _getLoading();
          }
        } else if (state is SettingsFillDataState) {
          _fillData(state.user, context);
        } else if (state is SettingsErrorFillDataState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Dialogs.showInformDialog(
                context: context,
                content: 'Please login again',
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/login');
                });
          });
        } else {
          return Center(
              child: CupertinoActivityIndicator(
            radius: 17,
          ));
        }
        return Container(
            color: ColorConstants.backgroundColor,
            height: double.infinity,
            width: double.infinity,
            child: Stack(children: [
              _getSettingsBody(context),
            ]));
      },
    );
  }

  Widget _getSettingsBody(BuildContext context) {
    final cubit = BlocProvider.of<SettingsCubit>(context);
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 34, left: 24, right: 24),
          child: Column(children: [
            Stack(alignment: Alignment.topRight, children: [
              Container(),
              Row(
                children: [
                  photoUrl == null
                      ? const CircleAvatar(
                          backgroundColor: ColorConstants.white,
                          backgroundImage: AssetImage(PathConstants.profile),
                          radius: 60)
                      : CircleAvatar(
                          backgroundColor: ColorConstants.white,
                          radius: 60,
                          child: ClipOval(
                              child: FadeInImage.assetNetwork(
                            placeholder: PathConstants.profile,
                            image: photoUrl!,
                            fit: BoxFit.cover,
                            width: 200,
                            height: 120,
                          )),
                        ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userName ?? '',
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      Text(email ?? '',
                          style: const TextStyle(
                            fontSize: 15,
                          )),
                    ],
                  ),
                ],
              ),
            ]),
            const SizedBox(height: 30),
            SettingsContainer(
                withArrow: true,
                icon: PathConstants.updateProfile,
                onTap: () async {
                  String? newName = await Navigator.pushNamed<dynamic>(
                      context, '/update_profile');
                  setState(() {
                    userName = newName;
                  });
                },
                child: const Text(TextConstants.updateProfile,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ))),
            SettingsContainer(
                withArrow: true,
                icon: PathConstants.notification,
                onTap: () {
                  Navigator.of(context).pushNamed('/notifications');
                },
                child: const Text(TextConstants.notifications,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ))),
            Divider(),
            SettingsContainer(
                icon: PathConstants.deactivate,
                onTap: () {
                  Dialogs.showSelectionDialog(
                      context: context,
                      content: TextConstants.deactivateDialog,
                      onPressed: () {
                        cubit.deactivateAccount();
                      });
                },
                child: const Text(TextConstants.deactivate,
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w500))),
            SettingsContainer(
                icon: PathConstants.logout,
                onTap: () {
                  Dialogs.showSelectionDialog(
                      context: context,
                      content: TextConstants.logoutDialog,
                      onPressed: () {
                        cubit.logout();
                      });
                },
                child: const Text(TextConstants.logout,
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w500))),
            const SizedBox(height: 15),
          ]),
        ),
      ),
    );
  }

  Widget _getLoading() {
    return const AppLoading();
  }

  void _fillData(UserEntity user, BuildContext context) {
    if (user.name != null) {
      userName = user.name;
    }
    if (user.email != null) {
      email = user.email;
    }
    if (user.photo != null) {
      photoUrl = user.photo;
    }
  }
}
