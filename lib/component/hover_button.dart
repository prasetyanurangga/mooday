import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mooday/constant.dart';

class HoverButton extends StatefulWidget {
  HoverButton({
    this.title,
    this.isActive: false,
    Key key,
  }) : super(key: key);

  final String title;
  final bool isActive;

  @override
  _HoverButtonState createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {

  bool isHover;

  @override
  void initState() { 
    super.initState();
    isHover = false;
  }

  Widget _buildContainer() {
    return AnimatedContainer(
      padding: EdgeInsets.all(12.0),
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: widget.isActive ? Colors.white : Theme.of(context).backgroundColor,
        borderRadius: widget.isActive ? BorderRadius.circular(24) : BorderRadius.zero,
        boxShadow: widget.isActive ? boxShadow : []
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) {
          if(!widget.isActive){
            setState(() => isHover = true);
          }
        },
        onExit: (event) {
          if(!widget.isActive){
            setState(() => isHover = false);
          }
        },
        child: Container(
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: (isHover || widget.isActive) ? colorPrimary : colorText,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildContainer();
  }
}