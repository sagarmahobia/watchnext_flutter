import 'package:flutter/material.dart';
import 'package:watchnext/models/list-models.dart';
import 'package:watchnext/pages/picture_list/list_page.dart';
import 'package:watchnext/views/sliderview/showcardview/show_card_input_model.dart';
import 'package:watchnext/views/sliderview/showcardview/show_card_view.dart';

class StaticShowSlider extends StatelessWidget {
  final String title;
  final String type;
  final List<Show>? shows;
  final String? url;

  const StaticShowSlider({
    Key? key,
    required this.type,
    required this.title,
    required this.shows,
    this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: shows != null && (shows?.isNotEmpty ?? false),
      child: Container(
        margin: EdgeInsets.only(top: 24),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: 16.0,
                          right: 8.0,
                        ),
                        child: Text(
                          getType(type),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: url?.isNotEmpty ?? false,
                  child: Container(
                    constraints: BoxConstraints(maxHeight: 35),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListPage(
                                    url: url ?? "",
                                    pictureType: type,
                                    title: title,
                                  )),
                        );
                      },
                      child: Text(
                        "MORE",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 16.0),
              child: Container(
                height: 260,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: (shows ?? [])
                      .map(
                        (e) => ShowCardInputModel(
                          e.id ?? 0,
                          "https://image.tmdb.org/t/p/w185" + (e.posterPath ?? ""),
                          e.name == null ? (e.title ?? "N/A") : e.name ?? "N/A",
                          type,
                          (e.voteAverage ?? 0).toStringAsFixed(1),
                        ),
                      )
                      .map(
                        (e) => Container(
                          width: 135,
                          child: ShowCardView(
                            inputModel: e,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getType(type) {
    if (type == 'movie') {
      return "Movies";
    } else {
      return "Shows";
    }
  }
}
