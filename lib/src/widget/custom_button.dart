import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const CustomButton({Key key, this.onPressed, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      child: Material(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 6.0,
        child: MaterialButton(
          child: child,
          textColor: Colors.white,
          minWidth: 100.0,
          height:35.0,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
