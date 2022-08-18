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
                  EdgeInsets.fromLTRB(screenWidth / 8, 60, screenWidth / 8, 60),
              children: <Widget>[
                PagePushButton(
                  title: PageNameEnum.fireExtRequire.title,
                  pagepush: PageNameEnum.fireExtRequire.page,
                ),
                PagePushButton(
                  title: PageNameEnum.fireExtCapacity.title,
                  pagepush: PageNameEnum.fireExtCapacity.page,
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
