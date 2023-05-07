import 'dart:io';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class AddVideo extends StatefulWidget {
  @override
  _AddVideoState createState() => _AddVideoState();
}

class _AddVideoState extends State<AddVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CameraAwesomeBuilder.awesome(
        saveConfig: SaveConfig.photoAndVideo(
          photoPathBuilder: () async {
            final Directory extDir = await getTemporaryDirectory();
            final testDir =
                await Directory('${extDir.path}/test').create(recursive: true);
            return '${testDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
          },
          videoPathBuilder: () async {
            final Directory extDir = await getTemporaryDirectory();
            final testDir =
                await Directory('${extDir.path}/test').create(recursive: true);
            return '${testDir.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';
          },
        ),
      ),
    );
  }
}
