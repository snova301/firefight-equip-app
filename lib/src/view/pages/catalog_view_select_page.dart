import 'package:firefight_equip/ads_options.dart';
import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/notifiers/catalog_list_notifier.dart';
import 'package:firefight_equip/src/notifiers/shared_pref_class.dart';
import 'package:firefight_equip/src/view/pages/catalog_create_page.dart';
import 'package:firefight_equip/src/view/widgets/common_widgets.dart';
import 'package:firefight_equip/src/view/widgets/drawer_contents_widget.dart';
import 'package:firefight_equip/src/view/widgets/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CatalogListPage extends ConsumerWidget {
  const CatalogListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 画面情報
    final screenWidth = MediaQuery.of(context).size.width;

    /// レスポンシブ設定
    bool isDrawerFixed = checkResponsive(screenWidth);

    /// 広告の初期化
    AdsSettingsClass().initStdBanner();

    /// shared_prefのデータ保存用非同期providerの読み込み
    ref.watch(catalogListSPSetProvider);

    /// 個数設定
    int maxNum = 3;

    return Scaffold(
      appBar: AppBar(
        title: Text(PageNameEnum.catalogList.title),
      ),
      body: Row(
        children: [
          /// 画面幅が規定以上でメニューを左側に固定
          isDrawerFixed ? const DrawerContentsFixed() : Container(),

          /// サイズ指定されていないとエラーなのでExpandedで囲む
          Expanded(
            child: Column(
              children: [
                /// 情報表示
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Text('資料は$maxNum個まで設定できます'),
                ),

                /// 広告
                existAds ? const StdBannerContainer() : Container(),

                /// リスト本体
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    itemCount: ref.watch(catalogListProvider).length,
                    itemBuilder: (context, index) {
                      return _CardListTile(
                        index: index,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      /// ドロワー
      drawer: const DrawerContents(),

      /// 新規作成のFAB
      floatingActionButton: _AddFAB(maxNum: maxNum),
    );
  }
}

/// cardのwidget
class _CardListTile extends ConsumerWidget {
  final int index;
  const _CardListTile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogList = ref.watch(catalogListProvider);
    return Card(
      child: ListTile(
        // タイトル
        title: Text(
          catalogList[index].title,
        ),
        // URL
        subtitle: TextButton(
          onPressed: () {
            // openUrl(catalogList[index].url);
            openUrlwSnackbar(catalogList[index].url, context);
          },
          style: const ButtonStyle(
            alignment: Alignment.centerLeft,
          ),
          child: Text(
            'URL : ${catalogList[index].url}',
          ),
        ),
        // 削除ボタン
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            AlertDialogClass(context: context).showAlertDialog(
              '確認',
              '削除しますか？',
              () {
                ref.read(catalogListProvider.notifier).removeCatalog(index);
              },
            );
          },
        ),
      ),
    );
  }
}

/// FABのwidget
/// 新規作成ページへジャンプ
class _AddFAB extends ConsumerWidget {
  final int maxNum;
  const _AddFAB({Key? key, required this.maxNum}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          /// 個数設定
          if (ref.read(catalogListProvider).length < maxNum) {
            /// ページ遷移
            /// 下から上に移動するアニメーション付き
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return const CatalogCreatePage();
                },
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: animation.drive(
                      Tween(
                        begin: const Offset(0.0, 1.0),
                        end: Offset.zero,
                      ).chain(
                        CurveTween(
                          curve: Curves.easeInOut,
                        ),
                      ),
                    ),
                    child: child,
                  );
                },
              ),
            );
          } else {
            /// 上限に到達したら、snackbarで警告
            SnackBarAlertClass(context: context).snackbar('上限です');
          }
        });
  }
}
