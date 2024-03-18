import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kigenkeisann/components/layout.dart';

class YearMonthInput extends StatefulWidget {
  final ValueChanged<DateTime?> onChanged;

  const YearMonthInput({
    super.key,
    required this.onChanged,
  });

  @override
  State<YearMonthInput> createState() => _YearMonthInputState();
}

class _YearMonthInputState extends State<YearMonthInput> {
  final _controller = TextEditingController();
  int? _month;

  DateTime? get date {
    if (_controller.text.isEmpty || _month == null) {
      return null;
    }
    final jcYear = int.tryParse(_controller.text);
    if (jcYear == null) {
      return null;
    }
    // 令和元年は2019年
    return DateTime(jcYear + 2018, _month! + 1)
        .subtract(const Duration(days: 1)); // 月末日にする
  }

  @override
  Widget build(BuildContext context) {
    return GappedRow(
      children: [
        Flexible(
          child: TextFormField(
            controller: _controller,
            onChanged: (_) {
              widget.onChanged(date);
            },
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
            value: _month,
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
            onChanged: (value) {
              setState(() {
                _month = value;
              });
              widget.onChanged(date);
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
              _controller.clear();
              _month = null;
              widget.onChanged(null);
            },
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
