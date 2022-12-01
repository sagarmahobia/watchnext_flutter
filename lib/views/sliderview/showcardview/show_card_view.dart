import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchnext/pages/detail/detail_page.dart';
import 'package:watchnext/res/app_colors.dart';
import 'package:watchnext/views/sliderview/showcardview/show_card_input_model.dart';
import 'package:transparent_image/transparent_image.dart';

class ShowCardView extends StatelessWidget {
  final ShowCardInputModel inputModel;

  const ShowCardView({
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
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(
                id: inputModel.id,
                pictureType: inputModel.type,

              ),
            ),
          );
        },
        child: Container(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 180,
                          child: Center(
                            child: Icon(
                              Icons.broken_image_rounded,
                              size: 50,
                              color: Colors.white24,
                            ),
                          ),
                        );
                      },
                      image: this.inputModel.imageUrl,
                      fit: BoxFit.fitWidth,
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      constraints: BoxConstraints(
                        minHeight: 56,
                      ),
                      child: Text(
                        inputModel.title,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
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
                  child: Text(inputModel.vote),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
