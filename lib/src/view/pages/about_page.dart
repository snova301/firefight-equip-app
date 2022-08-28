import 'package:firefight_equip/ads_options.dart';
import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/view/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 使い方やライセンスページをリンクするためのページ
class AboutPage extends ConsumerWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 画面情報
    // final screenWidth = MediaQuery.of(context).size.width;

    /// リワード広告ユニットの初期化
    existAds ? ref.read(rewardedAdProvider.notifier).initRewarded() : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(PageNameEnum.about.title),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
        // EdgeInsets.fromLTRB(screenWidth / 10, 40, screenWidth / 10, 20),
        //  const EdgeInsets.all(8),

        children: <Widget>[
          /// 情報更新日
          const Card(
            child: ListTile(
              title: Text('法令等について'),
              subtitle: Text('2022/7/1時点の情報をもとにアプリを製作しています'),
            ),
          ),

          /// 各URLをオープン
          /// 使い方ページ
          const LinkCard(
            urlTitle: '使い方',
            isSubtitle: true,
            urlName:
                'https://snova301.github.io/AppService/firefight_equip/howtouse.html',
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

          /// admobリワード広告
          existAds
              ? Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.favorite_border,
                      // color: Colors.pink,
                    ),
                    title: const Text('広告を見て開発を支援'),
                    contentPadding: const EdgeInsets.all(10),
                    onTap: () {
                      /// 広告の表示
                      ref
                          .read(rewardedAdProvider.notifier)
                          .showRewardedAd(context);
                    },
                  ),
                )
              : Container(),

          /// オープンソースライセンスの表示
          Card(
            child: ListTile(
              title: const Text('オープンソースライセンス'),
              onTap: () {
                showLicensePage(
                  context: context,
                  // applicationName: '消防設備計算アシスタント',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
