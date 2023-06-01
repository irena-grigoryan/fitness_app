import 'package:dots_indicator/dots_indicator.dart';
import 'package:fitness_app/core/constants/color_constants.dart';
import 'package:fitness_app/core/constants/data_constants.dart';
import 'package:fitness_app/core/constants/text_constants.dart';
import 'package:fitness_app/presentation/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/di/dependency_injections.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'introduction_cubit.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<IntroductionCubit>(
      create: (context) => di.sl(),
      child: BlocConsumer<IntroductionCubit, IntroductionState>(
        listener: (context, state) {
          if (state is IntroductionNextScreenState) {
            Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
          }
        },
        builder: (context, state) {
          return getScreen(context);
        },
      ),
    );
  }

  SafeArea getScreen(BuildContext context) {
    var cubit = context.read<IntroductionCubit>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: _getPageView(cubit.pageController, pageIndex),
            ),
            Expanded(
              flex: 2,
              child: _getStatic(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getPageView(PageController controller, pageIndex) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      controller: controller,
      children: DataConstants.introductionText,
    );
  }

  Widget _getStatic(BuildContext context) {
    var cubit = context.read<IntroductionCubit>();
    final percent = _getPercent(cubit.pageIndex);
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        DotsIndicator(
          dotsCount: 3,
          position: cubit.pageIndex.toDouble(),
          decorator: const DotsDecorator(
            color: Colors.grey,
            activeColor: ColorConstants.mainColor,
          ),
        ),
        const Spacer(),
        TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: percent),
            duration: const Duration(seconds: 1),
            builder: (context, value, _) => CircularPercentIndicator(
                  radius: 54,
                  backgroundColor: ColorConstants.mainColor,
                  progressColor: ColorConstants.white,
                  percent: 1 - value,
                  center: Material(
                    shape: const CircleBorder(),
                    color: ColorConstants.mainColor,
                    child: RawMaterialButton(
                      shape: const CircleBorder(),
                      onPressed: () {
                        cubit.nextScreen();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Icon(
                          Icons.east_rounded,
                          size: 38.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )),
        const SizedBox(height: 5),
        TextButton(
          child: Text(
            TextConstants.skip,
            style: TextStyle(
              color: ColorConstants.mainColor,
              fontSize: 16,
            ),
          ),
          onPressed: () {
            cubit.skipIntro();
          },
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  double _getPercent(int pageIndex) {
    switch (pageIndex) {
      case 0:
        return 0.20;
      case 1:
        return 0.55;
      case 2:
        return 1;
      default:
        return 0;
    }
  }
}
