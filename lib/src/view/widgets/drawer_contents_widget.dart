import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/view/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ドロワーの中身
class DrawerContents extends ConsumerWidget {
  const DrawerContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          /// メニューを閉じる
          ListTile(
            title: const Text('メニューを閉じる'),
            leading: const Icon(Icons.close),
            onTap: () {
              Navigator.pop(context);
            },
            contentPadding: const EdgeInsets.fromLTRB(16, 35, 16, 15),
          ),

          /// 分割線
          const Divider(),

          const DrawerContentsListTile()
        ],
      ),
    );
  }
}

class DrawerContentsListTile extends ConsumerWidget {
  /// Drawer固定ならfontsizeを小さくする
  final double fontSize;

  const DrawerContentsListTile({
    Key? key,
    this.fontSize = 14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        /// トップページへ
        ListTile(
          title: Text(
            PageNameEnum.toppage.title,
            style: TextStyle(fontSize: fontSize),
          ),
          leading: Icon(PageNameEnum.toppage.icon),
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => PageNameEnum.toppage.page,
              ),
              (route) => false,
            );
          },
        ),

        /// 消火器計算選択画面
        ListTile(
          title: Text(
            PageNameEnum.fireExt.title,
            style: TextStyle(fontSize: fontSize),
          ),
          leading: Icon(PageNameEnum.fireExt.icon),
          onTap: () {
            /// ページ遷移のanalytics
            AnalyticsService().logPage(PageNameEnum.fireExt.title);

            /// ページプッシュしてもとのページを削除
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => PageNameEnum.fireExt.page,
              ),
              (route) => false,
            );
          },
        ),

        /// 設定画面へ
        ListTile(
          title: Text(
            PageNameEnum.setting.title,
            style: TextStyle(fontSize: fontSize),
          ),
          leading: Icon(PageNameEnum.setting.icon),
          onTap: () {
            /// ページ遷移のanalytics
            AnalyticsService().logPage(PageNameEnum.setting.title);

            // Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PageNameEnum.setting.page,
              ),
            );
          },
        ),

        /// 計算方法リンク
        ListTile(
          title: Text(
            '計算方法',
            style: TextStyle(fontSize: fontSize),
          ),
          // leading: const Icon(Icons.architecture),
          trailing: const Icon(Icons.open_in_browser),
          onTap: () {
            /// ページ遷移のanalytics
            AnalyticsService().logPage('計算方法');

            openUrl(
                'https://snova301.github.io/AppService/elec_calculator/method.html');
          },
        ),

        /// About
        ListTile(
          title: Text(
            PageNameEnum.about.title,
            style: TextStyle(fontSize: fontSize),
          ),
          onTap: () {
            /// ページ遷移のanalytics
            AnalyticsService().logPage(PageNameEnum.about.title);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PageNameEnum.about.page,
              ),
            );
          },
        ),
      ],
    );
  }
}
