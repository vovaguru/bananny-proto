import 'dart:ui';

import 'package:bananny/screens/apps.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../mock_data.dart';
import 'package:bananny/widgets/page_wrapper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> imgList = [
    'assets/images/math_cat.jpg',
    'assets/images/grammar_cat.jpg'
  ];

  var data = MockData.getHomeCardList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bananny"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/images/bananny_small_logo.png'),
            const Text(
              "Интересно ребенку - удобно родителям!",
              style: TextStyle(fontSize: 16, fontFamily: "AtypText"),
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
              ),
              items: data.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    // TODO add trigger for change bottom nav state
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AppsScreen(initialTab: int.parse(item['tab']!)),
                        ),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(item['image']!),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                            border: Border.all(color: Colors.yellow, width: 1),
                            color: Colors.amber),
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: bottomText(item['title']!)),
                      ),
                    );
                  },
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget bottomText(String text) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              width: double.maxFinite,
              height: 48,
              color: Colors.yellow.withOpacity(0.7),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Center(
                  child: Text(
                    text,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
