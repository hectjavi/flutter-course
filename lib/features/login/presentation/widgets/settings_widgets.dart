import 'package:flutter/material.dart';

class AvatarSelector extends StatelessWidget {
  final List<Map<String, String>> avatars;
  final String selectedAvatar;
  final Function(String) onSelect;
  final bool isLoading;

  const AvatarSelector({
    super.key,
    required this.avatars,
    required this.selectedAvatar,
    required this.onSelect,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Selecciona tu Avatar',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: avatars.map((avatar) {
            final isSelected = selectedAvatar == avatar['asset'];
            return InkWell(
              onTap: isLoading ? null : () => onSelect(avatar['asset']!),
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? const Color(0xFF006FFD) : Colors.transparent,
                    width: 4,
                  ),
                  boxShadow: [
                    if (isSelected)
                      BoxShadow(
                        color: const Color(0xFF006FFD).withOpacity(0.3),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                  ],
                ),
                child: ClipOval(
                  child: Container(
                    color: Colors.grey.shade200,
                    child: Center(
                      child: Text(
                        avatar['name']![0],
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Cuando tengas imágenes reales:
                    // child: Image.asset(
                    //   avatar['asset']!,
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class ColorSelector extends StatelessWidget {
  final List<Map<String, dynamic>> colors;
  final String selectedColor;
  final Function(String) onSelect;
  final bool isLoading;

  const ColorSelector({
    super.key,
    required this.colors,
    required this.selectedColor,
    required this.onSelect,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Color del Tema',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        ...colors.map((color) {
          final isSelected = selectedColor == color['id'];
          return InkWell(
            onTap: isLoading ? null : () => onSelect(color['id']),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected ? (color['color'] as Color).withOpacity(0.1) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? color['color'] as Color : Colors.grey.shade200,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color['color'] as Color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      color['name'],
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ),
                  if (isSelected)
                    Icon(Icons.check_circle, color: color['color'] as Color),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

class SettingsSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const SettingsSection({
    super.key,
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF006FFD), size: 24),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Divider(height: 32),
          ...children,
        ],
      ),
    );
  }
}