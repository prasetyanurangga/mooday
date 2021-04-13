import 'package:flutter/material.dart';

class SliderMood extends StatefulWidget {
  final double value;
  final String title, firstIcon, lastIcon, id;
  Function onChange;

  SliderMood({
    this.id,
    this.value : 0.0,
    this.title,
    this.firstIcon,
    this.lastIcon,
    this.onChange,
    Key key
  }) : super(key: key);

  @override
  _SliderMoodState createState() => _SliderMoodState();
}

class _SliderMoodState extends State<SliderMood> {
  double _moodValue;

  @override
  void initState() { 
    super.initState();
    _moodValue = widget.value;
  }


  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            textAlign: TextAlign.left,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                widget.firstIcon,
                width: 32,
                height: 32
              ),
              SizedBox(width: 8),
              Expanded(
                child: Slider(
                  value: _moodValue,
                  max: 1.0,
                  min: 0.1,
                  inactiveColor: Theme.of(context).accentColor,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged:(f){
                    widget.onChange(widget.id, f-0.1, f+0.1);
                    setState((){
                      _moodValue = f;
                    });
                  }
                ),
              ),
              SizedBox(width: 8),
              Image.asset(
                widget.lastIcon,
                width: 32,
                height: 32
              ),
            ],
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}