// import 'package:flutter/foundation.dart';
// import 'package:firefight_equip/src/model/enum_class.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';



// /// 消火器設置義務判別計算のクラス
// @freezed
// class FireExtRequireClass with _$FireExtRequireClass {
//   const factory FireExtRequireClass({
//     /// 入力
//     required FirePreventPropertyEnum firePreventProperty, // 防火対象物種類
//     required int sq, // 面積
//     required bool isNoWindow, // 地階、無窓階、3F以上
//     required bool isCombust, // 少量危険物、指定可燃物
//     required bool isUsedFire, // 火を使用する器具(防火対象物 3項の判断に使用)

//     /// 出力
//     required String strOut, // 消火器設置が義務かどうか
//     required String reason, // 消火器具が必要な理由
//   }) = _FireExtRequireClass;

//   /// from Json
//   factory FireExtRequireClass.fromJson(Map<String, dynamic> json) =>
//       _$FireExtRequireClassFromJson(json);
// }

// /// 消火器具能力単位計算のクラス
// @freezed
// class FireExtCapacityClass with _$FireExtCapacityClass {
//   const factory FireExtCapacityClass({
//     /// 入力
//     required FirePreventPropertyEnum firePreventProperty, // 防火対象物種類
//     required int sq, // 延べ面積
//     required int sqElectrocity, // 電気設備面積
//     required int sqBoiler, // ボイラー室等の多量の火気を使用する部分の面積
//     required bool isFireproof, // 主要構造部が耐火構造でかつ壁及び天井が難燃材料
//     required bool isCombust, // 少量危険物、指定可燃物

//     /// 出力
//     required double resultA, // A火災の能力単位
//     required String resultB, // B火災の能力単位
//     required int resultC, // C火災の消火器の本数
//     required int resultBoiler, // ボイラー室への付加設置
//   }) = _FireExtCapacityClass;

//   /// from Json
//   factory FireExtCapacityClass.fromJson(Map<String, dynamic> json) =>
//       _$FireExtCapacityClassFromJson(json);
// }

// /// 設定用のデータクラス
// @freezed
// class SettingDataClass with _$SettingDataClass {
//   const factory SettingDataClass({
//     /// ダークモード
//     required bool darkMode,
//   }) = _SettingDataClass;

//   /// from Json
//   factory SettingDataClass.fromJson(Map<String, dynamic> json) =>
//       _$SettingDataClassFromJson(json);
// }
