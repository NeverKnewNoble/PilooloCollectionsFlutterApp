import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {
  final Function(int) onChange;
  final int currentSlide;
  final int totalSlides; // Add this to get the total number of slides
  const ImageSlider({
    super.key,
    required this.currentSlide,
    required this.onChange,
    required this.totalSlides, // Accept the total number of slides
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 220,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: PageView(
              scrollDirection: Axis.horizontal,
              allowImplicitScrolling: true,
              onPageChanged: onChange,
              physics: const ClampingScrollPhysics(),
              children: [
                Image.asset(
                  "images/slider/1.png",
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "images/slider/1.png",
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "images/slider/2.png",
                  fit: BoxFit.cover,
                )
              ],
            ),
          ),
        ),
        Positioned.fill(
          bottom: 10,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                totalSlides, // Make this dynamic based on the total slides
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300), // Fixed to milliseconds
                  width: currentSlide == index ? 15 : 8,
                  height: 8,
                  margin: const EdgeInsets.only(right: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: currentSlide == index
                        ? const Color(0xFFFF0000)
                        : Colors.transparent,
                    border: Border.all(
                      color: const Color(0xFFFF0000),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
