import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kigenkeisann/components/bulleted_list_item.dart';
import 'package:kigenkeisann/components/expire_month_input.dart';
import 'package:kigenkeisann/components/layout.dart';
import 'package:kigenkeisann/core/expiration_date_calculator.dart';
import 'package:kigenkeisann/core/japanese_calendar.dart';
import 'package:kigenkeisann/providers/generated_image.dart';

import 'components/birthday_input.dart';
import 'core/procedure_type.dart';
import 'providers/home_page_notifier.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  static const _segmentedButtonWidth = 200.0;

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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  const SliverAppBar(
                    title: Text("障害者割引 期限計算"),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(16.0),
                    sliver: SliverSafeArea(
                      top: false,
                      bottom: false,
                      sliver: SliverToBoxAdapter(
                        child: GappedColumn(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SectionHeading("手続きの種類"),
                            SegmentedButton<ProcedureType>(
                              selected: {state.procedureType},
                              onSelectionChanged: (value) {
                                ref.read(homePageNotifierProvider.notifier)
                                    .setProcedureType(value.first);
                              },
                              segments: [
                                ButtonSegment(
                                  icon: Icon(Icons.add),
                                  value: ProcedureType.newAcquisition,
                                  label: Text("新規"),
                                ),
                                ButtonSegment(
                                  icon: Icon(Icons.update),
                                  value: ProcedureType.update,
                                  label: Text("更新"),
                                ),
                                ButtonSegment(
                                  icon: Icon(Icons.edit),
                                  value: ProcedureType.change,
                                  label: Text("変更"),
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
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    children: [
                                      ExpireMonthInput(
                                        key: _physicalExpDateInputKey,
                                        value: state.physicalExpire,
                                        onChanged: (date) {
                                          ref.read(homePageNotifierProvider.notifier)
                                              .setPhysicalExpire(date);
                                        },
                                        label: const Text("身体"),
                                      ),
                                      ExpireMonthInput(
                                        key: _rehabilitationExpDateInputKey,
                                        value: state.rehabilitationExpire,
                                        onChanged: (date) {
                                          ref.read(homePageNotifierProvider.notifier)
                                              .setRehabilitationExpire(date);
                                        },
                                        label: const Text("療育\n(A1/A2)"),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Section(
                                  children: [
                                    const SectionHeading("手帳"),
                                    SizedBox(
                                      width: _segmentedButtonWidth,
                                      child: SegmentedButton<bool>(
                                        selected: {state.isCertType2},
                                        onSelectionChanged: (value) {
                                          ref.read(homePageNotifierProvider.notifier)
                                              .setIsCertType2(value.first);
                                        },
                                        segments: [
                                          ButtonSegment(
                                            label: Text("1種"),
                                            value: false,
                                          ),
                                          ButtonSegment(
                                            label: Text("2種"),
                                            value: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),

                                Section(
                                  children: [
                                    const SectionHeading("車両登録"),
                                    SizedBox(
                                      width: _segmentedButtonWidth,
                                      child: SegmentedButton<bool>(
                                        selected: {state.registerVehicle},
                                        onSelectionChanged: (value) {
                                          ref.read(homePageNotifierProvider.notifier)
                                              .setRegisterVehicle(value.first);
                                        },
                                        segments: [
                                          ButtonSegment(
                                            label: Text("なし"),
                                            value: false,
                                          ),
                                          ButtonSegment(
                                            label: Text("あり"),
                                            value: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),

                                AnimatedCrossFade(
                                  crossFadeState: state.registerVehicle
                                      ? CrossFadeState.showSecond
                                      : CrossFadeState.showFirst,
                                  duration: const Duration(milliseconds: 300),
                                  sizeCurve: Curves.easeOutQuint,
                                  firstCurve: Curves.easeInExpo,
                                  secondCurve: Curves.easeOutExpo,
                                  firstChild: Container(),
                                  secondChild: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Section(
                                        children: [
                                          const SectionHeading("車のリース・ローン"),
                                          SizedBox(
                                            width: _segmentedButtonWidth,
                                            child: SegmentedButton<bool>(
                                              selected: {state.leaseVehicle},
                                              onSelectionChanged: (value) {
                                                ref.read(homePageNotifierProvider.notifier)
                                                    .setLeaseVehicle(value.first);
                                              },
                                              segments: [
                                                ButtonSegment(
                                                  label: Text("なし"),
                                                  value: false,
                                                ),
                                                ButtonSegment(
                                                  label: Text("あり"),
                                                  value: true,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),

                                      Section(
                                        children: [
                                          const SectionHeading("ETC"),
                                          SizedBox(
                                            width: _segmentedButtonWidth,
                                            child: SegmentedButton<bool>(
                                              selected: {state.useEtc},
                                              onSelectionChanged: (value) {
                                                ref.read(homePageNotifierProvider.notifier)
                                                    .setUseEtc(value.first);
                                              },
                                              segments: [
                                                ButtonSegment(
                                                  label: Text("なし"),
                                                  value: false,
                                                ),
                                                ButtonSegment(
                                                  label: Text("あり"),
                                                  value: true,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                    ],
                                  ),
                                ),

                                Section(
                                  children: [
                                    SectionHeading("申請者"),
                                    SizedBox(
                                      width: _segmentedButtonWidth,
                                      child: SegmentedButton<bool>(
                                        selected: {state.isAgent},
                                        onSelectionChanged: (value) {
                                          ref.read(homePageNotifierProvider.notifier)
                                              .setIsAgent(value.first);
                                        },
                                        segments: [
                                          ButtonSegment(
                                            label: Text("本人"),
                                            value: false,
                                          ),
                                          ButtonSegment(
                                            label: Text("代理人"),
                                            value: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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

                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Column(
                                spacing: 8,
                                children: [
                                  Row(
                                    spacing: 8,
                                    children: [
                                      CustomPaint(
                                        size: const Size(20, 20),
                                        painter: _LegendCirclePainter(color: Colors.red),
                                      ),
                                      Text("申請者による記入"),
                                    ],
                                  ),
                                  Row(
                                    spacing: 8,
                                    children: [
                                      CustomPaint(
                                        size: const Size(20, 20),
                                        painter: _LegendCirclePainter(color: Colors.blue),
                                      ),
                                      Text("担当者による記入"),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            switch (generatedImage) {
                              AsyncError(:final error) => Text("画像生成に失敗しました: $error"),
                              AsyncValue(:final value, :final isLoading) => isLoading ? const SizedBox(
                                height: 550,
                                child: Center(child: CircularProgressIndicator()),
                              ) : SizedBox(
                                width: double.infinity,
                                child: Column(
                                  spacing: 8,
                                  children: [
                                    const Text("画像をタップして拡大"),
                                    GestureDetector(
                                      onTap: () {
                                        showImageViewer(
                                          context,
                                          MemoryImage(value),
                                          immersive: false,
                                          useSafeArea: true,
                                          doubleTapZoomable: true,
                                        );
                                      },
                                      child: Image.memory(value!),
                                    ),
                                  ],
                                ),
                              )
                            },
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: SafeArea(
                top: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionHeading("計算結果"),
                        buildResult(state.expirationDate),
                        if (state.becomesAdultBeforeExpirationDate)
                          Text(
                            "期限前に$adultAge歳になります",
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
        if (state.procedureType != ProcedureType.newAcquisition) ...[
          const SizedBox(),
          Align(
            alignment: Alignment.centerLeft,
            child: SectionHeading("以下は変更があった場合のみ必要", bold: true),
          ),
        ],
        if (state.isAdult == false)
          const BulletedListItem(
            child: Text("ETCカード (本人名義または親権者名義)"),
          ),
        if (state.isAdult != false) // else
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

class _LegendCirclePainter extends CustomPainter {
  const _LegendCirclePainter({required this.color});

  final Color color;

  static const outlineWidth = 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = outlineWidth
      ..style = PaintingStyle.stroke;

    final radius = size.width / 2 - outlineWidth;
    final center = Offset(radius + outlineWidth, radius + outlineWidth);
    canvas.drawCircle(
      center, radius + outlineWidth / 2, paint,
    );

    paint
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
