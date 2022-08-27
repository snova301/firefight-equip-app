import 'package:firefight_equip/src/model/catalog_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

/// カタログリストのProviderの定義
final catalogListProvider =
    StateNotifierProvider<CatalogListNotifier, List<CatalogListClass>>((ref) {
  return CatalogListNotifier();
});

/// 配線リスト入力のNotifierの定義
class CatalogListNotifier extends StateNotifier<List<CatalogListClass>> {
  // 初めての場合、サンプルデータとして初期化
  CatalogListNotifier()
      : super([
          CatalogListClass(
            id: const Uuid().v4(),
            title:
                'これはサンプルです。画面下部の追加ボタンから新規作成しましょう。URLをタップするとブラウザでwebページを開くことができます。',
            url: 'https://snova301.github.io/AppService/',
          )
        ]);

  /// 追加
  void addCatalog(String title, String url) {
    String id = const Uuid().v4();
    CatalogListClass catalog = CatalogListClass(id: id, title: title, url: url);
    state = [...state, catalog];
  }

  /// 全更新
  void updateCatalog(List<CatalogListClass> catalogList) {
    state = [...catalogList];
  }

  /// 削除
  void removeCatalog(int index) {
    List<CatalogListClass> catalogList = state;
    catalogList.removeAt(index);
    state = [...catalogList];
  }
}

/// カタログタイトル入力初期化
final catalogTitleTxtCtrlProvider = StateProvider.autoDispose((ref) {
  return TextEditingController();
});

/// カタログURL入力初期化
final catalogUrlTxtCtrlProvider = StateProvider.autoDispose((ref) {
  return TextEditingController();
});
