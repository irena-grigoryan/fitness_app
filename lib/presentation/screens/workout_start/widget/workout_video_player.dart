import 'package:chewie/chewie.dart';
import 'package:fitness_app/core/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WorkoutVideoPlayer extends StatefulWidget {
  WorkoutVideoPlayer();
  @override
  _WorkoutVideoPlayerState createState() => _WorkoutVideoPlayerState();
}

class _WorkoutVideoPlayerState extends State<WorkoutVideoPlayer> {
  late ChewieController _chewieController;
  // late VideoPlayerController _controller;
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    const url =
        'https://www.youtube.com/watch?v=l1BNMmCRHZQ&list=PLLALQuK1NDrgYGaZTxm3qsuJnpZlO2Z7J&index=9';
    final id = YoutubePlayer.convertUrlToId(url);

    _youtubeController = YoutubePlayerController(
        initialVideoId: id!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          controlsVisibleAtStart: true,
          enableCaption: false,
          loop: true,
        ));

    // _controller = VideoPlayerController.network(id);

    // for example

    // _chewieController = ChewieController(
    //     videoPlayerController: _controller,
    //     autoInitialize: true,
    //     aspectRatio: 15 / 10,
    //     looping: true,
    //     autoPlay: false,
    //     placeholder: Center(child: CupertinoActivityIndicator()),
    //     deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
    //     materialProgressColors:
    //         ChewieProgressColors(playedColor: ColorConstants.mainColor));
    super.initState();
  }

  @override
  void dispose() {
    // _chewieController.dispose();
    // _controller.dispose();
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
        // AspectRatio(
        // aspectRatio: _youtubeController.value,
        // child:
        _getContainer();
    // _getVideo();
    // );
  }

  Widget _getVideo() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: YoutubePlayer(
        controller: _youtubeController,
        aspectRatio: 20 / 10,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
        progressColors: ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),
      ),
    );
  }

  Widget _getContainer() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Theme(
        child: YoutubePlayer(
          controller: _youtubeController,
          aspectRatio: 16 / 9,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.amber,
          progressColors: ProgressBarColors(
            playedColor: Colors.amber,
            handleColor: Colors.amberAccent,
          ),
        ),
        // Chewie(controller: _chewieController),
        data: Theme.of(context).copyWith(platform: TargetPlatform.android),
      ),
    );
  }
}
