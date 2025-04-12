# UiAvatar

A simple and customizable Flutter widget to generate beautiful text-based avatars using initials — inspired by avatars in email apps, contact lists, and social platforms. No API needed.

## ✨ Features

- Convert names into two-letter initials (e.g., `Harry Potter` → `HP`)
- Circular or rectangular avatars
- Supports custom background color, text color, font weight, and font family
- Option to use random colors (with or without seed)
- Smart contrast detection for text color
- Lightweight and dependency-free

---

## 📦 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  ui_avatar: ^0.0.1
```

Then run:
```bash
flutter pub get
```

---

## 🔨 Usage

### Basic Example
```dart
import 'package:ui_avatar/ui_avatar.dart';

UiAvatar(
  name: "Harry Potter",
)
```

### With Customizations
```dart
UiAvatar(
  name: "Hermione Granger",
  size: 48.0,
  bgColor: Colors.deepPurple,
  textColor: Colors.white,
  shape: BoxShape.rectangle,
  fontWeight: FontWeight.bold,
  fontFamily: 'RobotoMono',
  isUpperCase: false,
)
```

### Use Random Colors (Optional Seeded)
```dart
UiAvatar(
  name: "Ronald Weasley",
  useRandomColors: true,
  useNameAsSeed: true, // same name = same color
)
```

---

## 📘 Parameters

| Property           | Type           | Default            | Description |
|--------------------|----------------|--------------------|-------------|
| `name`             | `String`       | "Harkirat Singh"  | Full name to extract initials |
| `size`             | `double`       | `64.0`             | Width and height of avatar |
| `bgColor`          | `Color`        | `Colors.grey`      | Background color (ignored if random) |
| `textColor`        | `Color`        | `Colors.black`     | Initials color (ignored if random) |
| `fontWeight`       | `FontWeight`   | `FontWeight.normal`| Font weight for initials |
| `fontFamily`       | `String?`      | `null`             | Font family |
| `shape`            | `BoxShape`     | `BoxShape.circle`  | Shape of avatar |
| `isUpperCase`      | `bool`         | `true`             | Display initials in upper case |
| `useRandomColors`  | `bool`         | `false`            | Enable random background + text colors |
| `useNameAsSeed`    | `bool`         | `true`             | Use name to generate consistent random color |

---

## 🧪 Example Output
```
"Harry James Potter" → HJ
"Luna Lovegood" → LL
"Albus Dumbledore" → AD
"Aang" → AA
"A" → A
```

---

## 📄 License

MIT License. Feel free to use and contribute.

---

## 💡 Inspiration

Inspired by how avatars are shown in apps like Gmail, Notion, and Slack — this package makes it easy to generate visually consistent initials-based avatars in Flutter.

---

## 👨‍💻 Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss what you'd like to change.

1. Fork the repo
2. Create your feature branch (`git checkout -b feature/your-feature-name`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/your-feature-name`)
5. Open a pull request

---

Made with ❤️ in Flutter
