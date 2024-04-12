// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ThumbnailRequest {
  final String video;
  final String thumbnailPath;
  final ImageFormat imageFormat;
  final int maxHeight;
  final int maxWidth;
  final int timeMs;
  final int quality;

  const ThumbnailRequest({
    required this.video,
    required this.thumbnailPath,
    required this.imageFormat,
    required this.maxHeight,
    required this.maxWidth,
    required this.timeMs,
    required this.quality,
  });
}

class ThumbnailResult {
  final Image image;
  final int dataSize;
  final int height;
  final int width;
  final List<PaletteColor> dominantColors;
  const ThumbnailResult({
    required this.image,
    required this.dataSize,
    required this.height,
    required this.width,
    required this.dominantColors,
  });
}

Future<ThumbnailResult> genThumbnail(ThumbnailRequest r) async {
  Uint8List bytes;
  final Completer<ThumbnailResult> completer = Completer();
  final thumbnailPath = await VideoThumbnail.thumbnailFile(
    video: r.video,
    headers: {
      "USERHEADER1": "user defined header1",
      "USERHEADER2": "user defined header2",
    },
    thumbnailPath: r.thumbnailPath,
    imageFormat: r.imageFormat,
    maxHeight: r.maxHeight,
    maxWidth: r.maxWidth,
    timeMs: r.timeMs,
    quality: r.quality,
  );

  print("thumbnail file is located: $thumbnailPath");

  final file = File(thumbnailPath!);
  bytes = file.readAsBytesSync();

  int _imageDataSize = bytes.length;
  print("image size: $_imageDataSize");

  final _image = Image.memory(bytes);
  _image.image.resolve(const ImageConfiguration()).addListener(
    ImageStreamListener((ImageInfo info, bool _) async {
      final PaletteGenerator paletteGenerator =
          await PaletteGenerator.fromImageProvider(_image.image,
              size: Size(
                  info.image.width.toDouble(), info.image.height.toDouble()));

// sorted the colors based on their population also creaTED a list of the top three dominant colors
      final List<PaletteColor> dominantColors = paletteGenerator.paletteColors
          .toList()
        ..sort((a, b) => b.population.compareTo(a.population));

      List<PaletteColor> topThreeColors = dominantColors.length > 2
          ? dominantColors.sublist(0, 3)
          : dominantColors;

      completer.complete(ThumbnailResult(
        image: _image,
        dataSize: _imageDataSize,
        height: info.image.height,
        width: info.image.width,
        dominantColors: topThreeColors,
      ));
    }),
  );
  return completer.future;
}
