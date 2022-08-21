// import 'package:elec_facility_calc/ads_options.dart';
import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/notifiers/fire_report_require_notifier.dart';
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
class FireReportRequirePage extends ConsumerStatefulWidget {
  const FireReportRequirePage({Key? key}) : super(key: key);

  @override
  FireReportRequirePageState createState() => FireReportRequirePageState();
}

class FireReportRequirePageState extends ConsumerState<FireReportRequirePage> {
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
    ref.watch(fireReportRequireSPSetProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(PageNameEnum.fireReportRequire.title),
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
                        .watch(fireReportRequireProvider)
                        .firePreventProperty
                        .title,
                    func: (FirePreventPropertyEnum value) {
                      ref
                          .read(fireReportRequireProvider.notifier)
                          .updateFirePreventProperty(value);
                    },
                  ),

                  /// 延べ面積入力
                  /// 16項イを選択しているときは地階の床面積を入力
                  InputTextCard(
                    title: '延べ面積(整数のみ)',
                    unit: 'm2',
                    message: '整数のみ',
                    controller: ref.watch(fireReportReqSqTxtCtrlProvider),
                    func: (String value) {
                      ref
                          .read(fireReportRequireProvider.notifier)
                          .updateSq(value);
                    },
                  ),

                  /// 消防機関から著しく離れた場所その他総務省令で定める場所のチェックボックス
                  CheckBoxCard(
                    title: '消防機関から著しく離れた場所その他総務省令で定める場所',
                    isChecked: ref.watch(fireReportRequireProvider).isDistance,
                    func: (bool newBool) {
                      ref
                          .read(fireReportRequireProvider.notifier)
                          .updateIsDistance(newBool);
                    },
                  ),

                  /// 消防機関へ常時通報することができる電話を設置のチェックボックス
                  CheckBoxCard(
                    title: '消防機関へ常時通報することができる電話を設置',
                    isChecked:
                        ref.watch(fireReportRequireProvider).isAlwaysReport,
                    func: (bool newBool) {
                      ref
                          .read(fireReportRequireProvider.notifier)
                          .updateIsAlwaysReport(newBool);
                    },
                  ),

                  /// 計算実行ボタン
                  RunButton(
                    // paddingSize: blockWidth,
                    func: () {
                      /// TextEditingControllerのデータをproviderへ渡す
                      final sqTxtCtrl =
                          ref.read(fireReportReqSqTxtCtrlProvider).text;

                      ref
                          .read(fireReportRequireProvider.notifier)
                          .updateSq(sqTxtCtrl);

                      /// 計算実行
                      ref.read(fireReportRequireProvider.notifier).run();
                    },
                  ),

                  /// 広告表示
                  // existAds ? const ElecPowerRecBannerContainer() : Container(),

                  /// 結果表示
                  const SeparateText(title: '計算結果'),

                  /// 結果表示
                  OutputText(
                    result: ref.watch(fireReportRequireProvider).result,
                  ),

                  /// 理由表示
                  OutputText(
                    result: ref.watch(fireReportRequireProvider).reason,
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
