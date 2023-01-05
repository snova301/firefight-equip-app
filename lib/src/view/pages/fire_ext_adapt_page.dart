import 'package:firefight_equip/ads_options.dart';
import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/notifiers/fire_ext_adapt_notifier.dart';
import 'package:firefight_equip/src/notifiers/shared_pref_class.dart';
import 'package:firefight_equip/src/view/widgets/dropdown_button_widget.dart';
import 'package:firefight_equip/src/view/widgets/output_text_widget.dart';
import 'package:firefight_equip/src/view/widgets/responsive_widget.dart';
import 'package:firefight_equip/src/view/widgets/separate_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 消火器適応火災表示ページ
class FireExtAdaptPage extends ConsumerStatefulWidget {
  const FireExtAdaptPage({Key? key}) : super(key: key);

  @override
  FireExtAdaptPageState createState() => FireExtAdaptPageState();
}

class FireExtAdaptPageState extends ConsumerState<FireExtAdaptPage> {
  @override
  Widget build(BuildContext context) {
    /// 画面情報取得
    final mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;
    final listViewPadding = screenWidth / 20;

    /// レスポンシブ設定
    bool isDrawerFixed = checkResponsive(screenWidth);

    /// 広告の初期化
    AdsSettingsClass().initRecBanner();

    /// shared_prefのデータ保存用非同期providerの読み込み
    ref.watch(fireExtAdaptSPSetProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(PageNameEnum.fireExtAdapt.title),
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
                  const SeparateText(title: '条件'),

                  /// 消火器種類選択のドロップダウンリスト
                  DDButton(
                    // value: FireExtAdaptEnum.none.title,
                    value: ref.watch(fireExtAdaptProvider).fireExtAdapt.title,
                    list: FireExtAdaptEnum.values.map((e) => e.title).toList(),
                    strTitle: '消火器の種類',
                    func: (String val) {
                      /// 値の検索とFireExtAdaptEnumへの変換
                      var newVal = FireExtAdaptEnum.values
                          .firstWhere((element) => element.title == val);
                      ref
                          .read(fireExtAdaptProvider.notifier)
                          .updateFireExt(newVal);
                    },
                  ),

                  /// 結果表示
                  const SeparateText(title: '消火器の適応火災の結果'),

                  /// 結果の表
                  Table(
                    border: TableBorder.all(
                      color: Colors.grey,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    children: [
                      TableRow(
                        children: [
                          const FireExtAdaptOutputText(
                            result: 'A火災',
                          ),
                          FireExtAdaptOutputText(
                            result: ref.watch(fireExtAdaptProvider).resultA,
                            textColor: Colors.red,
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const FireExtAdaptOutputText(
                            result: 'B火災',
                          ),
                          FireExtAdaptOutputText(
                            result: ref.watch(fireExtAdaptProvider).resultB,
                            textColor: Colors.red,
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const FireExtAdaptOutputText(
                            result: 'C火災',
                          ),
                          FireExtAdaptOutputText(
                            result: ref.watch(fireExtAdaptProvider).resultC,
                            textColor: Colors.red,
                          ),
                        ],
                      ),
                    ],
                  ),

                  /// 説明
                  const OutputText(
                    result: '○は適応, △は一部適応, -は適応していない',
                    resultFontColor: Colors.grey,
                    resultFontSize: 12,
                  ),

                  /// 広告表示
                  existAds ? const RecBannerContainer() : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 結果表示用テーブルセルwidget
class FireExtAdaptOutputText extends ConsumerWidget {
  final String result; // 出力結果
  final Color? textColor; // 文字色

  const FireExtAdaptOutputText({
    Key? key,
    required this.result,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Text(
        result,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        overflow: TextOverflow.clip,
      ),
    );
  }
}
