import 'package:fitness_app/core/constants/color_constants.dart';
import 'package:fitness_app/core/constants/data_constants.dart';
import 'package:fitness_app/core/constants/path_constants.dart';
import 'package:fitness_app/core/constants/text_constants.dart';
import 'package:fitness_app/data/workouts_data.dart';
import 'package:fitness_app/screens/home/home_cubit.dart';
import 'package:fitness_app/screens/home/widget/home_workout_progress.dart';
import 'package:fitness_app/screens/home/widget/home_workout_card.dart';
import 'package:fitness_app/screens/main/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeContent extends StatefulWidget {
  final List<WorkoutData> workouts;

  HomeContent({
    required this.workouts,
    Key? key,
  }) : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String? userName;
  String? photoUrl;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeFillDataState) {
          _fillData();
        }
        return Container(
          color: ColorConstants.backgroundColor,
          height: double.infinity,
          width: double.infinity,
          child: _getMainContent(context),
        );
      },
    );
  }

  Widget _getMainContent(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          _getProfileData(context),
          const SizedBox(height: 25),
          _getOffer(context),
          const SizedBox(height: 25),
          _getExercisesList(context),
          const SizedBox(height: 25),
          HomeWorkoutProgress(),
        ],
      ),
    );
  }

  Widget _getExercisesList(BuildContext context) {
    final cubitMain = BlocProvider.of<MainCubit>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                TextConstants.topWorkouts,
                style: TextStyle(
                  color: ColorConstants.textBlack,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  cubitMain.selectItem(0);
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(12, 2, 12, 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: ColorConstants.mainColor),
                  child: Text(
                    'View all',
                    style: TextStyle(
                      color: ColorConstants.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 188,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(width: 20),
              WorkoutCard(
                  color: ColorConstants.purple,
                  workout: DataConstants.topWorkouts[0],
                  onTap: () {
                    // go to detail screen
                  }),
              const SizedBox(width: 15),
              WorkoutCard(
                  color: ColorConstants.turquoise,
                  workout: DataConstants.topWorkouts[1],
                  onTap: () {
                    // go to detail screen
                  }),
              SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getProfileData(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final userName =
              state is HomeFillDataState ? state.userName : 'Dear friend';
          final photoUrl = state is HomeFillDataState ? state.photoURL : null;
          return Row(
            children: [
              GestureDetector(
                child: photoUrl == null
                    ? const SizedBox(
                        height: 54,
                        width: 54,
                        child: CircleAvatar(
                            backgroundColor: ColorConstants.white,
                            backgroundImage: AssetImage(PathConstants.profile),
                            radius: 60),
                      )
                    : CircleAvatar(
                        radius: 25,
                        child: ClipOval(
                            child: FadeInImage.assetNetwork(
                                placeholder: PathConstants.profile,
                                image: photoUrl,
                                fit: BoxFit.cover,
                                width: 200,
                                height: 120))),
                onTap: () {
                  Navigator.of(context).pushNamed('/update_profile');
                },
              ),
              const SizedBox(
                width: 24,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi, $userName!',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    TextConstants.checkActivity,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _getOffer(BuildContext context) {
    final cubitMain = BlocProvider.of<MainCubit>(context);
    return InkWell(
      onTap: () {
        cubitMain.selectItem(0);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: ColorConstants.white,
          boxShadow: [
            BoxShadow(
              color: ColorConstants.textBlack.withOpacity(0.12),
              blurRadius: 5.0,
              spreadRadius: 1.1,
            ),
          ],
        ),
        child: Row(
          children: [
            const Image(
              image: AssetImage(
                PathConstants.play,
              ),
            ),
            const SizedBox(width: 18),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    TextConstants.newDay,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    TextConstants.exerciseOffer,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _fillData() {
    final cubit = BlocProvider.of<HomeCubit>(context);
    userName = cubit.userName;
    photoUrl = cubit.photoUrl;
  }
}
