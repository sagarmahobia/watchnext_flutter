import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:watchnext/res/app_colors.dart';

class ImageViewer extends StatefulWidget {
  final List<String> list;
  final int startIndex;

  const ImageViewer(this.list, this.startIndex, {Key? key}) : super(key: key);

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  int? carouselIndex;

  var pageController = PageController();

  @override
  void initState() {
    super.initState();
    carouselIndex = widget.startIndex;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      pageController.jumpToPage(carouselIndex ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: backGroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Stack(
          children: [
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(widget.list[index]),
                  initialScale: PhotoViewComputedScale.contained,
                  // heroAttributes: PhotoViewHeroAttributes(tag: widget.list[index].image),
                );
              },
              itemCount: widget.list.length,
              loadingBuilder: (context, event) => const Center(
                child: SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(),
                ),
              ),
              backgroundDecoration: BoxDecoration(
                color: backGroundColor,
              ),
              pageController: pageController,
              onPageChanged: (index) {
                setState(() {
                  carouselIndex = index;
                });
              },
            ),
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.list.asMap().entries.map(
                  (e) {
                    var val = MediaQuery.of(context).size.width / widget.list.length;
                    if (e.key == carouselIndex) {
                      return InkWell(
                        onTap: () {
                          pageController.jumpToPage(e.key);
                        },
                        child: Container(
                          height: 12,
                          width: val > 12 ? val : 12,
                          color: Colors.pink,
                        ),
                      );
                    }
                    return Expanded(
                      child: InkWell(
                        onTap: () {
                          pageController.jumpToPage(e.key);
                        },
                        child: Container(
                          height: 12,
                          color: Colors.black38,
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
