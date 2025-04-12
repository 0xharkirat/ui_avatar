import 'package:flutter/material.dart';
import 'package:ui_avatar/ui_avatar.dart';

class SingleScreen extends StatefulWidget {
  const SingleScreen({
    super.key,
    required this.name,
    required this.isRandom,
  });

  final String name;
  final bool isRandom;


  @override
  State<SingleScreen> createState() => _SingleScreenState();
}

class _SingleScreenState extends State<SingleScreen> {
  final TextEditingController _controller = TextEditingController();

  String text = "";
  double size = 128;
  BoxShape shape = BoxShape.circle;
  bool isUpperCase = true;
  bool useRandomColors = false;
  bool showBorder = false;

  Color bgColor = Colors.grey;
  Color textColor = Colors.black;
  Color borderColor = Colors.white;

  @override
  void initState() {
    super.initState();
    text = widget.name;
    _controller.text = widget.name;
    useRandomColors = widget.isRandom;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void updateShape(BoxShape? value) {
    if (value != null) {
      setState(() {
        shape = value;
      });
    }
  }

  void updateSize(double newSize) {
    setState(() {
      size = newSize;
    });
  }

  Widget buildColorPicker(String label, Color currentColor, ValueChanged<Color> onChanged) {
    final List<Color> colors = [
      Colors.black,
      Colors.white,
      Colors.grey,
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.purple,
      Colors.brown,
      Colors.teal,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Wrap(
          spacing: 8,
          children: colors.map((color) {
            return GestureDetector(
              onTap: () => onChanged(color),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: currentColor == color ? Colors.black : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final avatar = UiAvatar(
      name: text,
      useRandomColors: useRandomColors,
      size: size,
      shape: shape,
      isUpperCase: isUpperCase,
      bgColor: bgColor,
      textColor: textColor,
      border: showBorder
          ? Border.all(color: borderColor, width: 2)
          : null,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ui Avatar Example'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            avatar,

            const SizedBox(height: 24),

            TextField(
              controller: _controller,
              autofocus: true,
              onChanged: (value) => setState(() => text = value),
              decoration: const InputDecoration(
                labelText: 'Enter name',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                const Text('Shape:'),
                const SizedBox(width: 16),
                Expanded(
                  child: Row(
                    children: [
                      Radio<BoxShape>(
                        value: BoxShape.circle,
                        groupValue: shape,
                        onChanged: updateShape,
                      ),
                      const Text('Circle'),
                      const SizedBox(width: 8),
                      Radio<BoxShape>(
                        value: BoxShape.rectangle,
                        groupValue: shape,
                        onChanged: updateShape,
                      ),
                      const Text('Rectangle'),
                    ],
                  ),
                ),
              ],
            ),

            Row(
              children: [
                const Text('Uppercase:'),
                const SizedBox(width: 8),
                Switch.adaptive(
                  value: isUpperCase,
                  onChanged: (val) => setState(() => isUpperCase = val),
                ),
              ],
            ),

            Row(
              children: [
                const Text('Random Colors:'),
                const SizedBox(width: 8),
                Switch.adaptive(
                  value: useRandomColors,
                  onChanged: (val) => setState(() => useRandomColors = val),
                ),
              ],
            ),

            Row(
              children: [
                const Text('Border:'),
                const SizedBox(width: 8),
                Switch.adaptive(
                  value: showBorder,
                  onChanged: (val) => setState(() => showBorder = val),
                ),
              ],
            ),

            const SizedBox(height: 16),
            const Text("Size:"),
            Wrap(
              spacing: 8,
              children: [16.0, 32.0, 64.0, 128.0, 256.0]
                  .map((s) => ChoiceChip(
                        label: Text('${s.toInt()}'),
                        selected: size == s,
                        onSelected: (_) => updateSize(s),
                      ))
                  .toList(),
            ),

            const SizedBox(height: 24),

            if (!useRandomColors)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildColorPicker("Background Color", bgColor, (color) => setState(() => bgColor = color)),
                  const SizedBox(height: 16),
                  buildColorPicker("Text Color", textColor, (color) => setState(() => textColor = color)),
                ],
              ),

            if (showBorder) ...[
              const SizedBox(height: 16),
              buildColorPicker("Border Color", borderColor, (color) => setState(() => borderColor = color)),
            ],
          ],
        ),
      ),
    );
  }
}
