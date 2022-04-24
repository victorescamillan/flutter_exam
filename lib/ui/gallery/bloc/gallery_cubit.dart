import 'package:bloc/bloc.dart';
import 'package:flutter_exam/models/gallery_model.dart';

part 'gallery_state.dart';

class GalleryCubit extends Cubit<GalleryState> {
  GalleryCubit() : super(GalleryInitial());

  void updateGallery(value) => emit(GalleryUpdated(_onUpdateState(state, value)) );

  List<GalleryModel> _onUpdateState(GalleryState state, GalleryModel image){
    var imageIndex = state.galleryImages.indexWhere((element) => element.id == image.id);
    state.galleryImages[imageIndex] = image;
    return state.galleryImages;
  }
}
