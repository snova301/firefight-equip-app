import 'package:freezed_annotation/freezed_annotation.dart';

part 'catalog_list_model.freezed.dart';
part 'catalog_list_model.g.dart';

/// カタログリストのクラス
@freezed
class CatalogListClass with _$CatalogListClass {
  const factory CatalogListClass({
    required String id, // id
    required String title, // タイトル
    required String url, // url
    // required DateTime date, // 登録日
  }) = _CatalogListClass;

  /// from Json
  factory CatalogListClass.fromJson(Map<String, dynamic> json) =>
      _$CatalogListClassFromJson(json);
}
