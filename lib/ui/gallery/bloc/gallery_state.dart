part of 'gallery_cubit.dart';

abstract class GalleryState {
  List<GalleryModel> galleryImages = [];

  GalleryState();
}

class GalleryInitial extends GalleryState {
  @override
  List<GalleryModel> get galleryImages => [
    GalleryModel(id: 1, imagePath: 'image1.jpeg', isVisible: true, displayLocation: DisplayLocation.tabA),
    GalleryModel(id: 2, imagePath: 'image2.jpeg', isVisible: false, displayLocation: DisplayLocation.tabA),
    GalleryModel(id: 3, imagePath: 'image3.jpeg', isVisible: true, displayLocation: DisplayLocation.tabA),
    GalleryModel(id: 4, imagePath: 'image4.jpeg', isVisible: false, displayLocation: DisplayLocation.tabA),
    GalleryModel(id: 5, imagePath: 'image5.jpeg', isVisible: true, displayLocation: DisplayLocation.tabA),
    GalleryModel(id: 6, imagePath: 'image6.jpeg', isVisible: false, displayLocation: DisplayLocation.tabB),
    GalleryModel(id: 7, imagePath: 'image7.jpeg', isVisible: true, displayLocation: DisplayLocation.tabB),
    GalleryModel(id: 8, imagePath: 'image8.jpeg', isVisible: false, displayLocation: DisplayLocation.tabB),
    GalleryModel(id: 9, imagePath: 'image9.jpeg', isVisible: true, displayLocation: DisplayLocation.tabB),
    GalleryModel(id: 10, imagePath: 'image10.jpeg', isVisible: true, displayLocation: DisplayLocation.tabB),
  ];
}
class GalleryUpdated extends GalleryState {
  final List<GalleryModel> images;

  @override
  List<GalleryModel> get galleryImages => images;

  GalleryUpdated(this.images);
}
