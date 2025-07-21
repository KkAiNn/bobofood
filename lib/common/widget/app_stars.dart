import 'package:bobofood/common/widget/app_svg.dart';
import 'package:bobofood/constants/index.dart';
import 'package:flutter/material.dart';

class AppStars extends StatefulWidget {
  final int rating;
  final double size;
  final Color? color;
  final Color? filledColor;
  final Color? emptyColor;
  final Function(int) onRatingChanged;
  const AppStars(
      {super.key,
      required this.rating,
      required this.size,
      this.color,
      this.filledColor,
      this.emptyColor,
      required this.onRatingChanged});

  @override
  State<AppStars> createState() => _AppStarsState();
}

class _AppStarsState extends State<AppStars> {
  int rating = 0;
  void _updateRating(Offset localPosition, List<List<double>> starPosition) {
    final double dx = localPosition.dx.clamp(-1, starPosition.last[1]);
    int newRating = starPosition
        .indexWhere((position) => dx >= position[0] && dx <= position[1]);

    if (newRating == -1 && dx > 0) {
      return;
    }

    setState(() {
      rating = newRating + 1;
    });
    widget.onRatingChanged(newRating + 1);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final gap = (constraints.maxWidth - widget.size * 5) / 4;
      final List<List<double>> starPosition = List.generate(
          5,
          (index) => [
                gap * index + widget.size * index,
                gap * index + widget.size * (index + 1)
              ]);
      return GestureDetector(
          onPanDown: (details) =>
              _updateRating(details.localPosition, starPosition),
          onPanUpdate: (details) =>
              _updateRating(details.localPosition, starPosition),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 0; i < 5; i++)
                Container(
                    alignment: Alignment.center,
                    width: 48.w,
                    height: 48.w,
                    child: AppSvg(
                        path: rating > i
                            ? 'assets/icons/Star filled.svg'
                            : 'assets/icons/Star.svg',
                        width: rating > i ? 48.w : 42.w,
                        height: rating > i ? 48.w : 42.w,
                        color:
                            rating > i ? AppColors.colors.icon.yellow : null)),
            ],
          ));
    });
  }
}
