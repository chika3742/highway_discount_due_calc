import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kigenkeisann/components/labeled_radio.dart';
import 'package:kigenkeisann/components/layout.dart';
import 'package:kigenkeisann/core/japanese_calendar.dart';

import '../utils.dart';

part "expire_month_input.freezed.dart";

class ExpireMonthInput extends StatefulHookWidget {
  final ExpireMonthInputData? value;
  final ValueChanged<ExpireMonthInputData?> onChanged;

  const ExpireMonthInput({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<ExpireMonthInput> createState() => ExpireMonthInputState();
}

class ExpireMonthInputState extends State<ExpireMonthInput> {
  final _yearController = TextEditingController();

  int? _month;

  @override
  Widget build(BuildContext context) {
    return GappedRow(
      children: [
        Flexible(
          child: TextFormField(
            controller: _yearController,
            enabled: widget.value?.noExpirationDate != true,
            onChanged: (value) {
              widget.onChanged(date != null ? ExpireMonthInputData(date: date) : null);
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
            decoration: InputDecoration(
              labelText: "月",
              enabled: widget.value?.noExpirationDate != true,
            ),
            onChanged: widget.value?.noExpirationDate != true ? (value) {
              setState(() {
                _month = value;
              });
              widget.onChanged(date != null ? ExpireMonthInputData(date: date) : null);
            } : null,
          ),
        ),
        LabeledCheckbox(
          value: widget.value?.noExpirationDate == true,
          onChanged: (value) {
            if (value == true) {
              widget.onChanged(const ExpireMonthInputData(noExpirationDate: true));
            } else {
              widget.onChanged(date != null ? ExpireMonthInputData(date: date) : null);
            }
          },
          label: "期限なし",
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
              widget.onChanged(null);
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

@freezed
class ExpireMonthInputData with _$ExpireMonthInputData {
  const factory ExpireMonthInputData({
    DateTime? date,
    @Default(false) bool noExpirationDate,
  }) = _ExpireMonthInputData;
}
