// import 'package:elec_facility_calc/ads_options.dart';
import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/notifiers/fire_ext_capacity_notifier.dart';
import 'package:firefight_equip/src/view/widgets/checkbox_card_widget.dart';
import 'package:firefight_equip/src/view/widgets/fire_prevent_property_select_widget.dart';
import 'package:firefight_equip/src/view/widgets/input_text_card_widget.dart';
import 'package:firefight_equip/src/view/widgets/output_text_widget.dart';
import 'package:firefight_equip/src/view/widgets/responsive_widget.dart';
import 'package:firefight_equip/src/view/widgets/run_button_widget.dart';
import 'package:firefight_equip/src/view/widgets/separate_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 消火器具能力単位計算ページ
class FireExtCapacityPage extends ConsumerStatefulWidget {
  const FireExtCapacityPage({Key? key}) : super(key: key);

  @override
  FireExtCapacityPageState createState() => FireExtCapacityPageState();
}

class FireExtCapacityPageState extends ConsumerState<FireExtCapacityPage> {
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
          title: Text(PageNameEnum.fireExtCapacity.title),
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
                        .watch(fireExtCapacityProvider)
                        .firePreventProperty
                        .title,
                    func: (FirePreventPropertyEnum value) {
                      ref
                          .read(fireExtCapacityProvider.notifier)
                          .updateFirePreventProperty(value);
                    },
                  ),

                  /// 延べ面積入力
                  InputTextCard(
                    title: '延べ面積(整数のみ)',
                    unit: 'm2',
                    message: '整数のみ',
                    controller: ref.watch(fireExtCapaSqTxtCtrlProvider),
                    func: (String value) {
                      ref
                          .read(fireExtCapacityProvider.notifier)
                          .updateSq(value);
                    },
                  ),

                  /// 電気設備面積入力
                  InputTextCard(
                    title: '電気設備面積(整数のみ)',
                    unit: 'm2',
                    message: '整数のみ',
                    controller: ref.watch(fireExtCapaSqElecTxtCtrlProvider),
                    func: (String value) {
                      ref
                          .read(fireExtCapacityProvider.notifier)
                          .updateSqElectrocity(value);
                    },
                  ),

                  /// ボイラー室面積入力
                  InputTextCard(
                    title: 'ボイラー室面積(整数のみ)',
                    unit: 'm2',
                    message: '整数のみ',
                    controller: ref.watch(fireExtCapaSqBoilerTxtCtrlProvider),
                    func: (String value) {
                      ref
                          .read(fireExtCapacityProvider.notifier)
                          .updateSqBoiler(value);
                    },
                  ),

                  /// 少量危険物のチェックボックス
                  CheckBoxCard(
                    title: '主要構造部が耐火構造でかつ壁及び天井が難燃材料',
                    isChecked: ref.watch(fireExtCapacityProvider).isFireproof,
                    func: (bool newBool) {
                      ref
                          .read(fireExtCapacityProvider.notifier)
                          .updateIsFireproof(newBool);
                    },
                  ),

                  /// 少量危険物のチェックボックス
                  CheckBoxCard(
                    title: '少量危険物、指定可燃物',
                    isChecked: ref.watch(fireExtCapacityProvider).isCombust,
                    func: (bool newBool) {
                      ref
                          .read(fireExtCapacityProvider.notifier)
                          .updateIsCombust(newBool);
                    },
                  ),

                  /// 計算実行ボタン
                  RunButton(
                    // paddingSize: blockWidth,
                    func: () {
                      /// TextEditingControllerのデータをproviderへ渡す
                      final sqTxtCtrl =
                          ref.read(fireExtCapaSqTxtCtrlProvider).text;
                      final sqElecTxtCtrl =
                          ref.read(fireExtCapaSqElecTxtCtrlProvider).text;
                      final sqBoilerTxtCtrl =
                          ref.read(fireExtCapaSqBoilerTxtCtrlProvider).text;

                      ref
                          .read(fireExtCapacityProvider.notifier)
                          .updateSq(sqTxtCtrl);
                      ref
                          .read(fireExtCapacityProvider.notifier)
                          .updateSqElectrocity(sqElecTxtCtrl);
                      ref
                          .read(fireExtCapacityProvider.notifier)
                          .updateSqBoiler(sqBoilerTxtCtrl);

                      /// 実行
                      ref.read(fireExtCapacityProvider.notifier).run();
                    },
                  ),

                  /// 広告表示
                  // existAds ? const ElecPowerRecBannerContainer() : Container(),

                  /// 結果表示
                  const SeparateText(title: '計算結果'),

                  /// A火災の能力単位
                  OutputText(
                    preface: 'A消火器の能力単位 : ',
                    result:
                        ref.watch(fireExtCapacityProvider).resultA.toString(),
                  ),

                  /// C火災の消火器の本数
                  OutputText(
                    preface: '電気設備がある場所の消火器本数(付加設置) : ',
                    result:
                        '${ref.watch(fireExtCapacityProvider).resultC.toString()} 本',
                  ),

                  /// ボイラー室付加設置の消火器の本数
                  OutputText(
                    preface: 'ボイラー室がある場所の消火器本数(付加設置) : ',
                    result:
                        '${ref.watch(fireExtCapacityProvider).resultBoiler.toString()} 本',
                  ),

                  /// B火災の能力単位
                  OutputText(
                    preface: ref.watch(fireExtCapacityProvider).resultB,
                    prefaceFontColor: Colors.red,
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
