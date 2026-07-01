import 'dart:ui';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_settings.freezed.dart';

@freezed
class UserSettings with _$UserSettings {
  const UserSettings._();

  const factory UserSettings({
    required String displayName,
    required String avatarAsset,
    required String headerColor,
  }) = _UserSettings;

  Color getHeaderColor() {
    switch (headerColor) {
      case 'green':
        return const Color(0xFF00C853);
      case 'purple':
        return const Color(0xFF7C4DFF);
      case 'orange':
        return const Color(0xFFFF6D00);
      case 'red':
        return const Color(0xFFFF1744);
      default:
        return const Color(0xFF006FFD);
    }
  }

  List<Color> getHeaderGradient() {
    final base = getHeaderColor();

    return [
      base,
      Color.fromARGB(
        255,
        base.red ~/ 2,
        base.green ~/ 2,
        base.blue ~/ 2,
      ),
    ];
  }
}