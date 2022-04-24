import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exam/models/gallery_model.dart';
import 'package:flutter_exam/ui/gallery/bloc/gallery_cubit.dart';
import 'package:flutter_exam/ui/gallery/pages/image_details_page.dart';
import 'package:flutter_exam/ui/login/login_page.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
      ),
      body: BlocBuilder<GalleryCubit, GalleryState>(builder: (context, state){
        List<GalleryModel> carouselImages = state.galleryImages.where((element) => element.isVisible == true).toList();
        return Column(
            children: [
              _imageCarousel(carouselImages),
              _galleryTab(state),
            ],
        );
      }),
    );
  }

  _galleryTab(GalleryState state){
    double appHeight = MediaQuery.of(context).size.height;
    List<GalleryModel> tabAImages = state.galleryImages.where((element) => element.displayLocation == DisplayLocation.tabA).toList();
    List<GalleryModel> tabBImages = state.galleryImages.where((element) => element.displayLocation == DisplayLocation.tabB).toList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: appHeight / 2.5,
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  labelColor: Theme.of(context).primaryColor,
                  tabs: [
                    Tab(text: 'TAB A (${tabAImages.length})',),
                    Tab(text: 'TAB B (${tabBImages.length})',)
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _galleryTabView(tabAImages),
                      _galleryTabView(tabBImages),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        _logoutButton()
      ],
    );
  }

  _galleryTabView(List<GalleryModel> galleryImages){
    return GridView.count(crossAxisCount: 2,
      children: galleryImages.map((image){
        return InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ImageDetailsPage(image: image))),
          child: Card(
            child: Stack(
              children: [
                Image.asset('assets/images/${image.imagePath}', fit: BoxFit.cover, width: MediaQuery.of(context).size.width, height: 300,),
                Positioned(
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${image.imagePath}'),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: PopupMenuButton<GalleryModel>(
                    offset: const Offset(1,8),
                    icon: const Icon(Icons.more_horiz, color: Colors.white,),
                    onSelected: (GalleryModel result) {} ,
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<GalleryModel>>[
                      PopupMenuItem<GalleryModel>(
                        child: Switch(
                          value: false,
                          onChanged: (value){
                            image.displayLocation = image.displayLocation == DisplayLocation.tabA ? DisplayLocation.tabB : DisplayLocation.tabA;
                            context.read<GalleryCubit>().updateGallery(image);
                            Navigator.pop(context);
                          },
                          activeTrackColor: Colors.lightGreenAccent,
                          activeColor: Colors.green,
                        ),
                      ),
                      PopupMenuItem<GalleryModel>(
                        child: Checkbox(value: image.isVisible, onChanged: (value){
                          image.isVisible = value;
                          context.read<GalleryCubit>().updateGallery(image);
                          Navigator.pop(context);
                        },),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),);
  }

  _imageCarousel(List<GalleryModel> galleryImages){
    return SizedBox(
      height: 250,
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider(
        options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            viewportFraction: 1.0,
            aspectRatio: 1),
        items: galleryImages.map((image) {
          return Builder(
            builder: (BuildContext context) {
                return Stack(
                  children: [
                    Image.asset('assets/images/${image.imagePath}', fit: BoxFit.cover, width: MediaQuery.of(context).size.width, height: 250,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(image.imagePath!),
                    ),
                  ],
                );
            },
          );
        }).toList(),
      ),
    );
  }

  _logoutButton() {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: ElevatedButton(onPressed: (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const LoginPage()));
      }, child: const Text('Logout')),
    );
  }

}
