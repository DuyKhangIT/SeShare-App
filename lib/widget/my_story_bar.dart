import 'package:flutter/cupertino.dart';
import 'package:instagram_app/widget/percent_indicator.dart';

class MyStoryBar extends StatelessWidget {
  List<double> percentWatched = [];
   MyStoryBar({Key? key, required this.percentWatched}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 20, 8, 0),
      child: Row(
        children: [
          Expanded(child: PercentIndicatorView(percentWatched: percentWatched[0])),
          Expanded(child: PercentIndicatorView(percentWatched: percentWatched[1])),
          Expanded(child: PercentIndicatorView(percentWatched: percentWatched[2])),
        ],
      ),
    );
  }
}
