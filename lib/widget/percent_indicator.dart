import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PercentIndicatorView extends StatelessWidget {
  double percentWatched = 0;
   PercentIndicatorView({Key? key,required this.percentWatched}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      barRadius: const Radius.circular(8),
      lineHeight: 3,
      percent: percentWatched,
      progressColor: Colors.lightBlue,
      backgroundColor: Colors.white,
    );
  }
}
