import 'package:flutter/material.dart';

class WatchProvidersView extends StatefulWidget {
  final int id;

  const WatchProvidersView(this.id, {Key? key}) : super(key: key);

  @override
  _WatchProvidersViewState createState() => _WatchProvidersViewState(this.id);
}

class _WatchProvidersViewState extends State<WatchProvidersView> {
  int id;

  _WatchProvidersViewState(this.id);

  @override
  Widget build(BuildContext context) {
    return Text("Watch This Show");
  }
}
