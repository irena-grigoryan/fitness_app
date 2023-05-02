import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/core/constants/color_constants.dart';
import 'package:fitness_app/core/constants/path_constants.dart';
import 'package:fitness_app/core/constants/text_constants.dart';
import 'package:fitness_app/screens/settings/settings_cubit.dart';
import 'package:fitness_app/widgets/app_dialogs.dart';
import 'package:fitness_app/widgets/app_loading.dart';
import 'package:fitness_app/widgets/app_settings_container.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
        color: ColorConstants.backgroundColor,
        height: double.infinity,
        width: double.infinity,
        child: Stack(children: [
          _getSettingsBody(context),
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              if (state is SettingsLoadingState) {
                if (state.isShow) {
                  return _getLoading();
                }
              } else {
                return const SizedBox();
              }
              return const SizedBox();
            },
          ),
        ]));
  }

  Widget _getSettingsBody(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    String? displayName = user?.displayName ?? 'No Username';
    String? email = user?.email ?? 'No email';
    var photoUrl = user?.photoURL;
    final cubit = BlocProvider.of<SettingsCubit>(context);
    return SafeArea(
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
                            image: photoUrl,
                            fit: BoxFit.cover,
                            width: 200,
                            height: 120,
                          )),
                        ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(displayName,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      Text(email,
                          style: const TextStyle(
                            fontSize: 16,
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
                    displayName = newName;
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
                  //action
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
                  Dialogs.showDialogBox(
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
                  Dialogs.showDialogBox(
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
}
