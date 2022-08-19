import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/view/widgets/drawer_contents_widget.dart';
import 'package:firefight_equip/src/view/widgets/page_push_widget.dart';
import 'package:firefight_equip/src/view/widgets/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectFireAlarmPage extends ConsumerWidget {
  const SelectFireAlarmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 画面情報
    final screenWidth = MediaQuery.of(context).size.width;

    /// レスポンシブ設定
    bool isDrawerFixed = checkResponsive(screenWidth);

    return Scaffold(
      appBar: AppBar(
        title: Text(PageNameEnum.alarmEquip.title),
      ),
      body: Row(
        children: [
          /// 画面幅が規定以上でメニューを左側に固定
          isDrawerFixed ? const DrawerContentsFixed() : Container(),

          /// サイズ指定されていないとエラーなのでExpandedで囲む
          Expanded(
            child: ListView(
              padding:
                  EdgeInsets.fromLTRB(screenWidth / 8, 60, screenWidth / 8, 60),
              children: <Widget>[
                PagePushButton(
                  title: PageNameEnum.fireAlarmRequire.title,
                  pagepush: PageNameEnum.fireAlarmRequire.page,
                ),
                PagePushButton(
                  title: PageNameEnum.gasAlarmRequire.title,
                  pagepush: PageNameEnum.gasAlarmRequire.page,
                ),
                PagePushButton(
                  title: PageNameEnum.leakageAlarmRequire.title,
                  pagepush: PageNameEnum.leakageAlarmRequire.page,
                ),
                PagePushButton(
                  title: PageNameEnum.fireReportRequire.title,
                  pagepush: PageNameEnum.fireReportRequire.page,
                ),
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
