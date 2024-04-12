import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../widgets/image_widget.dart';
import '../widgets/video_images.dart';

class DemoHome extends StatefulWidget {
  const DemoHome({Key? key}) : super(key: key);

  @override
  _DemoHomeState createState() => _DemoHomeState();
}

class _DemoHomeState extends State<DemoHome> {
  final _editNode = FocusNode();
  final _video = TextEditingController(
    text:
        "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  );
  ImageFormat _format = ImageFormat.JPEG;
  int _quality = 50;
  int _sizeH = 0;
  int _sizeW = 0;
  int _timeMs = 0;

  GenThumbnailImage? _futureImage;

  late String _tempDir;

  @override
  void initState() {
    super.initState();
    getTemporaryDirectory().then((d) => _tempDir = d.path);
  }

  @override
  Widget build(BuildContext context) {
    final _settings = <Widget>[
      Slider(
        value: _quality * 1.0,
        onChanged: (v) => setState(() {
          _editNode.unfocus();
          _quality = v.toInt();
        }),
        max: 100.0,
        divisions: 100,
        label: "$_quality",
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thumbnail Plugin example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 8.0),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                isDense: true,
                labelText: "Video URI",
              ),
              maxLines: null,
              controller: _video,
              focusNode: _editNode,
              keyboardType: TextInputType.url,
              textInputAction: TextInputAction.done,
              onEditingComplete: () {
                _editNode.unfocus();
              },
            ),
          ),
          for (var i in _settings) i,
          Expanded(
            child: Container(
              color: Colors.grey[300],
              child: Scrollbar(
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    if (_futureImage != null) _futureImage!,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              title: const Text("Settings"),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
            for (var i in _settings) i,
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () async {
              final ImagePicker _picker = ImagePicker();
              XFile? video =
                  await _picker.pickVideo(source: ImageSource.gallery);
              if (video != null) {
                setState(() {
                  _video.text = video.path;
                });
              }
            },
            tooltip: "Select a video from gallery",
            child: const Icon(Icons.videocam),
          ),
          const SizedBox(width: 5.0),
          FloatingActionButton(
            tooltip: "Generate a data of thumbnail",
            onPressed: () async {
              setState(() {
                _futureImage = GenThumbnailImage(
                  thumbnailRequest: ThumbnailRequest(
                    video: _video.text,
                    thumbnailPath: "",
                    imageFormat: _format,
                    maxHeight: _sizeH,
                    maxWidth: _sizeW,
                    timeMs: _timeMs,
                    quality: _quality,
                  ),
                  key: UniqueKey(),
                );
              });
            },
            child: const Text("Data"),
          ),
          const SizedBox(width: 5.0),
          FloatingActionButton(
            tooltip: "Generate a file of thumbnail",
            onPressed: () async {
              setState(() {
                _futureImage = GenThumbnailImage(
                  thumbnailRequest: ThumbnailRequest(
                    video: _video.text,
                    thumbnailPath: _tempDir,
                    imageFormat: _format,
                    maxHeight: _sizeH,
                    maxWidth: _sizeW,
                    timeMs: _timeMs,
                    quality: _quality,
                  ),
                  key: UniqueKey(),
                );
              });
            },
            child: const Text("File"),
          ),
        ],
      ),
    );
  }
}
