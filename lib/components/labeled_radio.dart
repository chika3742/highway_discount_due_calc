import 'package:flutter/material.dart';

class LabeledRadio<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;
  final String label;

  const LabeledRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(value);
      },
      child: Row(
        children: [
          Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
  });

  final bool? value;
  final ValueChanged<bool?> onChanged;
  final String label;

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
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

