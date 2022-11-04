import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:watchnext/res/app_colors.dart';

import 'video_card_input_model.dart';

class VideoCardView extends StatelessWidget {
  final VideoCardInputModel inputModel;

  const VideoCardView({
    Key? key,
    required this.inputModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: lightBackGround,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        child: Stack(
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),

                  child: FadeInImage.memoryNetwork(
                    width: 216,
                    height: 120,
                    placeholder: kTransparentImage,
                    image: this.inputModel.image,
                    fit: BoxFit.fitWidth,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 120,
                        child: Center(
                          child: Icon(
                            Icons.broken_image_outlined,
                            size: 50,
                            color: Colors.white24,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  width: 216,
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    inputModel.name,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(),
                  ),
                ), //todo
              ],
            ),
            Positioned(
              top: 16,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xBB000000),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                padding: EdgeInsets.only(
                  left: 8.0,
                  right: 4,
                  top: 6,
                  bottom: 6,
                ),
                child: Text(inputModel.type),
              ),
            )
          ],
        ),
      ),
    );
  }
}
