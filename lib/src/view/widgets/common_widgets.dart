import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:url_launcher/url_launcher.dart';

/// snackbarで注意喚起を行うWidget
///
/// 使い方
/// SnackBarAlert(context: context).snackbar('これ以上追加できません');
class SnackBarAlertClass {
  final BuildContext context;
  SnackBarAlertClass({Key? key, required this.context}) : super();

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

/// dialogの表示
class AlertDialogClass {
  final BuildContext context;
  AlertDialogClass({Key? key, required this.context}) : super();

  void showAlertDialog(String title, String content, Function() onOkPressed) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              onOkPressed();
              Navigator.pop(context, 'OK');
            },
            child: const Text('OK'),
          ),
        ],
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
  final Color? fontColor;

  const LinkCard(
      {Key? key,
      required this.urlTitle,
      required this.urlName,
      this.isSubtitle = false,
      this.cardColor,
      this.fontColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      child: ListTile(
        title: Text(
          urlTitle,
          style: TextStyle(
            color: fontColor,
          ),
        ),
        subtitle: isSubtitle
            ? Text(
                '$urlTitleのwebページへ移動します。',
                style: TextStyle(
                  color: fontColor,
                ),
              )
            : null,
        contentPadding: const EdgeInsets.all(10),
        onTap: () {
          /// ページ遷移のanalytics
          AnalyticsService().logPage(urlTitle);

          /// 開く
          openUrlwSnackbar(urlName, context);
        },
        trailing: Icon(
          Icons.open_in_browser,
          color: fontColor,
        ),
      ),
    );
  }
}

/// URLを開く関数
/// 失敗した場合、snackbarで警告
void openUrlwSnackbar(String urlname, BuildContext context) async {
  // final Uri url = Uri.parse(urlname);
  // try {
  //   await launchUrl(url, mode: LaunchMode.externalApplication);
  // } catch (e) {
  //   throw 'Could not launch $url';
  // }
  var url = Uri.parse(urlname);
  if (await canLaunchUrl(url)) {
    launchUrl(url);
  } else {
    SnackBarAlertClass(context: context).snackbar('URLが無効です');
  }
}
