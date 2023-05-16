import 'package:fitness_app/core/constants/color_constants.dart';
import 'package:fitness_app/core/constants/path_constants.dart';
import 'package:fitness_app/core/constants/text_constants.dart';
import 'package:fitness_app/screens/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({
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
          const SizedBox(height: 35),
          _getOffer(context),
          const SizedBox(height: 30),
          _getExercisesList(context),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget _getExercisesList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            TextConstants.topWorkouts,
            style: TextStyle(
              color: ColorConstants.textBlack,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _getProfileData(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return GestureDetector(
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
                                image: photoUrl!,
                                fit: BoxFit.cover,
                                width: 200,
                                height: 120))),
                onTap: () {
                  Navigator.of(context).pushNamed('/update_profile');
                },
              );
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
      ),
    );
  }

  Widget _getOffer(BuildContext context) {
    return InkWell(
      onTap: () {
        //navigate to workouts screen
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
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
