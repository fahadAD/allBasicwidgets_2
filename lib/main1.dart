import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  //any video
  late VideoPlayerController _videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;
  String videoUrl = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";
  loadVideo(){
    _videoPlayerController= VideoPlayerController.network(videoUrl)..initialize().then((value) {setState(() {});});
    _customVideoPlayerController= CustomVideoPlayerController(
      context: context,
      videoPlayerController: _videoPlayerController,
      customVideoPlayerSettings: CustomVideoPlayerSettings(
          placeholderWidget: Center(child: CircularProgressIndicator()),
          deviceOrientationsAfterFullscreen: [
            DeviceOrientation.portraitUp,
          ]
      ),

    );


  }

//just you tube video

  late YoutubePlayerController _controller;

youtubeLoadvideo(){
  _controller=YoutubePlayerController(
    // initialVideoId: 'iLnmTe5Q2Qw',
    initialVideoId: 'gQDByCdjUXw',
    flags: const YoutubePlayerFlags(
      autoPlay: true,
      mute: true,
    ),
  );
}


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadVideo();
    youtubeLoadvideo();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _customVideoPlayerController.dispose();
  }
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: true,
              child:  ListTile(
                leading:  CircleAvatar(
                  radius:30,
                  backgroundColor: Colors.white,
                ),
                title:  Container(
                  width: 100,
                  height: 10,
                  color: Colors.white,
                ),
                subtitle:  Container(
                  width: 100,
                  height: 10,
                  color: Colors.white,
                ),
                trailing:  CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20,),

            Container(
                height: 200,
                width: double.infinity,
                child: CustomVideoPlayer(customVideoPlayerController: _customVideoPlayerController)),
            SizedBox(height: 20,),


            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.red,
              progressColors: ProgressBarColors(playedColor: Colors.green, handleColor: Colors.amberAccent,),
              onReady: () {},
            ),
          ],
        ),
      ),
    );
  }
}
