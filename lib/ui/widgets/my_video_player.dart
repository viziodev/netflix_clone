import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../shared/constants.dart';

class MyVideoPlayer extends StatefulWidget {
  final String movieId;
  final YoutubePlayerController? controller;
  const MyVideoPlayer({Key? key, required this.movieId, this.controller})
      : super(key: key);

  @override
  State<MyVideoPlayer> createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  YoutubePlayerController? _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _controller = widget.controller;
    _controller = YoutubePlayerController(
      initialVideoId: widget.movieId,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        hideThumbnail: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller == null
        ? Center(
            child: SpinKitFadingCircle(
              color: bbwPrimaryColor,
              size: 20,
            ),
          )
        : YoutubePlayer(
            controller: _controller!,
            progressColors: ProgressBarColors(
              handleColor: bbwPrimaryColor,
              playedColor: bbwPrimaryColor,
            ),
            onEnded: (YoutubeMetaData meta) {
              _controller!.play();
              _controller!.pause();
            },
          );
  }
}
