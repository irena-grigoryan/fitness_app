import 'package:fitness_app/core/constants/color_constants.dart';
import 'package:fitness_app/core/constants/path_constants.dart';
import 'package:fitness_app/core/constants/text_constants.dart';
import 'package:fitness_app/screens/home/home_screen.dart';
import 'package:fitness_app/screens/main/main_cubit.dart';
import 'package:fitness_app/screens/settings/settings_screen.dart';
import 'package:fitness_app/screens/workouts/workouts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<MainCubit>(context);
        return Scaffold(
          body: _getBody(context, cubit.currentIndex),
          bottomNavigationBar: _getBottomNavigationBar(context),
        );
      },
    );
  }

  Widget _getBottomNavigationBar(BuildContext context) {
    final cubit = BlocProvider.of<MainCubit>(context);
    return BottomNavigationBar(
      currentIndex: cubit.currentIndex,
      fixedColor: ColorConstants.mainColor,
      items: [
        BottomNavigationBarItem(
          icon: Image(
            width: 30,
            height: 30,
            image: const AssetImage(PathConstants.workouts),
            color: cubit.currentIndex == 0
                ? ColorConstants.mainColor
                : ColorConstants.grey,
          ),
          label: TextConstants.workoutsText,
        ),
        BottomNavigationBarItem(
          icon: Image(
            width: 26,
            height: 26,
            image: const AssetImage(PathConstants.home),
            color: cubit.currentIndex == 1
                ? ColorConstants.mainColor
                : ColorConstants.grey,
          ),
          label: TextConstants.homeText,
        ),
        BottomNavigationBarItem(
          icon: Image(
            width: 26,
            height: 26,
            image: const AssetImage(PathConstants.settings),
            color: cubit.currentIndex == 2
                ? ColorConstants.mainColor
                : ColorConstants.grey,
          ),
          label: TextConstants.settingsText,
        ),
      ],
      onTap: (index) {
        cubit.selectItem(index);
      },
    );
  }

  Widget _getBody(BuildContext context, int index) {
    final children = [
      const WorkoutsScreen(),
      const HomeScreen(),
      const SettingsScreen()
    ];
    return children[index];
  }
}
