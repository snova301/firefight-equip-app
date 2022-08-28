// import 'package:elec_facility_calc/ads_options.dart';
import 'package:firefight_equip/src/notifiers/catalog_list_notifier.dart';
import 'package:firefight_equip/src/view/widgets/responsive_widget.dart';
import 'package:firefight_equip/src/view/widgets/run_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// カタログリストページ
class CatalogCreatePage extends ConsumerWidget {
  const CatalogCreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 画面情報取得
    final mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;

    /// レスポンシブ設定
    bool isDrawerFixed = checkResponsive(screenWidth);

    /// 広告の初期化
    // AdsSettingsClass().initElecPowerRec();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('新規作成'),
        ),
        body: Row(
          children: [
            /// 画面幅が規定以上でメニューを左側に固定
            isDrawerFixed ? const DrawerContentsFixed() : Container(),

            /// サイズ指定されていないとエラーなのでExpandedで囲む
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                children: <Widget>[
                  /// タイトル入力
                  _CreateTextField(
                    controller: ref.watch(catalogTitleTxtCtrlProvider),
                    labelText: 'タイトル',
                    maxLen: 200,
                  ),

                  /// URL入力
                  _CreateTextField(
                    controller: ref.watch(catalogUrlTxtCtrlProvider),
                    labelText: 'URL',
                    maxLen: 400,
                  ),

                  /// 計算実行
                  RunButton(
                    func: () {
                      /// 追加
                      final title = ref.read(catalogTitleTxtCtrlProvider).text;
                      final url = ref.read(catalogUrlTxtCtrlProvider).text;
                      ref
                          .read(catalogListProvider.notifier)
                          .addCatalog(title, url);

                      /// 前の画面に戻る
                      Navigator.pop(context);
                    },
                    title: '新規作成',
                  ),

                  /// 広告表示
                  // existAds ? const ElecPowerRecBannerContainer() : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// テキスト入力
class _CreateTextField extends ConsumerWidget {
  final TextEditingController controller;
  final String labelText;
  final int maxLen;

  const _CreateTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.maxLen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      minVerticalPadding: 10,
      title: TextFormField(
        controller: controller,
        maxLength: maxLen,
        // minLines: 3,
        maxLines: 3,
        decoration: InputDecoration(
          labelText: labelText,
          alignLabelWithHint: true,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
