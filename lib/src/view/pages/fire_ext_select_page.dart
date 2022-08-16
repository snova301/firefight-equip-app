import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/view/widgets/drawer_contents_widget.dart';
import 'package:firefight_equip/src/view/widgets/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firefight_equip/src/view/widgets/common_widgets.dart';

class SelectFireExtPage extends ConsumerWidget {
  const SelectFireExtPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 画面情報
    final screenWidth = MediaQuery.of(context).size.width;

    /// レスポンシブ設定
    bool isDrawerFixed = checkResponsive(screenWidth);

    return Scaffold(
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
              padding:
                  EdgeInsets.fromLTRB(screenWidth / 8, 60, screenWidth / 8, 60),
              children: <Widget>[
                _PagePush(
                  title: PageNameEnum.fireExtRequ.title,
                  pagepush: PageNameEnum.fireExtRequ.page,
                ),
                _PagePush(
                  title: PageNameEnum.fireExtCapa.title,
                  pagepush: PageNameEnum.fireExtCapa.page,
                ),
              ],
            ),
          ),
        ],
      ),

      /// ドロワー
      drawer: const DrawerContents(),
    );
  }
}

/// 各ページへの遷移
class _PagePush extends ConsumerWidget {
  final String title; // タイトル文字
  final dynamic pagepush; // 移動先のページ
  // final IconData? icon; // アイコン

  const _PagePush({
    Key? key,
    required this.title,
    required this.pagepush,
    // this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        /// ボタンのスタイル
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.red),
          // padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
          // minimumSize: MaterialStateProperty.all(const Size(10, 50)),
        ),

        /// ボタンを押したときの挙動
        onPressed: () {
          /// ページ遷移のanalytics
          AnalyticsService().logPage(title);

          /// ページ遷移
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => pagepush),
          );
        },

        /// ボタンの表示
        child: Container(
          padding: const EdgeInsets.all(20),
          // margin: const EdgeInsets.all(10),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
