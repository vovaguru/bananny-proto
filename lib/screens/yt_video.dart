import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/video_model.dart';

class VideoScreen extends StatefulWidget {
  final String id;
  final Video video;

  const VideoScreen({super.key, required this.id, required this.video});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController _controller;
  bool _showAppBar = true;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        useHybridComposition: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _showAppBar ? AppBar() : null,
        body: YoutubePlayerBuilder(
            onEnterFullScreen: () {
              setState(() => _showAppBar = false);
            },
            onExitFullScreen: () {
              setState(() => _showAppBar = true);
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                  overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
            },
            player: YoutubePlayer(controller: _controller),
            builder: (context, player) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    player,
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        widget.video.description!,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
