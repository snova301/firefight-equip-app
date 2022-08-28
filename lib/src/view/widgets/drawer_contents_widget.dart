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

  void toPagePush(BuildContext context, String pagename, dynamic toPage) {
    /// ページ遷移のanalytics
    AnalyticsService().logPage(pagename);

    /// もとのページを削除し、トップページにプッシュしてから予定のページへプッシュ
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => PageNameEnum.toppage.page,
      ),
      (_) => false,
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => toPage),
    );
  }

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
            toPagePush(
              context,
              PageNameEnum.fireExt.title,
              PageNameEnum.fireExt.page,
            );
          },
        ),

        /// 警報設備計算選択画面
        ListTile(
          title: Text(
            PageNameEnum.alarmEquip.title,
            style: TextStyle(fontSize: fontSize),
          ),
          leading: Icon(PageNameEnum.alarmEquip.icon),
          onTap: () {
            toPagePush(
              context,
              PageNameEnum.alarmEquip.title,
              PageNameEnum.alarmEquip.page,
            );
          },
        ),

        /// 法令表示画面
        ListTile(
          title: Text(
            PageNameEnum.showLaw.title,
            style: TextStyle(fontSize: fontSize),
          ),
          leading: Icon(PageNameEnum.showLaw.icon),
          onTap: () {
            toPagePush(
              context,
              PageNameEnum.showLaw.title,
              PageNameEnum.showLaw.page,
            );
          },
        ),

        /// 法令表示画面
        ListTile(
          title: Text(
            PageNameEnum.catalogList.title,
            style: TextStyle(fontSize: fontSize),
          ),
          leading: Icon(PageNameEnum.catalogList.icon),
          onTap: () {
            toPagePush(
              context,
              PageNameEnum.catalogList.title,
              PageNameEnum.catalogList.page,
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
            toPagePush(
              context,
              PageNameEnum.setting.title,
              PageNameEnum.setting.page,
            );
          },
        ),

        /// About
        ListTile(
          title: Text(
            PageNameEnum.about.title,
            style: TextStyle(fontSize: fontSize),
          ),
          onTap: () {
            toPagePush(
              context,
              PageNameEnum.about.title,
              PageNameEnum.about.page,
            );
          },
        ),
      ],
    );
  }
}
