import 'package:bananny/widgets/app_list.dart';
import 'package:flutter/material.dart';

import '../mock_data.dart';
import '../widgets/blur_bg.dart';

// ignore: must_be_immutable
class AppsScreen extends StatefulWidget {
  AppsScreen({Key? key, this.initialTab = 0}) : super(key: key);

  int initialTab;

  @override
  State<AppsScreen> createState() => _AppsScreenState();
}

class _AppsScreenState extends State<AppsScreen> {
  var cardListData = MockData.getAppsCardList;
  var arithmeticListData = MockData.getArithmeticCardList;
  var grammaticListData = MockData.getGrammaticCardList;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.initialTab,
      length: 3,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size(
            double.infinity,
            100.0,
          ),
          child: BlurredBg(
            blurFactor: 8,
            child: AppBar(
              title: const Text("Приложения"),
              backgroundColor: Colors.yellow.withOpacity(0.7),
              bottom: const TabBar(tabs: [
                Tab(text: "Арифметика"),
                Tab(
                  text: "Грамматика",
                ),
                Tab(text: "Развлечения")
              ]),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            AppList(data: arithmeticListData),
            AppList(data: grammaticListData),
            AppList(data: cardListData)
          ],
        ),
      ),
    );
  }
}
