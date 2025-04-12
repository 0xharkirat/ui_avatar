import 'package:flutter/material.dart';
import 'package:ui_avatar/ui_avatar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = "Harkirat Singh";
  double size = 64;
  BoxShape shape = BoxShape.circle;
  bool isUpperCase = true;
  bool useRandomColors = true;
  bool useNameAsSeed = true;
  FontWeight fontWeight = FontWeight.normal;
  bool useBorder = false;


  Color bgColor = Colors.grey;
  Color textColor = Colors.black;
  Color borderColor = Colors.white;

  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = name;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ui Avatar Playground'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 700;
          return Padding(
            padding: const EdgeInsets.all(16),
            child:
                isWide
                    ? Row(
                      children: [
                        Expanded(child: _buildControls()),
                        const SizedBox(width: 24),
                        _buildPreview(),
                      ],
                    )
                    : SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildPreview(),
                          const SizedBox(height: 24),
                          _buildControls(),
                        ],
                      ),
                    ),
          );
        },
      ),
    );
  }

  Widget _buildPreview() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        UiAvatar(
          name: name,
          size: size,
          shape: shape,
          isUpperCase: isUpperCase,
          useRandomColors: useRandomColors,
          bgColor: bgColor,
          textColor: textColor,
          useNameAsSeed: useNameAsSeed,
          fontWeight: fontWeight,

          border: useBorder ? Border.all(color: borderColor, width: 2) : null,
        ),
        const SizedBox(height: 16),
        Container(
          width: 360,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SelectableText(
            '''UiAvatar(
  name: '$name',
  size: $size,
  shape: BoxShape.${shape == BoxShape.circle ? "circle" : "rectangle"},
  isUpperCase: $isUpperCase,
  useRandomColors: $useRandomColors,
  useNameAsSeed: $useNameAsSeed,
  bgColor: ${_colorLiteral(bgColor)},
  textColor: ${_colorLiteral(textColor)},
  border: ${useBorder ? 'Border.all(color: ${_colorLiteral(borderColor)}, width: 2)' : 'null'},
)''',
            style: const TextStyle(
              fontFamily: 'monospace',
              color: Colors.white,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildControls() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Name:"),
        TextField(
          decoration: const InputDecoration(labelText: 'Name'),
          onChanged: (val) => setState(() => name = val),
          controller: _nameController,
        ),
        const SizedBox(height: 16),

        const Text("Size:"),
        Wrap(
          spacing: 8,
          children:
              [16.0, 32.0, 64.0, 128.0, 256.0]
                  .map(
                    (s) => ChoiceChip(
                      label: Text('${s.toInt()}'),
                      selected: size == s,
                      onSelected: (_) => setState(() => size = s),
                    ),
                  )
                  .toList(),
        ),

        const SizedBox(height: 16),
        const Text("Shape:"),
        DropdownButton<BoxShape>(
          value: shape,
          items: const [
            DropdownMenuItem(value: BoxShape.circle, child: Text('Circle')),
            DropdownMenuItem(
              value: BoxShape.rectangle,
              child: Text('Rectangle'),
            ),
          ],
          onChanged: (val) => setState(() => shape = val!),
        ),

        const SizedBox(height: 16),
        const Text("Font Weight:"),
        DropdownButton<FontWeight>(
          value: fontWeight,
          items: FontWeight.values
              .map(
                (weight) => DropdownMenuItem(
                  value: weight,
                  child: Text(weight.toString()),
                ),
              )
              .toList(),
          onChanged: (val) => setState(() => fontWeight = val!),
        ),


        SwitchListTile.adaptive(
          value: isUpperCase,
          onChanged: (val) => setState(() => isUpperCase = val),
          title: const Text('Uppercase'),
        ),
        SwitchListTile.adaptive(
          value: useRandomColors,
          onChanged: (val) => setState(() => useRandomColors = val),
          title: const Text('Use Random Colors'),
        ),
        SwitchListTile.adaptive(
          value: useNameAsSeed,
          onChanged: (val) => setState(() => useNameAsSeed = val),
          title: const Text('Use Name As Seed'),
        ),

        SwitchListTile.adaptive(
          value: useBorder,
          onChanged: (val) => setState(() => useBorder = val),
          title: const Text('Show Border'),
        ),

        if (!useRandomColors) ...[
          const SizedBox(height: 16),
          const Text("Background Color:"),
          _buildColorSwatches(
            bgColor,
            (color) => setState(() => bgColor = color),
          ),
          const SizedBox(height: 16),
          const Text("Text Color:"),
          _buildColorSwatches(
            textColor,
            (color) => setState(() => textColor = color),
          ),
        ],

        if (useBorder) ...[
          const SizedBox(height: 16),
          const Text("Border Color:"),
          _buildColorSwatches(
            borderColor,
            (color) => setState(() => borderColor = color),
          ),
        ],
      ],
    );
  }

  Widget _buildColorSwatches(
    Color selected,
    ValueChanged<Color> onColorSelected,
  ) {
    const colors = [
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

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          colors.map((color) {
            return GestureDetector(
              onTap: () => onColorSelected(color),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                        selected == color ? Colors.black : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }

  String _colorLiteral(Color color) {
    if (color == Colors.black) return 'Colors.black';
    if (color == Colors.white) return 'Colors.white';
    if (color == Colors.grey) return 'Colors.grey';
    if (color == Colors.red) return 'Colors.red';
    if (color == Colors.green) return 'Colors.green';
    if (color == Colors.blue) return 'Colors.blue';
    return 'Color(0x${color.value.toRadixString(16).padLeft(8, '0')})';
  }
}
