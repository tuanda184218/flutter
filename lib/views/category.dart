import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/data/data.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/widgets/widget.dart';

class Category extends StatefulWidget {
  final String categoryName;
  Category({required this.categoryName});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<WallpaperModel> wallpapers = [];
  getSearchWallPaper(String query) async {
    var response = await http.get(
      Uri.parse(
          "https://api.pexels.com/v1/search?query=$query&per_page=15&page=1"),
      headers: {"Authorization": apiKEY},
    );

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      WallpaperModel wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {});
  }

  @override
  void initState() {
    getSearchWallPaper(widget.categoryName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
          child: Container(
        child: Column(children: <Widget>[
          SizedBox(
            height: 16,
          ),
          wallpaperList(wallpapers: wallpapers, context: context)
        ]),
      )),
    );
  }
}
