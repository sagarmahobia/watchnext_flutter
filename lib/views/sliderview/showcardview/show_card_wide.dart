import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:watchnext/pages/detail/detail_page.dart';
import 'package:watchnext/res/app_colors.dart';
import 'package:watchnext/utils/utils.dart';
import 'package:watchnext/views/sliderview/showcardview/show_card_input_model.dart';

import '../../../res/app_values.dart';

class ShowCardViewWide extends StatelessWidget {
  final ShowCardInputModel inputModel;

  const ShowCardViewWide({Key? key, required this.inputModel}) : super(key: key);

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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  // child: FadeInImage.memoryNetwork(
                  //   placeholder: kTransparentImage,
                  //   imageErrorBuilder: (context, error, stackTrace) {
                  //     return Container(
                  //       width: 120,
                  //       child: Center(
                  //         child: Icon(
                  //           Icons.broken_image_rounded,
                  //           size: 50,
                  //           color: Colors.white24,
                  //         ),
                  //       ),
                  //     );
                  //   },
                  //   image: this.inputModel.imageUrl,
                  //   fit: BoxFit.cover,
                  // ),
                  child: getImage(
                    inputModel.imageUrl,
                    width: 120,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          inputModel.title,
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star_rate_rounded,
                              size: 16,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0, right: 8),
                              child: Text(
                                inputModel.vote,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Icon(
                              Icons.person_rounded,
                              size: 16,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                inputModel.count.toString(),
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month_rounded,
                              size: 16,
                            ),
                            Container(
                              width: 4,
                            ),
                            Text(
                              inputModel.releaseDate != null
                                  ? DateUtil.getPrettyDate(inputModel.releaseDate)
                                  : "",
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
