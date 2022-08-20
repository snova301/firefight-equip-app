import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:url_launcher/url_launcher.dart';

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

/// firebase analyticsの管理
class AnalyticsService {
  Future<void> logPage(String screenName) async {
    await FirebaseAnalytics.instance.logEvent(
      name: screenName,
      // name: '変更だよ',
      // parameters: {
      //   'firebase_screen': screenName,
      // },
    );
  }
}

/// アプリ情報を載せたページへのリンク
class LinkCard extends StatelessWidget {
  final String urlTitle;
  final String urlName;
  final bool isSubtitle;
  final Color? cardColor;

  const LinkCard({
    Key? key,
    required this.urlTitle,
    required this.urlName,
    this.isSubtitle = false,
    this.cardColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      child: ListTile(
        title: Text(urlTitle),
        subtitle: isSubtitle ? Text('$urlTitleのwebページへ移動します。') : null,
        contentPadding: const EdgeInsets.all(10),
        onTap: () {
          /// ページ遷移のanalytics
          AnalyticsService().logPage(urlTitle);

          /// 開く
          openUrl(urlName);
        },
        trailing: const Icon(Icons.open_in_browser),
      ),
    );
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
