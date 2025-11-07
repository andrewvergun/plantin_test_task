import 'package:flutter/material.dart';

class CommonFilledButton extends StatefulWidget {
  const CommonFilledButton({
    super.key,
    required this.onPressed,
    this.icon,
    required this.text,
  });

  final VoidCallback onPressed;
  final IconData? icon;
  final String text;

  @override
  State<CommonFilledButton> createState() => _CommonFilledButtonState();
}

class _CommonFilledButtonState extends State<CommonFilledButton> {
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: widget.onPressed,

      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.icon != null
              ? Row(children: [Icon(widget.icon), SizedBox(width: 16)])
              : SizedBox(width: 0),
          Text(widget.text, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
