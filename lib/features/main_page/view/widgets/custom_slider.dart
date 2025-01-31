import 'package:flutter/material.dart';
import 'package:mood_journal/features/main_page/view/widgets/custom_track_shape.dart';

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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
      ),
      padding: EdgeInsets.only(left: 10, right: 8, bottom: 16),
      child: Column(
        children: [
          // Text('Тут должны быть метки'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
                List.generate((widget.divisions / 2 + 1).toInt(), (index) {
              return Container(
                height: 8,
                child: VerticalDivider(
                  color: index <= (widget.value / 2).toInt()
                      ? theme.primaryColor
                      : Color(0xFFE1DDD8),
                  width: 2,
                  thickness: 2,
                ),
              );
            }),
          ),
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
              // trackShape: RoundedRectSliderTrackShape(),
              trackShape: CustomTrackShape(),
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
              Text(widget.minTitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: widget.value < 5
                        ? theme.primaryColor
                        : Color(0xFFBCBCBF),
                  )),
              Text(
                widget.maxTitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color:
                      widget.value > 5 ? theme.primaryColor : Color(0xFFBCBCBF),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
