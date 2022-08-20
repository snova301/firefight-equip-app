import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/view/widgets/common_widgets.dart';
import 'package:flutter/material.dart';

/// 使い方やライセンスページをリンクするためのページ
class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 画面情報
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(PageNameEnum.about.title),
      ),
      body: ListView(
        padding:
            EdgeInsets.fromLTRB(screenWidth / 10, 40, screenWidth / 10, 20),
        //  const EdgeInsets.all(8),

        children: <Widget>[
          /// 各URLをオープン
          /// 使い方ページ
          const LinkCard(
            urlTitle: '使い方',
            isSubtitle: true,
            urlName:
                'https://snova301.github.io/AppService/elec_calculator/howtouse.html',
          ),

          /// 利用規約ページ
          const LinkCard(
            urlTitle: '利用規約',
            isSubtitle: true,
            urlName: 'https://snova301.github.io/AppService/common/terms.html',
          ),

          /// プライバシーポリシーページ
          const LinkCard(
            urlTitle: 'プライバシーポリシー',
            isSubtitle: true,
            urlName:
                'https://snova301.github.io/AppService/common/privacypolicy.html',
          ),

          /// お問い合わせフォーム
          const LinkCard(
            urlTitle: 'お問い合わせ',
            urlName: 'https://forms.gle/yBGDikXqZzWjco7z8',
          ),

          /// 支援サイト
          // Card(
          //   child: ListTile(
          //     leading: const Icon(
          //       Icons.favorite_border,
          //       color: Colors.pink,
          //     ),
          //     title: const Text('開発を支援'),
          //     contentPadding: const EdgeInsets.all(10),
          //     onTap: () => openUrl('https://www.buymeacoffee.com/snova301'),
          //     trailing: const Icon(Icons.open_in_browser),
          //   ),
          // ),

          /// オープンソースライセンスの表示
          Card(
            child: ListTile(
              title: const Text('オープンソースライセンス'),
              onTap: () {
                showLicensePage(context: context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
