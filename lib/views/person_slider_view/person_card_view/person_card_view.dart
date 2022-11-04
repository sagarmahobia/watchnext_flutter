import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:watchnext/pages/person_detail/person_detail.dart';
import 'package:watchnext/res/app_colors.dart';

import 'person_card_input_model.dart';

class PersonCardView extends StatelessWidget {
  final PersonCardInputModel inputModel;

  const PersonCardView({
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
              builder: (context) => PersonDetailPage(
                id: inputModel.id,
              ),
            ),
          );
        },
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4.0),

                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 170,
                      child: Center(
                        child: Icon(
                          Icons.broken_image_outlined,
                          size: 50,
                          color: Colors.white24,
                        ),
                      ),
                    );
                  },
                  image: this.inputModel.image,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                constraints: BoxConstraints(
                  minHeight: 54,
                ),
                child: Text(
                  inputModel.name,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
