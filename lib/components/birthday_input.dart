import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kigenkeisann/components/layout.dart';
import 'package:kigenkeisann/components/year_month_input.dart';

import '../core/japanese_calendar.dart';

class BirthdayInput extends StatelessWidget {
  final JapaneseEra? era;
  final int? month;
  final ValueChanged<JapaneseEra?>? onEraChanged;
  final ValueChanged<String>? onYearChanged;
  final ValueChanged<int?>? onMonthChanged;
  final ValueChanged<String>? onDayChanged;
  final TextEditingController? dayController;

  const BirthdayInput({
    super.key,
    this.era,
    this.month,
    this.onEraChanged,
    this.onYearChanged,
    this.onMonthChanged,
    this.onDayChanged,
    this.dayController,
  });

  @override
  Widget build(BuildContext context) {
    return GappedRow(
      children: [
        Flexible(
          child: DropdownButtonFormField<JapaneseEra>(
            value: era,
            decoration: const InputDecoration(
              labelText: "元号",
              border: OutlineInputBorder(),
            ),
            items: JapaneseEra.values.map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(e.text),
              );
            }).toList(),
            onChanged: onEraChanged,
          ),
        ),
        Flexible(
          child: TextFormField(
            onChanged: onYearChanged,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textAlign: TextAlign.end,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "年",
              suffixText: "年",
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: DropdownButtonFormField<int>(
            value: month,
            decoration: const InputDecoration(
              labelText: "月",
              border: OutlineInputBorder(),
            ),
            alignment: Alignment.centerRight,
            items: months.map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text("$e月"),
              );
            }).toList(),
            onChanged: onMonthChanged,
          ),
        ),
        Flexible(
          child: TextFormField(
            controller: dayController,
            onChanged: onDayChanged,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textAlign: TextAlign.end,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "日",
              suffixText: "日",
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
