import 'package:animated_flip_widget/animated_flip_widget/flip_controler.dart';
import 'package:animated_flip_widget/animated_flip_widget/flip_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flip Widget',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = FlipController();
  FlipDirection direction = FlipDirection.Vertical;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animated Flip Widget Demo')),
      body: Center(
        child: AnimatedFlipWidget(
          front: const _FrontWidget(),
          back: const _BackWidget(),
          flipDirection: direction,
          controller: controller,
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              if (direction == FlipDirection.Vertical) {
                setState(() {
                  direction = FlipDirection.Horizontal;
                });
              }

              controller.flip();
            },
            tooltip: 'Flip',
            child: const Icon(Icons.flip_rounded),
          ),
          const SizedBox(
            width: 16,
          ),
          RotatedBox(
            quarterTurns: 1,
            child: FloatingActionButton(
              onPressed: () {
                if (direction == FlipDirection.Horizontal) {
                  setState(() {
                    direction = FlipDirection.Vertical;
                  });
                }

                controller.flip();
              },
              tooltip: 'Flip',
              child: const Icon(Icons.flip_rounded),
            ),
          ),
        ],
      ),
    );
  }
}

class _FrontWidget extends StatelessWidget {
  const _FrontWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      color: Colors.grey,
      child: const Center(
        child: Text(
          '?',
          style: TextStyle(fontSize: 32),
        ),
      ),
    );
  }
}

class _BackWidget extends StatelessWidget {
  const _BackWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/dog.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
