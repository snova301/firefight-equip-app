// import 'package:elec_facility_calc/ads_options.dart';
import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/view/widgets/checkbox_card_widget.dart';
import 'package:firefight_equip/src/view/widgets/fire_prevent_property_select_widget.dart';
import 'package:firefight_equip/src/view/widgets/input_text_card_widget.dart';
import 'package:firefight_equip/src/view/widgets/responsive_widget.dart';
import 'package:firefight_equip/src/view/widgets/run_button_widget.dart';
import 'package:firefight_equip/src/view/widgets/separate_text_widget.dart';
import 'package:firefight_equip/src/notifiers/fire_ext_require_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 電力計算ページ
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
    // ref.watch(elecPowerSPSetProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(PageNameEnum.fireExt.title),
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
                  const FirePreventPropertySelectDD(),

                  /// 面積入力
                  InputTextCard(
                      title: '面積',
                      unit: 'm2',
                      message: '整数のみ',
                      controller: ref.watch(textInputProvider)),

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
                    isChecked: ref.watch(fireExtRequireProvider).isNoWindow,
                    func: (bool newBool) {
                      ref
                          .read(fireExtRequireProvider.notifier)
                          .updateIsNoWindow(newBool);
                    },
                  ),

                  /// 火を使用する器具のチェックボックス
                  /// 3項の判断に使用
                  CheckBoxCard(
                    title: '火を使用する器具(防火対象物 3項の判断に使用)',
                    isChecked: ref.watch(fireExtRequireProvider).isNoWindow,
                    func: (bool newBool) {
                      ref
                          .read(fireExtRequireProvider.notifier)
                          .updateIsNoWindow(newBool);
                    },
                  ),

                  /// 計算実行ボタン
                  RunButton(
                    // paddingSize: blockWidth,
                    func: () {
                      null;
                    },
                  ),

                  /// 広告表示
                  // existAds ? const ElecPowerRecBannerContainer() : Container(),

                  /// 結果表示
                  const SeparateText(title: '計算結果'),

                  /// 結果表示
                  _OutputText(
                    result: ref.watch(fireExtReqOutputProvider),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 結果表示用のwidget
class _OutputText extends ConsumerWidget {
  final String result; // 出力結果

  const _OutputText({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          '消火器の',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          result,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
