import 'package:clock/clock.dart';
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
  final Widget label;

  const ExpireMonthInput({
    super.key,
    required this.label,
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
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: DefaultTextStyle.merge(
            style: TextStyle(
              color: widget.value != null ? Theme.of(context).colorScheme.primary : null,
              fontWeight: widget.value != null ? FontWeight.bold : null,
            ),
            child: widget.label,
          ),
        ),
        Expanded(
          child: AnimatedCrossFade(
            crossFadeState: widget.value != null ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
            sizeCurve: Easing.standard,
            firstChild: Align(
              alignment: Alignment.centerLeft,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text("手帳あり"),
                onPressed: () {
                  setState(() {
                    widget.onChanged(const ExpireMonthInputData());
                  });
                },
              ),
            ),
            secondChild: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GappedRow(
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: _yearController,
                        enabled: widget.value?.noExpirationDate != true,
                        onChanged: (value) {
                          widget.onChanged(ExpireMonthInputData(date: date));
                        },
                        textAlign: TextAlign.end,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly, yearInputFormatter],
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
                          widget.onChanged(ExpireMonthInputData(date: date));
                        } : null,
                      ),
                    ),
                    LabeledCheckbox(
                      value: widget.value?.noExpirationDate == true,
                      onChanged: (value) {
                        if (value == true) {
                          widget.onChanged(const ExpireMonthInputData(noExpirationDate: true));
                        } else {
                          widget.onChanged(ExpireMonthInputData(date: date));
                        }
                      },
                      label: const Text("期限なし"),
                    ),
                  ],
                ),
                Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (date?.isBefore(clock.now()) == true)
                      Expanded(
                        child: Text(
                          "過去の日付が入力されています",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.clear),
                      label: const Text("削除"),
                      style: const ButtonStyle(
                        visualDensity: VisualDensity.compact,
                      ),
                      onPressed: () {
                        clear();
                        widget.onChanged(null);
                      },
                    ),
                  ],
                ),
              ],
            ),
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
  const ExpireMonthInputData._();

  const factory ExpireMonthInputData({
    DateTime? date,
    @Default(false) bool noExpirationDate,
  }) = _ExpireMonthInputData;

  bool get isValid => date != null || noExpirationDate;
}
