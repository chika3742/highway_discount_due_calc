import "package:flutter/material.dart";

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
  });

  final bool? value;
  final ValueChanged<bool?> onChanged;
  final Widget label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value!);
      },
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
          ),
          label,
        ],
      ),
    );
  }
}
