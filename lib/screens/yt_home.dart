import 'package:bananny/utilities/keys.dart';
import 'package:flutter/material.dart';
import 'package:bananny/models/channel_model.dart';
import 'package:bananny/models/video_model.dart';
import 'package:bananny/screens/yt_video.dart';
import 'package:bananny/services/api_service.dart';

class YtScreen extends StatefulWidget {
  const YtScreen({super.key});

  @override
  State<YtScreen> createState() => _YtScreenState();
}

class _YtScreenState extends State<YtScreen> {
  Channel? _channel;
  bool _isLoading = false;
  late Future<Channel> channelFuture;

  @override
  void initState() {
    super.initState();
    channelFuture = getChannel();
  }

  Future<Channel> getChannel() async {
    Channel channel =
        await APIService.instance.fetchChannel(channelId: CURRENT_PLAYLIST);
    setState(() {
      _channel = channel;
    });
    return channel;
  }

  _buildProfileInfo() {
    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(20.0),
      height: 100.0,
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 35.0,
            backgroundImage: NetworkImage(_channel!.profilePictureUrl),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _channel!.title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${_channel!.subscriberCount} подписчиков',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildVideo(Video video) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VideoScreen(id: video.id, video: video),
        ),
      ),
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        elevation: 3,
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(video.thumbnailUrl),
                    fit: BoxFit.cover,
                    alignment: Alignment.center),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                video.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance
        .fetchVideosFromPlaylist(playlistId: _channel!.uploadPlaylistId);
    setState(() {
      _channel!.videos!.addAll(moreVideos);
    });
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Детское ТВ'),
      ),
      body: FutureBuilder<Channel>(
          future: channelFuture,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              Channel? respChannel = snapshot.data;

              return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollDetails) {
                  if (!_isLoading &&
                      respChannel!.videos?.length !=
                          int.parse(respChannel.videoCount) &&
                      scrollDetails.metrics.pixels ==
                          scrollDetails.metrics.maxScrollExtent) {
                    _loadMoreVideos();
                  }
                  return false;
                },
                child: ListView.builder(
                  itemCount: 1 + _channel!.videos!.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return _buildProfileInfo();
                    }
                    Video video = _channel!.videos![index - 1];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: _buildVideo(video),
                    );
                  },
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          })),
    );
  }
}
