// import 'package:elec_facility_calc/ads_options.dart';
import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/notifiers/gas_alarm_require_notifier.dart';
import 'package:firefight_equip/src/notifiers/shared_pref_class.dart';
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
class GasAlarmRequirePage extends ConsumerStatefulWidget {
  const GasAlarmRequirePage({Key? key}) : super(key: key);

  @override
  GasAlarmRequirePageState createState() => GasAlarmRequirePageState();
}

class GasAlarmRequirePageState extends ConsumerState<GasAlarmRequirePage> {
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
    ref.watch(gasAlarmRequireSPSetProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(PageNameEnum.gasAlarmRequire.title),
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
                        .watch(gasAlarmRequireProvider)
                        .firePreventProperty
                        .title,
                    func: (FirePreventPropertyEnum value) {
                      ref
                          .read(gasAlarmRequireProvider.notifier)
                          .updateFirePreventProperty(value);
                    },
                  ),

                  /// 延べ面積入力
                  /// 16項イと地階のチェックボックスを選択しているときは地階の床面積を入力
                  InputTextCard(
                    title: ref
                                    .watch(gasAlarmRequireProvider)
                                    .firePreventProperty ==
                                FirePreventPropertyEnum.no16I &&
                            ref.watch(gasAlarmRequireProvider).isUnderGround
                        ? '地階の床面積(整数のみ)'
                        : '延べ面積(整数のみ)',
                    unit: 'm2',
                    message: '整数のみ',
                    controller: ref.watch(gasAlarmReqSqTxtCtrlProvider),
                    func: (String value) {
                      ref
                          .read(gasAlarmRequireProvider.notifier)
                          .updateSq(value);
                    },
                  ),

                  /// 地階のチェックボックス
                  CheckBoxCard(
                    title: '地階',
                    isChecked: ref.watch(gasAlarmRequireProvider).isUnderGround,
                    func: (bool newBool) {
                      ref
                          .read(gasAlarmRequireProvider.notifier)
                          .updateIsUnderGround(newBool);
                    },
                  ),

                  /// 床面積入力
                  /// 条件に一致すると表示される
                  ref.watch(gasAlarmRequireProvider).firePreventProperty ==
                              FirePreventPropertyEnum.no16No3 ||
                          (ref.watch(gasAlarmRequireProvider).isUnderGround &&
                              ref
                                  .watch(gasAlarmRequireProvider)
                                  .firePreventProperty
                                  .isSpecific)
                      ? InputTextCard(
                          title: '特定用途部分の床面積(整数のみ)',
                          unit: 'm2',
                          message: '整数のみ',
                          controller:
                              ref.watch(gasAlarmReqSqFloorTxtCtrlProvider),
                          func: (String value) {
                            ref
                                .read(gasAlarmRequireProvider.notifier)
                                .updateSqFloor(value);
                          },
                        )
                      : Container(),

                  /// 温泉施設のチェックボックス
                  CheckBoxCard(
                    title: '温泉施設',
                    isChecked: ref.watch(gasAlarmRequireProvider).isHotSpring,
                    func: (bool newBool) {
                      ref
                          .read(gasAlarmRequireProvider.notifier)
                          .updateIsHotSpring(newBool);
                    },
                  ),

                  /// 計算実行ボタン
                  RunButton(
                    // paddingSize: blockWidth,
                    func: () {
                      /// TextEditingControllerのデータをproviderへ渡す
                      final sqTxtCtrl =
                          ref.read(gasAlarmReqSqTxtCtrlProvider).text;
                      final sqFloorTxtCtrl =
                          ref.read(gasAlarmReqSqFloorTxtCtrlProvider).text;
                      ref
                          .read(gasAlarmRequireProvider.notifier)
                          .updateSq(sqTxtCtrl);
                      ref
                          .read(gasAlarmRequireProvider.notifier)
                          .updateSqFloor(sqFloorTxtCtrl);

                      /// 計算実行
                      ref.read(gasAlarmRequireProvider.notifier).run();
                    },
                  ),

                  /// 広告表示
                  // existAds ? const ElecPowerRecBannerContainer() : Container(),

                  /// 結果表示
                  const SeparateText(title: '計算結果'),

                  /// 結果表示
                  OutputText(
                    result: ref.watch(gasAlarmRequireProvider).result,
                  ),

                  /// 理由表示
                  OutputText(
                    result: ref.watch(gasAlarmRequireProvider).reason,
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
