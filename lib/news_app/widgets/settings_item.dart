import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final bool isSwitch;
  final bool? switchValue;
  final ValueChanged<bool>? onSwitchChanged;

  const SettingsItem({
    super.key,
    required this.title,
    this.isSwitch = false,
    this.switchValue,
    this.onSwitchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          isSwitch
              ? Switch(
                  value: switchValue ?? false,
                  onChanged: onSwitchChanged,
                )
              : const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
        ],
      ),
    );
  }
}
