import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AppCarouselSlider<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final double height;
  final double borderRadius;
  final double viewportFraction;
  final double itemSpacing;
  final bool enableInfiniteScroll;
  final bool autoPlay;
  final void Function(int index)? onPageChanged;

  const AppCarouselSlider({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.height = 180,
    this.borderRadius = 12,
    this.viewportFraction = 0.8,
    this.itemSpacing = 8,
    this.enableInfiniteScroll = false,
    this.autoPlay = false,
    this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: items.length,
      itemBuilder: (context, index, realIndex) {
        final item = items[index];
        return Padding(
          padding: EdgeInsets.only(right: itemSpacing),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: itemBuilder(context, item, index),
          ),
        );
      },
      options: CarouselOptions(
        height: height,
        viewportFraction: viewportFraction,
        enlargeCenterPage: false,
        enableInfiniteScroll: enableInfiniteScroll,
        autoPlay: autoPlay,
        padEnds: false,
        onPageChanged: (index, reason) => onPageChanged?.call(index),
      ),
    );
  }
}
