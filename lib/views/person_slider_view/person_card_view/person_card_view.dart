import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:watchnext/pages/person_detail/person_detail.dart';
import 'package:watchnext/res/app_colors.dart';

import 'person_card_input_model.dart';

class PersonCardView extends StatelessWidget {
  final PersonCardInputModel inputModel;

  const PersonCardView({
    Key key,
    this.inputModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: lightBackGround,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PersonDetailPage(id: inputModel.id),
            ),
          ); //todo
        },
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: this.inputModel.image,
                fit: BoxFit.fitWidth,
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  inputModel.name,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
