import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kigenkeisann/components/layout.dart';

class YearMonthInput extends StatelessWidget {
  final TextEditingController? jcYearController;
  final ValueChanged<String>? onJcYearChanged;
  final int? month;
  final ValueChanged<int?>? onMonthChanged;
  final VoidCallback? onClear;

  const YearMonthInput({
    super.key,
    this.jcYearController,
    this.onJcYearChanged,
    this.month,
    this.onMonthChanged,
    this.onClear
  });

  @override
  Widget build(BuildContext context) {
    return GappedRow(
      children: [
        Flexible(
          child: TextFormField(
            controller: jcYearController,
            onChanged: onJcYearChanged,
            textAlign: TextAlign.end,
            keyboardType: TextInputType.number,
            inputFormatters: [yearInputFormatter],
            decoration: const InputDecoration(
                prefixText: "令和",
                suffixText: "年",
                labelText: "年",
            ),
          ),
        ),
        Flexible(
          child: DropdownButtonFormField<int>(
            value: month,
            items: months.map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text("$e月"),
              );
            }).toList(),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "月",
            ),
            onChanged: onMonthChanged,
          ),
        ),
        SizedBox(
          width: 32,
          height: 32,
          child: IconButton(
            padding: const EdgeInsets.all(4),
            icon: const Icon(Icons.clear),
            onPressed: onClear,
          ),
        ),
      ],
    );
  }
}

final yearInputFormatter = TextInputFormatter.withFunction((oldValue, newValue) {
  if (newValue.text.isEmpty) {
    return newValue;
  }
  final number = int.tryParse(newValue.text);
  if (number == null) {
    return oldValue;
  }
  if (number < 0) {
    return const TextEditingValue(text: "0");
  }
  return newValue;
});

final months = List.generate(12, (index) => index + 1);
