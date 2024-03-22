import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kigenkeisann/components/layout.dart';
import 'package:kigenkeisann/core/japanese_calendar.dart';

import '../utils.dart';

class YearMonthInput extends StatefulWidget {
  final ValueChanged<DateTime?>? onChanged;

  const YearMonthInput({
    super.key,
    this.onChanged,
  });

  @override
  State<YearMonthInput> createState() => YearMonthInputState();
}

class YearMonthInputState extends State<YearMonthInput> {
  final _yearController = TextEditingController();

  int? _month;

  @override
  Widget build(BuildContext context) {
    return GappedRow(
      children: [
        Flexible(
          child: TextFormField(
            controller: _yearController,
            onChanged: (value) {
              widget.onChanged?.call(date);
            },
            textAlign: TextAlign.end,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
                prefixText: JapaneseEra.reiwa.text,
                suffixText: "年",
                labelText: "年",
            ),
          ),
        ),
        Flexible(
          child: DropdownButtonFormField<int>(
            value: _month,
            items: months.map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text("$e月"),
              );
            }).toList(),
            decoration: const InputDecoration(
              labelText: "月",
            ),
            onChanged: (value) {
              setState(() {
                _month = value;
              });
              widget.onChanged?.call(date);
            },
          ),
        ),
        SizedBox(
          width: 32,
          height: 32,
          child: IconButton(
            padding: const EdgeInsets.all(4),
            icon: const Icon(Icons.clear),
            onPressed: () {
              _yearController.clear();
              setState(() {
                _month = null;
              });
              widget.onChanged?.call(null);
            },
          ),
        ),
      ],
    );
  }

  DateTime? get date {
    if (_yearController.text.isEmpty || _month == null) {
      return null;
    }
    final year = int.parse(_yearController.text);
    return DateTime(year + JapaneseEra.reiwa.startYear - 1, _month! + 1, 0);
  }

  void clear() {
    _yearController.clear();
    setState(() {
      _month = null;
    });
  }
}
