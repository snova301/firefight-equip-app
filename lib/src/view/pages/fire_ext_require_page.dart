// import 'package:elec_facility_calc/ads_options.dart';
import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/notifiers/shared_pref_class.dart';
import 'package:firefight_equip/src/view/widgets/checkbox_card_widget.dart';
import 'package:firefight_equip/src/view/widgets/dropdown_fire_prevent_property_widget.dart';
import 'package:firefight_equip/src/view/widgets/input_text_card_widget.dart';
import 'package:firefight_equip/src/view/widgets/output_text_widget.dart';
import 'package:firefight_equip/src/view/widgets/responsive_widget.dart';
import 'package:firefight_equip/src/view/widgets/run_button_widget.dart';
import 'package:firefight_equip/src/view/widgets/separate_text_widget.dart';
import 'package:firefight_equip/src/notifiers/fire_ext_require_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 消火器具設置義務計算ページ
class FireExtRequirePage extends ConsumerStatefulWidget {
  const FireExtRequirePage({Key? key}) : super(key: key);

  @override
  FireExtRequirePageState createState() => FireExtRequirePageState();
}

class FireExtRequirePageState extends ConsumerState<FireExtRequirePage> {
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
    ref.watch(fireExtRequireSPSetProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(PageNameEnum.fireExtRequire.title),
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
                        .watch(fireExtRequireProvider)
                        .firePreventProperty
                        .title,
                    func: (FirePreventPropertyEnum value) {
                      ref
                          .read(fireExtRequireProvider.notifier)
                          .updateFirePreventProperty(value);
                    },
                  ),

                  /// 面積入力
                  InputTextCard(
                    title: ref.watch(fireExtRequireProvider).isNoWindow
                        ? '床面積(整数のみ)' // 地階、無窓階、3F以上の階は床面積で判断
                        : '延べ面積(整数のみ)',
                    unit: 'm2',
                    message: '整数のみ',
                    controller: ref.watch(fireExtReqSqTxtCtrlProvider),
                    func: (String value) {
                      ref.read(fireExtRequireProvider.notifier).updateSq(value);
                    },
                  ),

                  /// 地階、無窓階、3F以上のチェックボックス
                  CheckBoxCard(
                    title: '地階、無窓階、3F以上',
                    isChecked: ref.watch(fireExtRequireProvider).isNoWindow,
                    func: (bool newBool) {
                      ref
                          .read(fireExtRequireProvider.notifier)
                          .updateIsNoWindow(newBool);
                    },
                  ),

                  /// 少量危険物のチェックボックス
                  CheckBoxCard(
                    title: '少量危険物、指定可燃物',
                    isChecked: ref.watch(fireExtRequireProvider).isCombust,
                    func: (bool newBool) {
                      ref
                          .read(fireExtRequireProvider.notifier)
                          .updateIsCombust(newBool);
                    },
                  ),

                  /// 火を使用する器具のチェックボックス
                  /// 3項の判断に使用
                  CheckBoxCard(
                    title: '火を使用する器具を設置',
                    isChecked: ref.watch(fireExtRequireProvider).isUsedFire,
                    func: (bool newBool) {
                      ref
                          .read(fireExtRequireProvider.notifier)
                          .updateIsUsedFire(newBool);
                    },
                  ),

                  /// 計算実行ボタン
                  RunButton(
                    // paddingSize: blockWidth,
                    func: () {
                      final sqTxtCtrl =
                          ref.read(fireExtReqSqTxtCtrlProvider).text;
                      ref
                          .read(fireExtRequireProvider.notifier)
                          .updateSq(sqTxtCtrl);
                      ref.read(fireExtRequireProvider.notifier).run();
                    },
                  ),

                  /// 広告表示
                  // existAds ? const ElecPowerRecBannerContainer() : Container(),

                  /// 結果表示
                  const SeparateText(title: '計算結果'),

                  /// 結果表示
                  OutputText(
                    result: ref.watch(fireExtRequireProvider).result,
                  ),

                  /// 理由表示
                  OutputText(
                    result: ref.watch(fireExtRequireProvider).reason,
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
