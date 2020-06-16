import 'package:flutter/material.dart';
import 'package:speech_bubble/speech_bubble.dart';

class InfoIconButton extends StatelessWidget {
  final bool visibility;
  final Widget content;
  final VoidCallback onPressed;

  const InfoIconButton({Key key, this.visibility, this.content, this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.info),
          // iconSize: 20,
          padding: EdgeInsets.all(0.0),
          onPressed: onPressed,
        ),
        Visibility(
          visible: visibility,
          child: SpeechBubble(
            nipLocation: NipLocation.TOP_RIGHT,
            nipHeight: 1,
            color: Colors.blueAccent,
            child: content,
          ),
        ),
      ],
    );
  }
}
