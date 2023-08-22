import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MainApp()));
}

enum PlayerState { stopped, playing, paused }

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final playerStateProvider = StateProvider<PlayerState>((ref) {
    return PlayerState.stopped;
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('State Pattern Music Player Riverpod Demo'),
        ),
        body: Center(
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Player State:'),
                  const SizedBox(height: 10),
                  Text(ref.watch(playerStateProvider).toString()),
                  //TO-DO: ADD A LINEAR PROGRESS INDICATOR
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => ref
                            .read(playerStateProvider.notifier)
                            .state = PlayerState.playing,
                        icon: const Icon(Icons.play_arrow),
                        color: Colors.green,
                      ),
                      IconButton(
                        onPressed: () => ref
                            .read(playerStateProvider.notifier)
                            .state = PlayerState.stopped,
                        icon: const Icon(Icons.stop),
                      ),
                      IconButton(
                        onPressed: () => ref
                            .read(playerStateProvider.notifier)
                            .state = PlayerState.paused,
                        icon: const Icon(Icons.pause),
                        color: Colors.orange,
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
