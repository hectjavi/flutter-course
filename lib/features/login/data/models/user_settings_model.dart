import 'dart:ui';

class UserSettingsModel {
  final String displayName;
  final String avatarAsset;
  final String headerColor; // 'blue', 'green', 'purple', 'orange', 'red'

  UserSettingsModel({
    required this.displayName,
    required this.avatarAsset,
    required this.headerColor,
  });

  factory UserSettingsModel.fromJson(Map<String, dynamic> json) {
    return UserSettingsModel(
      displayName: json['displayName'],
      avatarAsset: json['avatarAsset'],
      headerColor: json['headerColor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'avatarAsset': avatarAsset,
      'headerColor': headerColor,
    };
  }

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
      case 'blue':
      default:
        return const Color(0xFF006FFD);
    }
  }

  List<Color> getHeaderGradient() {
    final base = getHeaderColor();
    return [base, Color.fromARGB(255, base.red ~/ 2, base.green ~/ 2, base.blue ~/ 2)];
  }
}
