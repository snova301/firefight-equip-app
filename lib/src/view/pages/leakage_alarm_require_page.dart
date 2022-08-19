// import 'package:elec_facility_calc/ads_options.dart';
import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/notifiers/leakage_alarm_require_notifier.dart';
import 'package:firefight_equip/src/view/widgets/checkbox_card_widget.dart';
import 'package:firefight_equip/src/view/widgets/dropdown_fire_prevent_property_widget.dart';
import 'package:firefight_equip/src/view/widgets/input_text_card_widget.dart';
import 'package:firefight_equip/src/view/widgets/output_text_widget.dart';
import 'package:firefight_equip/src/view/widgets/responsive_widget.dart';
import 'package:firefight_equip/src/view/widgets/run_button_widget.dart';
import 'package:firefight_equip/src/view/widgets/separate_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 消火器具設置義務計算ページ
class LeakageAlarmRequirePage extends ConsumerStatefulWidget {
  const LeakageAlarmRequirePage({Key? key}) : super(key: key);

  @override
  LeakageAlarmRequirePageState createState() => LeakageAlarmRequirePageState();
}

class LeakageAlarmRequirePageState
    extends ConsumerState<LeakageAlarmRequirePage> {
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
          title: Text(PageNameEnum.leakageAlarmRequire.title),
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
                        .watch(leakageAlarmRequireProvider)
                        .firePreventProperty
                        .title,
                    func: (FirePreventPropertyEnum value) {
                      ref
                          .read(leakageAlarmRequireProvider.notifier)
                          .updateFirePreventProperty(value);
                    },
                  ),

                  /// 延べ面積入力
                  /// 16項イを選択しているときは地階の床面積を入力
                  InputTextCard(
                    title: '延べ面積(整数のみ)',
                    unit: 'm2',
                    message: '整数のみ',
                    controller: ref.watch(leakageAlarmReqSqTxtCtrlProvider),
                    func: (String value) {
                      ref
                          .read(leakageAlarmRequireProvider.notifier)
                          .updateSq(value);
                    },
                  ),

                  /// 床面積入力
                  /// 条件に一致すると表示される
                  ref.watch(leakageAlarmRequireProvider).firePreventProperty ==
                          FirePreventPropertyEnum.no16I
                      ? InputTextCard(
                          title: '特定用途部分の床面積(整数のみ)',
                          unit: 'm2',
                          message: '整数のみ',
                          controller:
                              ref.watch(leakageAlarmReqSqFloorTxtCtrlProvider),
                          func: (String value) {
                            ref
                                .read(leakageAlarmRequireProvider.notifier)
                                .updateSqFloor(value);
                          },
                        )
                      : Container(),

                  /// 最大契約電流50A以上のチェックボックス
                  CheckBoxCard(
                    title: '最大契約電流が50A以上',
                    isChecked: ref
                        .watch(leakageAlarmRequireProvider)
                        .isContractCurrent,
                    func: (bool newBool) {
                      ref
                          .read(leakageAlarmRequireProvider.notifier)
                          .updateIsContractCurrent(newBool);
                    },
                  ),

                  /// 計算実行ボタン
                  RunButton(
                    // paddingSize: blockWidth,
                    func: () {
                      /// TextEditingControllerのデータをproviderへ渡す
                      final sqTxtCtrl =
                          ref.read(leakageAlarmReqSqTxtCtrlProvider).text;
                      final sqFloorTxtCtrl =
                          ref.read(leakageAlarmReqSqFloorTxtCtrlProvider).text;
                      ref
                          .read(leakageAlarmRequireProvider.notifier)
                          .updateSq(sqTxtCtrl);
                      ref
                          .read(leakageAlarmRequireProvider.notifier)
                          .updateSqFloor(sqFloorTxtCtrl);

                      /// 計算実行
                      ref.read(leakageAlarmRequireProvider.notifier).run();
                    },
                  ),

                  /// 広告表示
                  // existAds ? const ElecPowerRecBannerContainer() : Container(),

                  /// 結果表示
                  const SeparateText(title: '計算結果'),

                  /// 結果表示
                  OutputText(
                    result: ref.watch(leakageAlarmRequireProvider).result,
                  ),

                  /// 理由表示
                  OutputText(
                    result: ref.watch(leakageAlarmRequireProvider).reason,
                    resultFontColor: Colors.grey,
                    resultFontSize: 12,
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
