import 'package:firefight_equip/src/view/fire_extinguisher_require_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firefight_equip/src/model/data_class.dart';
import 'package:firefight_equip/src/view/about_page.dart';
import 'package:firefight_equip/src/view/setting_page.dart';
import 'package:firefight_equip/src/view/common_widgets.dart';

class SelectFireExtPage extends ConsumerWidget {
  const SelectFireExtPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 画面情報
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(PageNameEnum.fireExt.title),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(screenWidth / 6, 80, screenWidth / 6, 80),
        children: const <Widget>[
          _PagePush(
            title: '消火器 設置基準計算',
            pagepush: FireExtRequirePage(),
          ),
          _PagePush(
            title: '消火器 能力単位計算',
            pagepush: SettingPage(),
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
