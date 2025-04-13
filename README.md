# UiAvatar

A simple and customizable Flutter widget to generate beautiful text-based avatars using initials — inspired by avatars in email apps, contact lists, and social platforms. No API needed.

**🌐 Try it online:** [ui-avatar-playground.web.app](https://ui-avatar-playground.web.app)

---

## ✨ Features

- Convert names into two-letter initials (e.g., `Harkirat Singh` → `HS`)
- Circular or rectangular avatars
- Supports custom background color, text color, font weight, and font family
- Border support (color + toggle)
- Option to use random colors (with or without seed)
- Smart contrast detection for text color
- Size control and casing customization
- Lightweight and dependency-free

---

## 📦 Installation

### From pub.dev
```yaml
dependencies:
  ui_avatar: ^0.0.1
```

### Or use the latest from GitHub
```yaml
dependencies:
  ui_avatar:
    git:
      url: https://github.com/0xharkirat/ui_avatar.git
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

UiAvatar()
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

### With Border
```dart
UiAvatar(
  name: "Albus Dumbledore",
  useRandomColors: true,
  border: Border.all(color: Colors.white, width: 2),
)
```

---

## 📘 Parameters

| Property           | Type             | Default                  | Description |
|--------------------|------------------|---------------------------|-------------|
| `name`             | `String`         | `"Harkirat Singh"`       | Full name to extract initials |
| `size`             | `double`         | `64.0`                    | Width and height of avatar |
| `bgColor`          | `Color`          | `Colors.grey`            | Background color (ignored if random) |
| `textColor`        | `Color`          | `Colors.black`           | Initials color (ignored if random) |
| `fontWeight`       | `FontWeight`     | `FontWeight.normal`      | Font weight for initials |
| `fontFamily`       | `String?`        | `null`                   | Font family |
| `shape`            | `BoxShape`       | `BoxShape.circle`        | Shape of avatar |
| `isUpperCase`      | `bool`           | `true`                   | Display initials in upper case |
| `useRandomColors`  | `bool`           | `false`                  | Enable random background + text colors |
| `useNameAsSeed`    | `bool`           | `true`                   | Use name to generate consistent random color |
| `border`           | `BoxBorder?`     | `null`                   | Add a custom border around avatar |
| `boxShadow`        | `List<BoxShadow>?` | `null`                 | Apply shadow to the avatar box |

---

## 🧪 Example Output
```
"Harkirat Singh" → HS
"Albus Percival Wulfric Brian Dumbledore" → AD
"Harkirat" → HA
"A" → A
"" → ??
```

---

## 📄 License

MIT License. Feel free to use and contribute.

---

## 💡 Inspiration

Inspired by how avatars are shown in apps like Gmail, Notion, and Slack — this package makes it easy to generate visually consistent initials-based avatars in Flutter.

or see very famous api https://ui-avatars.com/ (Not made by me tho).

---

## 👨‍💻 Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss what you'd like to change.

**Last contributor with a merged PR will be featured as the default `kDefaultName` in `UiAvatar`!**

Steps:

1. Fork the repo
2. Create your feature branch (`git checkout -b feature/your-feature-name`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/your-feature-name`)
5. Open a pull request

or just skip steps 2–4. just open the pr directly. be cool.
we test in production. we push to production on fridays.
peace out.

---

Fail Fast, Build More & Keep on learning better technologies.

a 0xharkirat production.
