import 'package:firefight_equip/ads_options.dart';
import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/view/widgets/drawer_contents_widget.dart';
import 'package:firefight_equip/src/view/widgets/page_push_widget.dart';
import 'package:firefight_equip/src/view/widgets/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectFireExtPage extends ConsumerWidget {
  const SelectFireExtPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 画面情報
    final screenWidth = MediaQuery.of(context).size.width;

    /// レスポンシブ設定
    bool isDrawerFixed = checkResponsive(screenWidth);

    /// 広告の初期化
    AdsSettingsClass().initRecBanner();

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
                  EdgeInsets.fromLTRB(screenWidth / 10, 0, screenWidth / 8, 60),
              children: <Widget>[
                /// 注意書き
                Container(
                  padding: EdgeInsets.fromLTRB(
                      screenWidth / 15, 10, screenWidth / 15, 50),
                  child: const Text(
                    'ご利用時は必ず最新の法令や市町村条例を確認し、有資格者や関係機関と相談してください。',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),

                /// ページ遷移ボタン
                PagePushButton(
                  title: PageNameEnum.fireExtRequire.title,
                  pagepush: PageNameEnum.fireExtRequire.page,
                ),
                PagePushButton(
                  title: PageNameEnum.fireExtCapacity.title,
                  pagepush: PageNameEnum.fireExtCapacity.page,
                ),
                PagePushButton(
                  title: PageNameEnum.fireExtAdapt.title,
                  pagepush: PageNameEnum.fireExtAdapt.page,
                ),

                /// 広告表示
                existAds ? const RecBannerContainer() : Container(),
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
