import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exam/models/gallery_model.dart';
import 'package:flutter_exam/ui/gallery/bloc/gallery_cubit.dart';

class ImageDetailsPage extends StatefulWidget {
  final GalleryModel? image;
  const ImageDetailsPage({Key? key, this.image}) : super(key: key);

  @override
  State<ImageDetailsPage> createState() => _ImageDetailsPageState();
}

class _ImageDetailsPageState extends State<ImageDetailsPage> {
  bool _isVisible = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _isVisible = widget.image!.isVisible!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.image!.imagePath!),),
        body:  Column(
          children: [
            Image.asset('assets/images/${widget.image!.imagePath}', fit: BoxFit.cover, width: MediaQuery.of(context).size.width,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Move to Tab ${widget.image!.displayLocation == DisplayLocation.tabA ? 'B' : 'A'}'),
                      Switch(
                        value: false,
                        onChanged: (value){
                          widget.image!.displayLocation = widget.image!.displayLocation == DisplayLocation.tabA ? DisplayLocation.tabB : DisplayLocation.tabA;
                          context.read<GalleryCubit>().updateGallery(widget.image);
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      ),

                    ],
                  ),
                  Row(
                    children: [
                      Text('${_isVisible ? 'Hide from' : 'Show in'} Carousel'),
                      Checkbox(value: widget.image!.isVisible, onChanged: (value){
                        widget.image!.isVisible = value;
                        context.read<GalleryCubit>().updateGallery(widget.image);
                        setState(() {
                          _isVisible = value!;
                        });
                      },),
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
