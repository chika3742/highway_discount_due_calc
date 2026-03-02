import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kigenkeisann/components/layout.dart';

import '../core/japanese_calendar.dart';
import '../utils.dart';

class BirthdayInput extends StatefulWidget {
  final ValueChanged<DateTime?>? onChanged;

  const BirthdayInput({
    super.key,
    this.onChanged,
  });

  @override
  State<BirthdayInput> createState() => BirthdayInputState();
}

class BirthdayInputState extends State<BirthdayInput> {
  final _yearController = TextEditingController();
  final _dayController = TextEditingController();

  JapaneseEra? _era;
  int? _month;

  @override
  Widget build(BuildContext context) {
    return GappedRow(
      children: [
        Flexible(
          child: DropdownButtonFormField<JapaneseEra>(
            initialValue: _era,
            decoration: const InputDecoration(
              labelText: "元号",
            ),
            items: JapaneseEra.values.map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(e.text),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _era = value;
              });
              normalizeBirthdayDay();
              widget.onChanged?.call(date);
            },
          ),
        ),
        Flexible(
          child: TextFormField(
            controller: _yearController,
            onChanged: (value) {
              normalizeBirthdayDay();
              widget.onChanged?.call(date);
            },
            inputFormatters: [FilteringTextInputFormatter.digitsOnly, yearInputFormatter],
            textAlign: TextAlign.end,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "年",
              suffixText: "年",
            ),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: DropdownButtonFormField<int>(
            initialValue: _month,
            decoration: const InputDecoration(
              labelText: "月",
            ),
            alignment: Alignment.centerRight,
            items: months.map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text("$e月"),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _month = value;
              });
              normalizeBirthdayDay();
              widget.onChanged?.call(date);
            },
          ),
        ),
        Flexible(
          child: TextFormField(
            controller: _dayController,
            onChanged: (value) {
              normalizeBirthdayDay();
              widget.onChanged?.call(date);
            },
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textAlign: TextAlign.end,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "日",
              suffixText: "日",
            ),
          ),
        ),
      ],
    );
  }

  int? get year => int.tryParse(_yearController.text);

  int? get day => int.tryParse(_dayController.text);

  JapaneseCalendarYear? get japaneseCalendarYear {
    if (_era == null || year == null) {
      return null;
    }
    return JapaneseCalendarYear(era: _era!, year: year!);
  }

  DateTime? get date {
    if (japaneseCalendarYear == null || _month == null || day == null) {
      return null;
    }
    return DateTime(japaneseCalendarYear!.adYear, _month!, day!);
  }

  void normalizeBirthdayDay() {
    final validationResult = validateDay(day);
    if (validationResult != null) {
      _dayController.text = validationResult.toString();
    }
  }

  /// if no change, return null
  int? validateDay(int? day) {
    if (day == null) {
      return null;
    }
    if (japaneseCalendarYear != null && _month != null) {
      var dayLengthOfCurrentMonth = DateTime(japaneseCalendarYear!.adYear, _month! + 1, 0).day;
      if (dayLengthOfCurrentMonth < day) {
        return dayLengthOfCurrentMonth;
      }
    }
    if (day > 31) {
      return 31;
    }
    if (day < 1) {
      return 1;
    }
    return null;
  }

  void clear() {
    _yearController.clear();
    _dayController.clear();
    setState(() {
      _era = null;
      _month = null;
    });
  }
}
