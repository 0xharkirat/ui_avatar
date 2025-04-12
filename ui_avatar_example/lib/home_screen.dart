import 'package:flutter/material.dart';
import 'package:ui_avatar_example/names.dart';
import 'package:ui_avatar/ui_avatar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isRandom = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ui Avatar Example'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // Add a switch to toggle random colors
          Tooltip(
            message: 'Use random colors',
            child: Switch.adaptive(
              
              activeColor: Theme.of(context).colorScheme.primary,
              inactiveTrackColor: Theme.of(
                context,
              ).colorScheme.primary.withOpacity(0.5),
              value: isRandom,
              onChanged: (value) {
                setState(() {
                  isRandom = value;
                });
              },
            ),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: harryPotterNames.length,
        itemBuilder: (context, index) {
          final name = harryPotterNames[index];
          return ListTile(
            contentPadding: const EdgeInsets.all(8),
            title: Text(name),
            leading: UiAvatar(name: name, useRandomColors: isRandom),
          );
        },
        separatorBuilder:
            (context, index) => const Divider(height: 1, color: Colors.grey),
      ),
    );
  }
}
