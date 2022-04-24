class GalleryModel {
  int? id;
  String? imagePath;
  bool? isVisible;
  DisplayLocation? displayLocation;

  GalleryModel({this.id, this.imagePath, this.isVisible, this.displayLocation});
}

enum DisplayLocation{
  tabA,
  tabB
}