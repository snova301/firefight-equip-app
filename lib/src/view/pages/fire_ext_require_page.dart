// import 'package:elec_facility_calc/ads_options.dart';
import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/view/widgets/fire_prevent_property_select_widget.dart';
import 'package:firefight_equip/src/view/widgets/input_text_card.dart';
import 'package:firefight_equip/src/view/widgets/responsive_widget.dart';
import 'package:firefight_equip/src/viewmodel/fire_ext_require_model.dart';
import 'package:firefight_equip/src/viewmodel/state_manager.dart';
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

                  /// 計算実行ボタン
                  CalcRunButton(
                    // paddingSize: blockWidth,
                    func: () {
                      // /// textcontrollerのデータを取得
                      // final volt = ref.read(elecPowerTxtCtrVoltProvider).text;
                      // final current =
                      //     ref.read(elecPowerTxtCtrCurrentProvider).text;
                      // final cosFai =
                      //     ref.read(elecPowerTxtCtrCosFaiProvider).text;
                    },
                  ),

                  /// 広告表示
                  // existAds ? const ElecPowerRecBannerContainer() : Container(),

                  /// 結果表示
                  const SeparateText(title: '計算結果'),

                  /// 皮相電力
                  // OutputTextCard(
                  //   title: '皮相電力',
                  //   unit: ref.watch(elecPowerProvider).powerUnit.strApparent,
                  //   result: ref.watch(elecPowerApparentPowerProvider),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 計算条件や計算結果の文字表示widget
class SeparateText extends ConsumerWidget {
  final String title; // 入力文字列

  const SeparateText({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}

/// 結果表示用のwidget
class OutputTextCard extends ConsumerWidget {
  final String title; // 出力タイトル
  final String unit; // 単位
  final String result; // 出力結果

  const OutputTextCard({
    Key? key,
    required this.title,
    required this.unit,
    required this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /// タイトル
          Container(
            // padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.fromLTRB(8, 8, 0, 0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
          ),

          /// 結果表示
          ListTile(
            title: Text(
              result,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            trailing: result == '候補なし' || result == '候補なし(電圧要確認)'
                ? const Text('')
                : Text(
                    unit,
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  ),
          ),

          ///
        ],
      ),
    );
  }
}

/// 実行ボタンのWidget
class CalcRunButton extends ConsumerWidget {
  final Function() func;

  const CalcRunButton({
    Key? key,
    required this.func,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          func();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.red),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          padding: MaterialStateProperty.all(
            const EdgeInsets.fromLTRB(30, 20, 30, 20),
          ),
        ),
        child: const Text(
          '計算実行',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
