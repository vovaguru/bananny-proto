import 'package:flutter/material.dart';
import 'package:flutter_jigsaw_puzzle/flutter_jigsaw_puzzle.dart';

class JigsawPazzleScreen extends StatelessWidget {
  const JigsawPazzleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final puzzleKey = GlobalKey<JigsawWidgetState>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Pazzle"),
        actions: [
          IconButton(
            icon: const Icon(Icons.play_arrow),
            tooltip: "Save to Image",
            onPressed: () async {
              await puzzleKey.currentState!.generate();
            },
          ),
          IconButton(
            icon: const Icon(Icons.replay),
            tooltip: "Save to Image",
            onPressed: () {
              puzzleKey.currentState!.reset();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: JigsawPuzzle(
              gridSize: 5,
              image: const AssetImage('assets/images/jigsaw.jpg'),
              onFinished: () {
                print('finished!');
              },
              snapSensitivity: .5, // Between 0 and 1
              puzzleKey: puzzleKey,
              onBlockSuccess: () {
                print('block success!');
              },
            ),
          ),
        ),
      ),
    );
  }
}
