import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firefight_equip/src/view/about_page.dart';
import 'package:firefight_equip/src/model/data_class.dart';
import 'package:firefight_equip/src/view/setting_page.dart';

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
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),

        /// 電力計算画面へ
        ListTile(
          title: Text(
            PageNameEnum.elecPower.title,
            style: TextStyle(fontSize: fontSize),
          ),
          leading: Icon(PageNameEnum.elecPower.icon),
          onTap: () {
            /// ページ遷移のanalytics
            AnalyticsService().logPage(PageNameEnum.elecPower.title);

            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingPage(),
              ),
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
                builder: (context) => const SettingPage(),
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

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AboutPage()));
          },
        ),
      ],
    );
  }
}

/// 画面幅が規定以上でメニューを固定
class DrawerContentsFixed extends StatelessWidget {
  const DrawerContentsFixed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return Row(
      children: [
        SizedBox(
          width: 230,
          child: ListView(
            controller: scrollController,
            children: const [
              DrawerContentsListTile(
                fontSize: 13,
              ),
            ],
          ),
        ),
        const VerticalDivider()
      ],
    );
  }
}

/// snackbarで注意喚起を行うWidget
class SnackBarAlert {
  final BuildContext context;
  SnackBarAlert({Key? key, required this.context}) : super();

  void snackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        duration: const Duration(milliseconds: 2000),
      ),
    );
  }
}

class AnalyticsService {
  Future<void> logPage(String screenName) async {
    await FirebaseAnalytics.instance.logEvent(
        // name: 'screen_view',
        // parameters: {
        //   'firebase_screen': screenName,
        // },
        name: screenName);
  }
}

/// URLを開く関数
void openUrl(urlname) async {
  final Uri url = Uri.parse(urlname);
  try {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } catch (e) {
    throw 'Could not launch $url';
  }
  // if (!await launchUrl(url, mode: LaunchMode.externalApplication))
  //   throw 'Could not launch $url';
}

/// レスポンシブ対応のための判定
bool checkResponsive(double screenWidth) {
  const widthBreakpoint = 700;

  if (screenWidth > widthBreakpoint) {
    return true;
  }
  return false;
}
