import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselWithIndicator extends StatefulWidget {
  final List<String> imgList;

  const CarouselWithIndicator({super.key, required this.imgList});

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return CarouselWithIndicatorState(imgList: imgList);
  }
}

class CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  List<String> imgList;
  late List<Widget> imageSliders;
  int _current = 0;
  final CarouselController _controller = CarouselController();

  CarouselWithIndicatorState({required this.imgList}) {
    imageSliders = imgList
        // ignore: avoid_unnecessary_containers
        .map((item) => Container(
              child: Container(
                margin: const EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Image.network(
                          item,
                          fit: BoxFit.contain,
                          width: 1000.0,
                          alignment: Alignment.center,
                        ),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 10.0,
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: CarouselSlider(
            items: imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 7),
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 6.0,
                height: 6.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.grey)
                        .withOpacity(_current == entry.key ? 0.6 : 0.2)),
              ),
            );
          }).toList(),
        ),
      ]),
    );
  }
}
