import 'package:firefight_equip/ads_options.dart';
import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/notifiers/shared_pref_class.dart';
import 'package:firefight_equip/src/view/widgets/checkbox_card_widget.dart';
import 'package:firefight_equip/src/view/widgets/dropdown_button_widget.dart';
import 'package:firefight_equip/src/view/widgets/output_text_widget.dart';
import 'package:firefight_equip/src/view/widgets/responsive_widget.dart';
import 'package:firefight_equip/src/view/widgets/separate_text_widget.dart';
import 'package:firefight_equip/src/notifiers/fire_ext_require_notifier.dart';
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

                  /// 消化器種類選択のドロップダウンリスト
                  DDButton(
                    value: 'a',
                    list: ['a', 'list', 'sa'],
                    func: (String val) {},
                  ),

                  /// 結果表示
                  const SeparateText(title: '結果'),

                  /// 結果表示(A火災に対して)
                  OutputText(
                    result: ref.watch(fireExtRequireProvider).result,
                  ),

                  /// 結果表示(B火災に対して)
                  OutputText(
                    result: ref.watch(fireExtRequireProvider).result,
                  ),

                  /// 結果表示(C火災に対して)
                  OutputText(
                    result: ref.watch(fireExtRequireProvider).result,
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
