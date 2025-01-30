import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  final double value;
  final double min;
  final double max;
  final int divisions;
  final String minTitle;
  final String maxTitle;
  final ValueChanged<double> onChanged;

  CustomSlider({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.minTitle,
    required this.maxTitle,
    required this.onChanged,
  });

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text('Тут должны быть метки'),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: theme.primaryColor,
            activeTickMarkColor: theme.primaryColor,
            inactiveTrackColor: theme.primaryColor.withAlpha(10),
            inactiveTickMarkColor: theme.primaryColor.withAlpha(10),
            trackHeight: 10,
            thumbColor: theme.primaryColor,
            overlayColor: theme.primaryColor.withAlpha(100),
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
            tickMarkShape: RoundSliderTickMarkShape(),
            valueIndicatorShape: PaddleSliderValueIndicatorShape(),
            valueIndicatorColor: theme.primaryColor,
            valueIndicatorTextStyle: TextStyle(color: Colors.white),
            trackShape: RoundedRectSliderTrackShape(),
          ),
          child: Slider(
            value: widget.value,
            min: widget.min,
            max: widget.max,
            divisions: widget.divisions,
            label: widget.value.toString(),
            onChanged: widget.onChanged,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.minTitle, style: TextStyle(fontSize: 16)),
            Text(widget.maxTitle, style: TextStyle(fontSize: 16)),
          ],
        ),
      ],
    );
  }
}
