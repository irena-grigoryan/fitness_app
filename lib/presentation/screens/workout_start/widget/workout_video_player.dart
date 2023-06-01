import 'package:chewie/chewie.dart';
import 'package:fitness_app/core/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class WorkoutVideoPlayer extends StatefulWidget {
  WorkoutVideoPlayer();
  @override
  _WorkoutVideoPlayerState createState() => _WorkoutVideoPlayerState();
}

class _WorkoutVideoPlayerState extends State<WorkoutVideoPlayer> {
  late ChewieController _chewieController;
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4 '); // for example

    _chewieController = ChewieController(
        videoPlayerController: _controller,
        autoInitialize: true,
        aspectRatio: 15 / 10,
        looping: true,
        autoPlay: false,
        placeholder: Center(child: CupertinoActivityIndicator()),
        deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
        materialProgressColors:
            ChewieProgressColors(playedColor: ColorConstants.mainColor));
    super.initState();
  }

  @override
  void dispose() {
    _chewieController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: _getContainer(),
    );
  }

  Widget _getContainer() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Theme(
        child: Chewie(controller: _chewieController),
        data: Theme.of(context).copyWith(platform: TargetPlatform.android),
      ),
    );
  }
}
