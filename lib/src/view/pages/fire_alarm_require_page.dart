// import 'package:elec_facility_calc/ads_options.dart';
import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/notifiers/fire_alarm_require_notifier.dart';
import 'package:firefight_equip/src/view/widgets/checkbox_card_widget.dart';
import 'package:firefight_equip/src/view/widgets/fire_prevent_property_select_widget.dart';
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

                  /// 面積入力
                  InputTextCard(
                    title: ref.watch(fireAlarmRequireProvider).isNoWindow
                        ? '床面積(整数のみ)' // 地階、無窓階、3F以上の階は床面積で判断
                        : '延べ面積(整数のみ)',
                    unit: 'm2',
                    message: '整数のみ',
                    controller: ref.watch(fireAlarmReqSqTxtCtrlProvider),
                    func: (String value) {
                      ref
                          .read(fireAlarmRequireProvider.notifier)
                          .updateSq(value);
                    },
                  ),

                  /// 地階、無窓階、3F以上のチェックボックス
                  CheckBoxCard(
                    title: '地階、無窓階、3F以上',
                    isChecked: ref.watch(fireAlarmRequireProvider).isNoWindow,
                    func: (bool newBool) {
                      ref
                          .read(fireAlarmRequireProvider.notifier)
                          .updateIsNoWindow(newBool);
                    },
                  ),

                  /// 少量危険物のチェックボックス
                  CheckBoxCard(
                    title: '少量危険物、指定可燃物',
                    isChecked: ref.watch(fireAlarmRequireProvider).isCombust,
                    func: (bool newBool) {
                      ref
                          .read(fireAlarmRequireProvider.notifier)
                          .updateIsCombust(newBool);
                    },
                  ),

                  /// 計算実行ボタン
                  RunButton(
                    // paddingSize: blockWidth,
                    func: () {
                      final sqTxtCtrl =
                          ref.read(fireAlarmReqSqTxtCtrlProvider).text;
                      ref
                          .read(fireAlarmRequireProvider.notifier)
                          .updateSq(sqTxtCtrl);
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
