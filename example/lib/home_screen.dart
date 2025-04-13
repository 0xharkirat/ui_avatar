import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_avatar/ui_avatar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.onChangeThemeMode});
  final void Function(ThemeMode) onChangeThemeMode;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = kDefaultName;
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
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Ui Avatar Playground'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // Themeode menu
          PopupMenuButton<ThemeMode>(
            icon: const Icon(Icons.color_lens),
            onSelected: (mode) {
              widget.onChangeThemeMode(mode);
            },
            itemBuilder:
                (context) => [
                  const PopupMenuItem(
                    value: ThemeMode.system,
                    child: Text('System'),
                  ),
                  const PopupMenuItem(
                    value: ThemeMode.light,
                    child: Text('Light'),
                  ),
                  const PopupMenuItem(
                    value: ThemeMode.dark,
                    child: Text('Dark'),
                  ),
                ],
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 800;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child:
                isWide
                    ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(child: _buildControls()),
                        ),
                        const SizedBox(width: 32),
                        Expanded(child: _buildPreview()),
                      ],
                    )
                    : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildPreview(),
                          const SizedBox(height: 32),
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
    final code = '''UiAvatar(
  name: '$name',
  size: $size,
  shape: BoxShape.${shape == BoxShape.circle ? "circle" : "rectangle"},
  isUpperCase: $isUpperCase,
  useRandomColors: $useRandomColors,
  useNameAsSeed: $useNameAsSeed,
  bgColor: ${_colorLiteral(bgColor)},
  textColor: ${_colorLiteral(textColor)},
  border: ${useBorder ? 'Border.all(color: ${_colorLiteral(borderColor)}, width: 2)' : 'null'},
)''';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: UiAvatar(
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
        ),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(
                code,
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: code));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Code copied to clipboard!'),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.copy,
                    size: 18,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  label: Text(
                    'Copy Code',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Name:"),
          TextField(
            autocorrect: false,
            enableSuggestions: false,
            autofocus: true,
            onChanged: (val) => setState(() => name = val),
            controller: _nameController,
          ),
          const SizedBox(height: 24),

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

          const SizedBox(height: 24),
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

          const SizedBox(height: 24),
          const Text("Font Weight:"),
          DropdownButton<FontWeight>(
            value: fontWeight,
            items:
                FontWeight.values
                    .map(
                      (weight) => DropdownMenuItem(
                        value: weight,
                        child: Text(
                          weight.toString().replaceAll("FontWeight.", ""),
                        ),
                      ),
                    )
                    .toList(),
            onChanged: (val) => setState(() => fontWeight = val!),
          ),

          const SizedBox(height: 24),
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
            const SizedBox(height: 24),
            const Text("Background Color:"),
            _buildColorSwatches(
              bgColor,
              (color) => setState(() => bgColor = color),
            ),
            const SizedBox(height: 24),
            const Text("Text Color:"),
            _buildColorSwatches(
              textColor,
              (color) => setState(() => textColor = color),
            ),
          ],

          if (useBorder) ...[
            const SizedBox(height: 24),
            const Text("Border Color:"),
            _buildColorSwatches(
              borderColor,
              (color) => setState(() => borderColor = color),
            ),
          ],
        ],
      ),
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
                        selected == color
                            ? Theme.of(context).colorScheme.onSurface
                            : Colors.transparent,
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
