import 'package:firefight_equip/ads_options.dart';
import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/view/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// 使い方やライセンスページをリンクするためのページ
class AboutPage extends ConsumerWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 画面情報
    final screenWidth = MediaQuery.of(context).size.width;

    /// リワード広告ユニットの初期化
    RewardedAd? rewardedAd;

    void initRewarded() {
      rewardedAd = null;
      RewardedAd.load(
        adUnitId: AdsSettingsClass().rewardedAdUnitID(),
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            // print('$ad loaded.');
            rewardedAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            // print('RewardedAd failed to load: $error');
            rewardedAd = null;
          },
        ),
      );
    }

    void showRewardedAd(RewardedAd? rewardedAd) {
      if (rewardedAd == null) {
        // print('null error');
        return;
      }
      rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
          onAdShowedFullScreenContent: (RewardedAd ad) {
        // print('$ad onAdShowedFullScreenContent.'),
      }, onAdDismissedFullScreenContent: (RewardedAd ad) {
        // print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        initRewarded();
      }, onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        // print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        initRewarded();
      }, onAdImpression: (RewardedAd ad) {
        // print('$ad impression occurred.'),
      });
      rewardedAd.show(onUserEarnedReward: (
        AdWithoutView ad,
        RewardItem rewardItem,
      ) {
        // print('$ad, $rewardItem');
      });
    }

    initRewarded();

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

          /// admobリワード広告
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.favorite_border,
                color: Colors.pink,
              ),
              title: const Text('広告を見て開発を支援'),
              contentPadding: const EdgeInsets.all(10),
              onTap: () {
                showRewardedAd(rewardedAd);
              },
            ),
          ),

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
