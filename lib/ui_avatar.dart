import 'dart:math';
import 'package:flutter/material.dart';

/// A simple widget to display a circular avatar with initials.
/// No need to use any API for this.
class UiAvatar extends StatelessWidget {
  /// Creates a [UiAvatar] widget
  ///
  /// Examples:
  /// - "Harkirat Singh" -> "HS"
  /// - "Albus Dumbledore" -> "AD"
  /// - "Aang" -> "AA"
  /// - "A" -> "A"
  const UiAvatar({
    super.key,
    this.name = "Harkirat Singh",
    this.size = 64.0,
    this.bgColor = Colors.grey,
    this.textColor = Colors.black,
    this.fontWeight = FontWeight.normal,
    this.shape = BoxShape.circle,
    this.isUpperCase = true,
    this.fontFamily,
    this.useRandomColors = false,
    this.useNameAsSeed = true,
  }) : assert(size >= 16, "Size must be at least 16");

  /// The name to display in the avatar
  ///
  /// defaults to "Harkirat Singh" or "??" if empty
  ///
  final String name;

  /// The size of the avatar box
  ///
  /// defaults to 64.0
  ///
  /// Must be at least 16.0
  ///
  final double size;

  /// The background color of the avatar
  ///
  /// defaults to Colors.grey
  ///
  /// if [useRandomColors] is true, this color will be ignored
  final Color bgColor;

  /// The text color of the avatar
  ///
  /// defaults to Colors.black
  ///
  /// if [useRandomColors] is true, this color will be ignored
  final Color textColor;

  /// The font weight of the text in the avatar
  ///
  /// defaults to FontWeight.normal
  final FontWeight fontWeight;

  /// The shape of the avatar.
  ///
  /// defaults to BoxShape.circle
  ///
  final BoxShape shape;

  /// Whether to display the initials in upper case or not
  ///
  /// defaults to true; case will be preserved if false
  final bool isUpperCase;

  /// Font family of the text in the avatar
  final String? fontFamily;

  /// Whether to use random colors for the avatar or not
  ///
  /// defaults to false
  ///
  /// if true, [bgColor] and [textColor] will be ignored
  /// and random colors will be used for the background
  /// and text
  final bool useRandomColors;

  /// Whether to use the name as seed for the random colors or not
  ///
  /// defaults to true
  /// if true, same name will always generate the same color
  ///
  /// if false, random colors on every build.
  final bool useNameAsSeed;

  @override
  Widget build(BuildContext context) {
    final Color finalBgColor =
        useRandomColors
            ? (useNameAsSeed ? _getSeededColor(name) : _getRandomColor())
            : bgColor;

    final Color finalTextColor =
        useRandomColors ? _getContrastingTextColor(finalBgColor) : textColor;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: finalBgColor, shape: shape),
      child: Center(
        child: Text(
          _getInitials(name),
          semanticsLabel: "UI Avatar for $name",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: finalTextColor,
            fontSize: size / 3,
            fontWeight: fontWeight,
            fontFamily: fontFamily,
          ),
        ),
      ),
    );
  }

  String _getInitials(String name) {
    final trimmed = name.trim();

    if (trimmed.isEmpty) return "??";

    final parts = trimmed.split(RegExp(r'\s+'));

    String initials;
    if (parts.length == 1) {
      final first = parts[0];
      initials = first.substring(0, min(2, first.length));
    } else {
      initials = parts[0][0] + parts.last[0];
    }

    return isUpperCase ? initials.toUpperCase() : initials;
  }

  Color _getRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      100 + random.nextInt(156),
      100 + random.nextInt(156),
      100 + random.nextInt(156),
    );
  }

  Color _getSeededColor(String seedString) {
    final seed = seedString.hashCode;
    final random = Random(seed);
    return Color.fromARGB(
      255,
      100 + random.nextInt(156),
      100 + random.nextInt(156),
      100 + random.nextInt(156),
    );
  }

  Color _getContrastingTextColor(Color bg) {
    final brightness = ThemeData.estimateBrightnessForColor(bg);
    return brightness == Brightness.light ? Colors.black : Colors.white;
  }
}
