import 'package:color_extractor/widgets/video_images.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class GenThumbnailImage extends StatefulWidget {
  final ThumbnailRequest thumbnailRequest;

  const GenThumbnailImage({Key? key, required this.thumbnailRequest})
      : super(key: key);

  @override
  _GenThumbnailImageState createState() => _GenThumbnailImageState();
}

class _GenThumbnailImageState extends State<GenThumbnailImage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.thumbnailRequest.video);
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      setState(() {
        _controller.setLooping(true);
        _controller.play();
        _isPlaying = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ThumbnailResult>(
      future: genThumbnail(widget.thumbnailRequest),
      builder: (BuildContext context, AsyncSnapshot<ThumbnailResult> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Generating the thumbnail for: ${widget.thumbnailRequest.video}...",
              ),
              const SizedBox(
                height: 10.0,
              ),
              const CircularProgressIndicator(),
            ],
          );
        } else if (snapshot.hasData) {
          final _width = snapshot.data!.width;
          final _height = snapshot.data!.height;
          final _dataSize = snapshot.data!.dataSize;
          final _dominantColors = snapshot.data!.dominantColors;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  "Image ${widget.thumbnailRequest.thumbnailPath == null ? 'data size' : 'file size'}: $_dataSize, width:$_width, height:$_height",
                ),
              ),
              Container(
                color: Colors.grey,
                height: 1.0,
              ),
              SizedBox(
                height: 300, // Adjust the height as needed
                child: FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          ),
                          IconButton(
                            icon: _isPlaying
                                ? const Icon(Icons.pause)
                                : const Icon(Icons.play_arrow),
                            onPressed: () {
                              setState(() {
                                if (_isPlaying) {
                                  _controller.pause();
                                } else {
                                  _controller.play();
                                }
                                _isPlaying = !_isPlaying;
                              });
                            },
                          ),
                        ],
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Column(
                children: _dominantColors.map((color) {
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    color: color.color,
                    height: 50,
                    width: double.infinity,
                    child: Text(
                      "${color.color.toString()} - ${(color.population / (_width * _height) * 100).toStringAsFixed(2)}%",
                      style: TextStyle(color: color.bodyTextColor),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.red,
            child: Text(
              "Error:\n${snapshot.error.toString()}",
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
