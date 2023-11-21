class WallpaperModel {
  String photographer;
  String photographer_url;
  int photographer_id;

  SrcModel src;

  WallpaperModel(
      {required this.src,
      required this.photographer,
      required this.photographer_id,
      required this.photographer_url});

  factory WallpaperModel.fromMap(Map<String, dynamic> jsonData) {
    return WallpaperModel(
      src: SrcModel.fromMap(jsonData["src"]),
      photographer: jsonData["photographer"],
      photographer_id: jsonData["photographer_id"],
      photographer_url: jsonData["photographer_url"],
    );
  }
}

class SrcModel {
  String original;
  String small;
  String portrait;

  SrcModel(
      {required this.original, required this.small, required this.portrait});

  factory SrcModel.fromMap(Map<String, dynamic> jsonData) {
    return SrcModel(
      original: jsonData["original"],
      small: jsonData["small"],
      portrait: jsonData["portrait"],
    );
  }
}
