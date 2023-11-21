import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageView extends StatefulWidget {
  final String imgUrl;

  ImageView({required this.imgUrl});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  var progWidth = 40.0;
  var filePath;
  var progressText = "Wallpaper";

  _download(var type) async {
    Dio dio = Dio();
    try {
      var dir = await getTemporaryDirectory();
      await dio.download(widget.imgUrl, "${dir.path}/wallpix.jpeg",
          onReceiveProgress: (rec, total) {
        var progress;
        if (this.mounted) {
          setState(() {
            progress = (rec / total) * 100;
          });
        }
        if (progress == 100) {
          _setWallpaper(type);
        }
      });
    } catch (_) {}
  }

  Future _setWallpaper(var type) async {
    try {
      var result = await platform.invokeMethod("setWall", "wallpix.jpeg $type");
      print("_setWallpaper: " + result);
      setState(() {
        progressText = "Wallpaper Set Successfully";
      });
    } on PlatformException catch (_) {
      setState(() {
        progressText = "Failed to Set Wallpaper";
      });
    }
  }

  static const platform = const MethodChannel("com.flutter.epic/epic");

  bool showOptions = true;

  _save() async {
    setState(() {
      progWidth = 40.0;
    });
    var status = await Permission.storage.request();
    if (status.isGranted) {
      var response = await Dio().get(widget.imgUrl,
          options: Options(responseType: ResponseType.bytes));

      final result =
          await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));

      return result;
    } else if (status.isDenied) {
      throw ("You need to give storage permission");
    } else if (status.isRestricted) {
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
            tag: widget.imgUrl,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.network(widget.imgUrl, fit: BoxFit.cover),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    var u = await _save();
                    if (u != null) {
                      setState(() {
                        progressText = "Wallpaper saved successfully";
                        showOptions = !showOptions;
                      });
                    }
                  },
                  child: showOptions
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white54, width: 1),
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                colors: [Color(0x36FFFFFF), Color(0x0FFFFFFF)],
                              ),
                            ),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Set Wallpaper",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                Text(
                                  "Image will be saved in gallery",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                _download("home");
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white54, width: 1),
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0x36FFFFFF),
                                      Color(0x0FFFFFFF)
                                    ],
                                  ),
                                ),
                                child: Text(
                                  "HOMESCREEN",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            InkWell(
                              onTap: () {
                                _download("both");
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white54, width: 1),
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0x36FFFFFF),
                                      Color(0x0FFFFFFF)
                                    ],
                                  ),
                                ),
                                child: Text(
                                  "BOTH",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            InkWell(
                              onTap: () {
                                _download("lock");
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white54, width: 1),
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0x36FFFFFF),
                                      Color(0x0FFFFFFF)
                                    ],
                                  ),
                                ),
                                child: Text(
                                  "LOCKSCREEN",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
                Stack(children: [
                  Container(
                    height: 50,
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.1),
                  ),
                  AnimatedContainer(
                    duration: Duration(
                      microseconds: 50,
                    ),
                    height: 50,
                    width: progWidth,
                    color: Colors.cyan,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50,
                    child: Center(
                        child: Text(
                      progressText,
                      style: TextStyle(color: Colors.black),
                    )),
                  ),
                ]),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    // Perform the action on cancel
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
