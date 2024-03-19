import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kigenkeisann/components/labeled_radio.dart';
import 'package:kigenkeisann/components/layout.dart';
import 'package:kigenkeisann/components/year_month_input.dart';
import 'package:kigenkeisann/core/japanese_calendar.dart';

import 'components/birthday_input.dart';
import 'providers/home_page_notifier.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _birthdayInputKey = GlobalKey<BirthdayInputState>();
  final _physicalExpDateInputKey = GlobalKey<YearMonthInputState>();
  final _rehabilitationExpDateInputKey = GlobalKey<YearMonthInputState>();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homePageNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("有料道路割引 期限計算"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: GappedColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GappedRow(
                    children: [
                      LabeledRadio<ProcedureType>(
                        value: ProcedureType.update,
                        groupValue: state.procedureType,
                        onChanged: (value) {
                          ref.read(homePageNotifierProvider.notifier)
                              .setProcedureType(value!);
                        },
                        label: "更新",
                      ),
                      LabeledRadio<ProcedureType>(
                        value: ProcedureType.newAcquisition,
                        groupValue: state.procedureType,
                        onChanged: (value) {
                          ref.read(homePageNotifierProvider.notifier)
                              .setProcedureType(value!);
                        },
                        label: "新規・変更",
                      ),
                    ],
                  ),

                  Section(
                    children: [
                      const SectionHeading("生年月日"),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: BirthdayInput(
                          key: _birthdayInputKey,
                          onChanged: (date) {
                            ref.read(homePageNotifierProvider.notifier)
                              .setBirthDate(date);
                          },
                        ),
                      ),
                    ],
                  ),

                  Section(
                    children: [
                      const SectionHeading("手帳の期限"),
                      LabeledRadio(
                        value: false,
                        groupValue: state.hasExpirationDate,
                        onChanged: (value) {
                          FocusScope.of(context).unfocus();
                          ref.read(homePageNotifierProvider.notifier)
                              .setHasExpirationDate(value!);
                        },
                        label: "なし",
                      ),
                      LabeledRadio(
                        value: true,
                        groupValue: state.hasExpirationDate,
                        onChanged: (value) {
                          ref.read(homePageNotifierProvider.notifier)
                              .setHasExpirationDate(value!);
                        },
                        label: "あり",
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0),
                        child: Card(
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                child: GappedColumn(
                                  children: [
                                    GappedRow(
                                      gap: 16,
                                      children: [
                                        const Text("身体"),
                                        Flexible(
                                          child: YearMonthInput(
                                            key: _physicalExpDateInputKey,
                                            onChanged: (date) {
                                              ref.read(homePageNotifierProvider.notifier)
                                                  .setPhysicalExpDate(date);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    GappedRow(
                                      gap: 16,
                                      children: [
                                        const Text("療育\n(A1/A2)"),
                                        Flexible(
                                          child: YearMonthInput(
                                            key: _rehabilitationExpDateInputKey,
                                            onChanged: (date) {
                                              ref.read(homePageNotifierProvider.notifier)
                                                  .setRehabilitationExpDate(date);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                bottom: 0,
                                left: 0,
                                child: IgnorePointer(
                                  ignoring: state.hasExpirationDate,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeOut,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: state.hasExpirationDate
                                          ? Colors.transparent
                                          : Colors.black.withOpacity(0.2),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  Section(
                    children: [
                      const SectionHeading("車両登録"),
                      LabeledRadio(
                        value: false,
                        groupValue: state.hasExpirationDate,
                        onChanged: (value) {
                          ref.read(homePageNotifierProvider.notifier)
                              .setHasExpirationDate(value!);
                        },
                        label: "なし",
                      ),
                      LabeledRadio(
                        value: true,
                        groupValue: state.hasExpirationDate,
                        onChanged: (value) {
                          ref.read(homePageNotifierProvider.notifier)
                              .setHasExpirationDate(value!);
                        },
                        label: "あり",
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: SafeArea(
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionHeading("計算結果"),
                      buildResult(state.expirationDate),
                      if (state.isTurns18BeforeExpirationDate)
                        const Text(
                          "期限前に18歳になります",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (state.procedureType == ProcedureType.update
                          && state.isTodayOver2MonthsBeforeBirthday)
                        const Text(
                          "誕生日まで2ヶ月以上あります",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      ref.read(homePageNotifierProvider.notifier).clear();
                      _birthdayInputKey.currentState?.clear();
                      _physicalExpDateInputKey.currentState?.clear();
                      _rehabilitationExpDateInputKey.currentState?.clear();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildResult(DateTime? date) {
    if (date == null) {
      return const Text("---");
    }
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "${date.year}(${date.japaneseCalendarYear})",
            children: const [
              TextSpan(
                text: "年",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const TextSpan(text: " "),
          TextSpan(
            text: date.month.toString(),
            children: const [
              TextSpan(
                text: "月",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const TextSpan(text: " "),
          TextSpan(
            text: date.day.toString(),
            children: const [
              TextSpan(
                text: "日",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ],
      ),
      style: const TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

enum ProcedureType {
  update(birthdaysBeforeExpirationDate: 3),
  newAcquisition(birthdaysBeforeExpirationDate: 2),
  ;

  final int birthdaysBeforeExpirationDate;

  const ProcedureType({
    required this.birthdaysBeforeExpirationDate,
  });
}
