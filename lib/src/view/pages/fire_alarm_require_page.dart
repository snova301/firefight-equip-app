// import 'package:elec_facility_calc/ads_options.dart';
import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/notifiers/fire_alarm_require_notifier.dart';
import 'package:firefight_equip/src/view/widgets/checkbox_card_widget.dart';
import 'package:firefight_equip/src/view/widgets/dropdown_button_widget.dart';
import 'package:firefight_equip/src/view/widgets/dropdown_fire_prevent_property_widget.dart';
import 'package:firefight_equip/src/view/widgets/input_text_card_widget.dart';
import 'package:firefight_equip/src/view/widgets/output_text_widget.dart';
import 'package:firefight_equip/src/view/widgets/responsive_widget.dart';
import 'package:firefight_equip/src/view/widgets/run_button_widget.dart';
import 'package:firefight_equip/src/view/widgets/separate_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 消火器具設置義務計算ページ
class FireAlarmRequirePage extends ConsumerStatefulWidget {
  const FireAlarmRequirePage({Key? key}) : super(key: key);

  @override
  FireAlarmRequirePageState createState() => FireAlarmRequirePageState();
}

class FireAlarmRequirePageState extends ConsumerState<FireAlarmRequirePage> {
  @override
  Widget build(BuildContext context) {
    /// 画面情報取得
    final mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;
    final listViewPadding = screenWidth / 20;

    /// レスポンシブ設定
    bool isDrawerFixed = checkResponsive(screenWidth);

    /// 広告の初期化
    // AdsSettingsClass().initElecPowerRec();

    /// shared_prefのデータ保存用非同期providerの読み込み
    // ref.watch(elecPowerSPSetProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(PageNameEnum.fireAlarmRequire.title),
        ),
        body: Row(
          children: [
            /// 画面幅が規定以上でメニューを左側に固定
            isDrawerFixed ? const DrawerContentsFixed() : Container(),

            /// サイズ指定されていないとエラーなのでExpandedで囲む
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(
                    listViewPadding, 10, listViewPadding, 10),
                children: <Widget>[
                  /// 入力表示
                  const SeparateText(title: '計算条件'),

                  /// 防火対象物の選択
                  FirePreventPropertySelectDD(
                    value: ref
                        .watch(fireAlarmRequireProvider)
                        .firePreventProperty
                        .title,
                    func: (FirePreventPropertyEnum value) {
                      ref
                          .read(fireAlarmRequireProvider.notifier)
                          .updateFirePreventProperty(value);
                    },
                  ),

                  /// 延べ面積入力
                  InputTextCard(
                    title: '延べ面積(整数のみ)',
                    unit: 'm2',
                    message: '整数のみ',
                    controller: ref.watch(fireAlarmReqSqTxtCtrlProvider),
                    func: (String value) {
                      ref
                          .read(fireAlarmRequireProvider.notifier)
                          .updateSq(value);
                    },
                  ),

                  /// 床面積入力
                  /// 条件に一致すると表示される
                  ref.watch(fireAlarmRequireProvider).firePreventProperty ==
                              FirePreventPropertyEnum.no16No3 ||
                          ref.watch(fireAlarmRequireProvider).isNoWindow ||
                          ref.watch(fireAlarmRequireProvider).floor ==
                              FireAlarmFloorEnum.basement.title ||
                          ref.watch(fireAlarmRequireProvider).floor ==
                              FireAlarmFloorEnum.floor3to10.title ||
                          ref.watch(fireAlarmRequireProvider).usedType ==
                              FireAlarmUsedTypeEnum.parking.title ||
                          ref.watch(fireAlarmRequireProvider).usedType ==
                              FireAlarmUsedTypeEnum.commRoom.title
                      ? InputTextCard(
                          title: '床面積(整数のみ)',
                          unit: 'm2',
                          message: '整数のみ',
                          controller:
                              ref.watch(fireAlarmReqSqFloorTxtCtrlProvider),
                          func: (String value) {
                            ref
                                .read(fireAlarmRequireProvider.notifier)
                                .updateSqFloor(value);
                          },
                        )
                      : Container(),

                  /// 無窓階のチェックボックス
                  CheckBoxCard(
                    title: '無窓階',
                    isChecked: ref.watch(fireAlarmRequireProvider).isNoWindow,
                    func: (bool newBool) {
                      ref
                          .read(fireAlarmRequireProvider.notifier)
                          .updateIsNoWindow(newBool);
                    },
                  ),

                  /// 指定可燃物のチェックボックス
                  CheckBoxCard(
                    title: '指定可燃物を500倍以上貯蔵',
                    isChecked: ref.watch(fireAlarmRequireProvider).isCombust,
                    func: (bool newBool) {
                      ref
                          .read(fireAlarmRequireProvider.notifier)
                          .updateIsCombust(newBool);
                    },
                  ),

                  /// 宿泊施設
                  /// 6項イ、6項ハ、16項の2の判断に使用
                  CheckBoxCard(
                    title: '利用者を入居または宿泊させる',
                    isChecked: ref.watch(fireAlarmRequireProvider).isLodge,
                    func: (bool newBool) {
                      ref
                          .read(fireAlarmRequireProvider.notifier)
                          .updateIsLodge(newBool);
                    },
                  ),

                  /// 閉鎖型スプリンクラー設備、水噴霧消火設備又は泡消火設備
                  CheckBoxCard(
                    title: '閉鎖型スプリンクラー設備、水噴霧消火設備又は泡消火設備が設置',
                    isChecked: ref.watch(fireAlarmRequireProvider).isSprinkler,
                    func: (bool newBool) {
                      ref
                          .read(fireAlarmRequireProvider.notifier)
                          .updateIsSprinkler(newBool);
                    },
                  ),

                  /// 特定1階段等防火対象物
                  CheckBoxCard(
                    title: '特定1階段等防火対象物',
                    isChecked: ref.watch(fireAlarmRequireProvider).isOneStairs,
                    func: (bool newBool) {
                      /// 防火対象物に特定防火対象物を選択した場合のみ選択可能
                      ref
                          .read(fireAlarmRequireProvider.notifier)
                          .updateIsOneStairs(newBool);
                    },
                  ),

                  /// 階の選択
                  const Text('階の選択'),
                  DDButton(
                    value: ref.watch(fireAlarmRequireProvider).floor,
                    list:
                        FireAlarmFloorEnum.values.map((e) => e.title).toList(),
                    func: ((newVal) {
                      ref
                          .read(fireAlarmRequireProvider.notifier)
                          .updateFloor(newVal);
                    }),
                  ),

                  /// その階の用途の選択
                  const Text('階の用途'),
                  DDButton(
                    value: ref.watch(fireAlarmRequireProvider).usedType,
                    list: FireAlarmUsedTypeEnum.values
                        .map((e) => e.title)
                        .toList(),
                    func: ((newVal) {
                      ref
                          .read(fireAlarmRequireProvider.notifier)
                          .updateUsedType(newVal);
                    }),
                  ),

                  /// 計算実行ボタン
                  RunButton(
                    // paddingSize: blockWidth,
                    func: () {
                      /// TextEditingControllerのデータをproviderへ渡す
                      final sqTxtCtrl =
                          ref.read(fireAlarmReqSqTxtCtrlProvider).text;
                      ref
                          .read(fireAlarmRequireProvider.notifier)
                          .updateSq(sqTxtCtrl);

                      /// 計算実行
                      ref.read(fireAlarmRequireProvider.notifier).run();
                    },
                  ),

                  /// 広告表示
                  // existAds ? const ElecPowerRecBannerContainer() : Container(),

                  /// 結果表示
                  const SeparateText(title: '計算結果'),

                  /// 結果表示
                  OutputText(
                    preface: '消火器の',
                    result: ref.watch(fireAlarmRequireProvider).result,
                  ),

                  OutputText(
                    preface: ref.watch(fireAlarmRequireProvider).reason,
                    prefaceFontSize: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
