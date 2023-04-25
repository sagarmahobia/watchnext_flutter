import 'package:flutter/material.dart';
// enum Wide or Tall with string values

enum Type {
  wide,
  tall;

  static getImage(Type type) {
    switch (type) {
      case Type.tall:
        return 'assets/logo_tall.png';
      default:
        return 'assets/logo_wide.png';
    }
  }
}

class TmdbAttribution extends StatefulWidget {
  final Type type;

  const TmdbAttribution({Key? key, required this.type}) : super(key: key);

  @override
  State<TmdbAttribution> createState() => _TmdbAttributionState();
}

class _TmdbAttributionState extends State<TmdbAttribution> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Powered by ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Image.asset(
            Type.getImage(widget.type),
            width: 50,
          ),
        ],
      ),
    );
  }
}
