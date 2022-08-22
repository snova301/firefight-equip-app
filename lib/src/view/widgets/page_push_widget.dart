import 'package:firefight_equip/src/view/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 各ページへの遷移
class PagePushButton extends ConsumerWidget {
  final String title; // タイトル文字
  final dynamic pagepush; // 移動先のページ
  // final IconData? icon; // アイコン

  const PagePushButton({
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
          backgroundColor: MaterialStateProperty.all(Colors.orange),
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
              // fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
