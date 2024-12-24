import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kigenkeisann/components/bulleted_list_item.dart';
import 'package:kigenkeisann/components/expire_month_input.dart';
import 'package:kigenkeisann/components/labeled_radio.dart';
import 'package:kigenkeisann/components/layout.dart';
import 'package:kigenkeisann/core/japanese_calendar.dart';
import 'package:kigenkeisann/providers/generated_image.dart';

import 'components/birthday_input.dart';
import 'providers/home_page_notifier.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _birthdayInputKey = GlobalKey<BirthdayInputState>();
  final _physicalExpDateInputKey = GlobalKey<ExpireMonthInputState>();
  final _rehabilitationExpDateInputKey = GlobalKey<ExpireMonthInputState>();

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homePageNotifierProvider);
    final generatedImage = ref.watch(generatedImageProvider);

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("有料道路割引 期限計算"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
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
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0),
                          child: GappedColumn(
                            children: [
                              GappedRow(
                                gap: 16,
                                children: [
                                  const Text("身体"),
                                  Flexible(
                                    child: ExpireMonthInput(
                                      key: _physicalExpDateInputKey,
                                      value: state.physicalExpire,
                                      onChanged: (date) {
                                        ref.read(homePageNotifierProvider.notifier)
                                            .setPhysicalExpire(date);
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
                                    child: ExpireMonthInput(
                                      key: _rehabilitationExpDateInputKey,
                                      value: state.rehabilitationExpire,
                                      onChanged: (date) {
                                        ref.read(homePageNotifierProvider.notifier)
                                            .setRehabilitationExpire(date);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Flexible(
                          child: Section(
                            children: [
                              const SectionHeading("手帳"),
                              LabeledRadio(
                                value: false,
                                groupValue: state.isCertType2,
                                onChanged: (value) {
                                  ref.read(homePageNotifierProvider.notifier)
                                      .setIsCertType2(value!);
                                },
                                label: "1種",
                              ),
                              LabeledRadio(
                                value: true,
                                groupValue: state.isCertType2,
                                onChanged: (value) {
                                  ref.read(homePageNotifierProvider.notifier)
                                      .setIsCertType2(value!);
                                },
                                label: "2種",
                              ),
                            ],
                          ),
                        ),

                        Flexible(
                          child: Section(
                            children: [
                              const SectionHeading("車両登録"),
                              LabeledRadio(
                                value: false,
                                groupValue: state.registerVehicle,
                                onChanged: (value) {
                                  ref.read(homePageNotifierProvider.notifier)
                                      .setRegisterVehicle(value!);
                                },
                                label: "なし",
                              ),
                              LabeledRadio(
                                value: true,
                                groupValue: state.registerVehicle,
                                onChanged: (value) {
                                  ref.read(homePageNotifierProvider.notifier)
                                      .setRegisterVehicle(value!);
                                },
                                label: "あり",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    AnimatedCrossFade(
                      crossFadeState: state.registerVehicle
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 300),
                      sizeCurve: Curves.easeOutQuint,
                      firstCurve: Curves.easeInExpo,
                      secondCurve: Curves.easeOutExpo,
                      firstChild: Container(),
                      secondChild: Row(
                        children: [
                          Flexible(
                            child: Section(
                              children: [
                                const SectionHeading("車のリース・ローン"),
                                LabeledRadio(
                                  value: false,
                                  groupValue: state.leaseVehicle,
                                  onChanged: (value) {
                                    ref.read(homePageNotifierProvider.notifier)
                                        .setLeaseVehicle(value!);
                                  },
                                  label: "なし",
                                ),
                                LabeledRadio(
                                  value: true,
                                  groupValue: state.leaseVehicle,
                                  onChanged: (value) {
                                    ref.read(homePageNotifierProvider.notifier)
                                        .setLeaseVehicle(value!);
                                  },
                                  label: "あり",
                                ),
                              ],
                            ),
                          ),

                          Flexible(
                            child: Section(
                              children: [
                                const SectionHeading("ETC"),
                                LabeledRadio(
                                  value: false,
                                  groupValue: state.useEtc,
                                  onChanged: (value) {
                                    ref.read(homePageNotifierProvider.notifier)
                                        .setUseEtc(value!);
                                  },
                                  label: "なし",
                                ),
                                LabeledRadio(
                                  value: true,
                                  groupValue: state.useEtc,
                                  onChanged: (value) {
                                    ref.read(homePageNotifierProvider.notifier)
                                        .setUseEtc(value!);
                                  },
                                  label: "あり",
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),

                    Section(
                      children: [
                        const SectionHeading("申請者"),
                        LabeledRadio(
                          value: false,
                          groupValue: state.isAgent,
                          onChanged: (value) {
                            ref.read(homePageNotifierProvider.notifier)
                                .setIsAgent(value!);
                          },
                          label: "本人",
                        ),
                        LabeledRadio(
                          value: true,
                          groupValue: state.isAgent,
                          onChanged: (value) {
                            ref.read(homePageNotifierProvider.notifier)
                                .setIsAgent(value!);
                          },
                          label: "代理人",
                        ),
                      ],
                    ),

                    Card.outlined(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: DefaultTextStyle(
                          style: Theme.of(context).textTheme.bodyLarge!,
                          child: GappedColumn(
                            children: [
                              const SectionHeading("必要書類"),
                              ..._buildRequiredDocs(state),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SectionHeading("申請書記入欄"),

                    switch (generatedImage) {
                      AsyncError(:final error) => Text("画像生成に失敗しました: $error"),
                      AsyncValue(:final value, :final isLoading) => isLoading ? const SizedBox(
                        height: 550,
                        child: Center(child: CircularProgressIndicator()),
                      ) : Column(
                        children: [
                          const Text("画像をタップして拡大"),
                          GestureDetector(
                            onTap: () {
                              showImageViewer(
                                context,
                                Image.memory(value).image,
                                immersive: false,
                                useSafeArea: true,
                              );
                            },
                            child: Image.memory(value!, height: 550),
                          ),
                        ],
                      )
                    },
                  ],
                ),
              ),
            ),

            Container(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            "今日から誕生日まで2ヶ月以上あります",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.clear),
                        label: const Text("クリア"),
                        onPressed: () {
                          ref.read(homePageNotifierProvider.notifier).clear();
                          _birthdayInputKey.currentState?.clear();
                          _physicalExpDateInputKey.currentState?.clear();
                          _rehabilitationExpDateInputKey.currentState?.clear();
                          _scrollController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOutQuint,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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

  List<Widget> _buildRequiredDocs(HomePageState state) {
    return [
      const BulletedListItem(
        child: Text("障害者手帳（身体・療育）"),
      ),
      if (state.registerVehicle) const BulletedListItem(
        child: Text("車検証"),
      ),
      if (state.isCertType2) const BulletedListItem(
        child: Text("運転免許証"),
      ),
      if (state.registerVehicle && state.leaseVehicle)
        const BulletedListItem(
          child: Text("割賦契約書 または リース契約書"),
        ),
      if (state.registerVehicle && state.useEtc) ...[
        const SizedBox(),
        const Align(
          alignment: Alignment.centerLeft,
          child: SectionHeading("以下は「新規：常に必要」「更新/変更：変更があった場合のみ」"),
        ),
        if (state.isOver18YearsOld == false)
          const BulletedListItem(
            child: Text("ETCカード (親権者名義)"),
          ),
        if (state.isOver18YearsOld != false) // else
          const BulletedListItem(
            child: Text("ETCカード (本人名義)"),
          ),
        const BulletedListItem(
          child: Text("ETCセットアップ証明"),
        ),
      ],
    ];
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
