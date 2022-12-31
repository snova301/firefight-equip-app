import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/model/fire_alarm_require_model.dart';
import 'package:firefight_equip/src/notifiers/fire_alarm_require_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('test test', () {
    test('Riverpod test', () {
      /// ProviderContainerの定義
      final container = ProviderContainer(
        overrides: [
          /// riverpod v2.x
          fireAlarmRequireProvider.overrideWithProvider(StateNotifierProvider<
              FireAlarmRequireNotifier, FireAlarmRequireClass>((ref) {
            return FireAlarmRequireNotifier();
          })),

          /// riverpod v1.x
          // fireAlarmRequireProvider
          //     .overrideWithValue(FireAlarmRequireNotifier()),
        ],
      );

      /// 初期状態の確認
      expect(
        container.read(fireAlarmRequireProvider).sq,
        0,
      );
      expect(
        container.read(fireAlarmRequireProvider).isNoWindow,
        false,
      );

      /// 値を変更してみる
      container.read(fireAlarmRequireProvider.notifier).updateIsNoWindow(true);
      expect(
        container.read(fireAlarmRequireProvider).isNoWindow,
        true,
      );
    });
  });
  group('notifier test', () {
    /// 消防法施行令 第21条の1項の確認
    test('no21-1', () {
      /// ProviderContainerの定義
      final container = ProviderContainer(
        overrides: [
          /// riverpod v2.x
          fireAlarmRequireProvider.overrideWithProvider(StateNotifierProvider<
              FireAlarmRequireNotifier, FireAlarmRequireClass>((ref) {
            return FireAlarmRequireNotifier();
          })),

          /// riverpod v1.x
          // fireAlarmRequireProvider
          //     .overrideWithValue(FireAlarmRequireNotifier()),
        ],
      );

      /// 指定可燃物のループ
      [true, false].forEach((isCombust) {
        container
            .read(fireAlarmRequireProvider.notifier)
            .updateIsCombust(isCombust);

        /// 宿泊施設のループ
        [true, false].forEach((isLodge) {
          container
              .read(fireAlarmRequireProvider.notifier)
              .updateIsLodge(isLodge);

          /// 無窓階のループ
          [true, false].forEach((isNoWindow) {
            container
                .read(fireAlarmRequireProvider.notifier)
                .updateIsNoWindow(isNoWindow);

            /// 特定1階段等防火対象物のループ
            [true, false].forEach((isOneStairs) {
              container
                  .read(fireAlarmRequireProvider.notifier)
                  .updateIsOneStairs(isOneStairs);

              /// スプリンクラー設備のループ
              [true, false].forEach((isSprinkler) {
                container
                    .read(fireAlarmRequireProvider.notifier)
                    .updateIsSprinkler(isSprinkler);

                /// 延べ面積のループ
                ['0', '200', '300', '500', '1000'].forEach((sq) {
                  container
                      .read(fireAlarmRequireProvider.notifier)
                      .updateSq(sq);

                  /// 床面積のループ
                  ['0', '100', '200', '300', '400', '500', '600']
                      .forEach((sqFloor) {
                    container
                        .read(fireAlarmRequireProvider.notifier)
                        .updateSq(sqFloor);

                    /// 階のループ
                    FireAlarmFloorEnum.values.toList().forEach((floor) {
                      container
                          .read(fireAlarmRequireProvider.notifier)
                          .updateFloor(floor.title);

                      /// 用途のループ
                      FireAlarmUsedTypeEnum.values.toList().forEach((usedType) {
                        container
                            .read(fireAlarmRequireProvider.notifier)
                            .updateUsedType(usedType.title);

                        /// 防火対象物のループ
                        FirePreventPropertyEnum.values
                            .toList()
                            .forEach((firePreventProperty) {
                          container
                              .read(fireAlarmRequireProvider.notifier)
                              .updateFirePreventProperty(firePreventProperty);
                          var property = container
                              .read(fireAlarmRequireProvider)
                              .firePreventProperty;

                          /// 実行
                          container
                              .read(fireAlarmRequireProvider.notifier)
                              .run();

                          if (
                              // 第3項
                              container
                                      .read(fireAlarmRequireProvider)
                                      .isSprinkler &&
                                  !property.isSpecific &&
                                  !container
                                      .read(fireAlarmRequireProvider)
                                      .isNoWindow &&
                                  container
                                          .read(fireAlarmRequireProvider)
                                          .floor !=
                                      FireAlarmFloorEnum.basement.title &&
                                  container
                                          .read(fireAlarmRequireProvider)
                                          .floor !=
                                      FireAlarmFloorEnum.floorOver11.title) {
                            expect(
                              container.read(fireAlarmRequireProvider).result,
                              RequireSentenceEnum.complex.title,
                              reason:
                                  '第3項 : $isCombust, $isLodge, $isNoWindow, $isOneStairs, $isSprinkler, $sq, $sqFloor, $floor, $usedType, ${property.title}',
                            );
                          } else if (
                              // 第1号イ
                              property == FirePreventPropertyEnum.no2Ni ||
                                  property == FirePreventPropertyEnum.no5I ||
                                  property == FirePreventPropertyEnum.no6I123 ||
                                  property == FirePreventPropertyEnum.no6Ro ||
                                  property == FirePreventPropertyEnum.no13Ro ||
                                  property == FirePreventPropertyEnum.no17) {
                            expect(
                              container.read(fireAlarmRequireProvider).result,
                              RequireSentenceEnum.yes.title,
                              reason:
                                  '第1号イ : $isCombust, $isLodge, $isNoWindow, $isOneStairs, $isSprinkler, $sq, $sqFloor, $floor, $usedType, ${property.title}',
                            );
                          } else if (
                              // 第1号ロ
                              property == FirePreventPropertyEnum.no6Ha &&
                                  container
                                      .read(fireAlarmRequireProvider)
                                      .isLodge) {
                            expect(
                              container.read(fireAlarmRequireProvider).result,
                              RequireSentenceEnum.yes.title,
                              reason:
                                  '第1号ロ : $isCombust, $isLodge, $isNoWindow, $isOneStairs, $isSprinkler, $sq, $sqFloor, $floor, $usedType, ${property.title}',
                            );
                          } else if (
                              // 第2号
                              property == FirePreventPropertyEnum.no9I &&
                                  container.read(fireAlarmRequireProvider).sq >=
                                      200) {
                            expect(
                              container.read(fireAlarmRequireProvider).result,
                              RequireSentenceEnum.yes.title,
                              reason:
                                  '第2号 : $isCombust, $isLodge, $isNoWindow, $isOneStairs, $isSprinkler, $sq, $sqFloor, $floor, $usedType, ${property.title}',
                            );
                          } else if (
                              // 第3号イ
                              (property == FirePreventPropertyEnum.no1I ||
                                      property ==
                                          FirePreventPropertyEnum.no1Ro ||
                                      property ==
                                          FirePreventPropertyEnum.no2I ||
                                      property ==
                                          FirePreventPropertyEnum.no2Ro ||
                                      property ==
                                          FirePreventPropertyEnum.no2Ha ||
                                      property ==
                                          FirePreventPropertyEnum.no3I ||
                                      property ==
                                          FirePreventPropertyEnum.no3Ro ||
                                      property == FirePreventPropertyEnum.no4 ||
                                      property ==
                                          FirePreventPropertyEnum.no6I4 ||
                                      property ==
                                          FirePreventPropertyEnum.no6Ni ||
                                      property ==
                                          FirePreventPropertyEnum.no16I ||
                                      property ==
                                          FirePreventPropertyEnum.no16No2) &&
                                  container.read(fireAlarmRequireProvider).sq >=
                                      300) {
                            expect(
                              container.read(fireAlarmRequireProvider).result,
                              RequireSentenceEnum.yes.title,
                              reason:
                                  '第3号イ : $isCombust, $isLodge, $isNoWindow, $isOneStairs, $isSprinkler, $sq, $sqFloor, $floor, $usedType, ${property.title}',
                            );
                          } else if (
                              // 第3号ロ
                              property == FirePreventPropertyEnum.no6Ha &&
                                  !container
                                      .read(fireAlarmRequireProvider)
                                      .isLodge) {
                            expect(
                              container.read(fireAlarmRequireProvider).result,
                              RequireSentenceEnum.yes.title,
                              reason:
                                  '第3号ロ : $isCombust, $isLodge, $isNoWindow, $isOneStairs, $isSprinkler, $sq, $sqFloor, $floor, $usedType, ${property.title}',
                            );
                          } else if (
                              // 第4号
                              (property == FirePreventPropertyEnum.no5Ro ||
                                      property == FirePreventPropertyEnum.no7 ||
                                      property == FirePreventPropertyEnum.no8 ||
                                      property ==
                                          FirePreventPropertyEnum.no9Ro ||
                                      property ==
                                          FirePreventPropertyEnum.no10 ||
                                      property ==
                                          FirePreventPropertyEnum.no12I ||
                                      property ==
                                          FirePreventPropertyEnum.no12Ro ||
                                      property ==
                                          FirePreventPropertyEnum.no13I ||
                                      property ==
                                          FirePreventPropertyEnum.no14) &&
                                  container.read(fireAlarmRequireProvider).sq >=
                                      500) {
                            expect(
                              container.read(fireAlarmRequireProvider).result,
                              RequireSentenceEnum.yes.title,
                              reason:
                                  '第4号 : $isCombust, $isLodge, $isNoWindow, $isOneStairs, $isSprinkler, $sq, $sqFloor, $floor, $usedType, ${property.title}',
                            );
                          } else if (
                              // 第5号
                              property == FirePreventPropertyEnum.no16No3 &&
                                  container.read(fireAlarmRequireProvider).sq >=
                                      500 &&
                                  container
                                          .read(fireAlarmRequireProvider)
                                          .sqFloor >=
                                      300) {
                            expect(
                              container.read(fireAlarmRequireProvider).result,
                              RequireSentenceEnum.yes.title,
                              reason:
                                  '第5号 : $isCombust, $isLodge, $isNoWindow, $isOneStairs, $isSprinkler, $sq, $sqFloor, $floor, $usedType, ${property.title}',
                            );
                          } else if (
                              // 第6号
                              (property == FirePreventPropertyEnum.no11 ||
                                      property ==
                                          FirePreventPropertyEnum.no15) &&
                                  container.read(fireAlarmRequireProvider).sq >=
                                      1000) {
                            expect(
                              container.read(fireAlarmRequireProvider).result,
                              RequireSentenceEnum.yes.title,
                              reason:
                                  '第6号 : $isCombust, $isLodge, $isNoWindow, $isOneStairs, $isSprinkler, $sq, $sqFloor, $floor, $usedType, ${property.title}',
                            );
                          } else if (
                              // 第7号
                              property.isSpecific &&
                                  (property != FirePreventPropertyEnum.no16I ||
                                      property !=
                                          FirePreventPropertyEnum.no16No2 ||
                                      property !=
                                          FirePreventPropertyEnum.no16No3) &&
                                  container
                                      .read(fireAlarmRequireProvider)
                                      .isOneStairs) {
                            expect(
                              container.read(fireAlarmRequireProvider).result,
                              RequireSentenceEnum.yes.title,
                              reason:
                                  '第7号 : $isCombust, $isLodge, $isNoWindow, $isOneStairs, $isSprinkler, $sq, $sqFloor, $floor, $usedType, ${property.title}',
                            );
                          } else if (
                              // 第8号
                              container
                                  .read(fireAlarmRequireProvider)
                                  .isCombust) {
                            expect(
                              container.read(fireAlarmRequireProvider).result,
                              RequireSentenceEnum.yes.title,
                              reason:
                                  '第8号 : $isCombust, $isLodge, $isNoWindow, $isOneStairs, $isSprinkler, $sq, $sqFloor, $floor, $usedType, ${property.title}',
                            );
                          } else if (
                              // 第9号
                              property == FirePreventPropertyEnum.no16No2) {
                            expect(
                              container.read(fireAlarmRequireProvider).result,
                              RequireSentenceEnum.complex.title,
                              reason:
                                  '第9号 : $isCombust, $isLodge, $isNoWindow, $isOneStairs, $isSprinkler, $sq, $sqFloor, $floor, $usedType, ${property.title}',
                            );
                          } else if (
                              // 第10号
                              (property == FirePreventPropertyEnum.no2I ||
                                      property ==
                                          FirePreventPropertyEnum.no2Ro ||
                                      property ==
                                          FirePreventPropertyEnum.no2Ha ||
                                      property ==
                                          FirePreventPropertyEnum.no3I ||
                                      property ==
                                          FirePreventPropertyEnum.no3Ro ||
                                      property ==
                                          FirePreventPropertyEnum.no16I) &&
                                  (container
                                              .read(fireAlarmRequireProvider)
                                              .floor ==
                                          FireAlarmFloorEnum.basement.title ||
                                      container
                                          .read(fireAlarmRequireProvider)
                                          .isNoWindow) &&
                                  container
                                          .read(fireAlarmRequireProvider)
                                          .sqFloor >=
                                      100) {
                            expect(
                              container.read(fireAlarmRequireProvider).result,
                              RequireSentenceEnum.yes.title,
                              reason:
                                  '第10号 : $isCombust, $isLodge, $isNoWindow, $isOneStairs, $isSprinkler, $sq, $sqFloor, $floor, $usedType, ${property.title}',
                            );
                          } else if (
                              // 第11号
                              (container.read(fireAlarmRequireProvider).floor ==
                                          FireAlarmFloorEnum.basement.title ||
                                      container
                                              .read(fireAlarmRequireProvider)
                                              .floor ==
                                          FireAlarmFloorEnum.floor3to10.title ||
                                      container
                                          .read(fireAlarmRequireProvider)
                                          .isNoWindow) &&
                                  container
                                          .read(fireAlarmRequireProvider)
                                          .sqFloor >=
                                      300) {
                            expect(
                              container.read(fireAlarmRequireProvider).result,
                              RequireSentenceEnum.yes.title,
                              reason:
                                  '第11号 : $isCombust, $isLodge, $isNoWindow, $isOneStairs, $isSprinkler, $sq, $sqFloor, $floor, $usedType, ${property.title}',
                            );
                          } else if (
                              // 第12号
                              (container
                                              .read(fireAlarmRequireProvider)
                                              .usedType ==
                                          FireAlarmUsedTypeEnum
                                              .roadRoofTop.title &&
                                      container
                                              .read(fireAlarmRequireProvider)
                                              .sqFloor >=
                                          600) ||
                                  (container
                                              .read(fireAlarmRequireProvider)
                                              .usedType ==
                                          FireAlarmUsedTypeEnum.road.title &&
                                      container
                                              .read(fireAlarmRequireProvider)
                                              .sqFloor >=
                                          400)) {
                            expect(
                              container.read(fireAlarmRequireProvider).result,
                              RequireSentenceEnum.yes.title,
                              reason:
                                  '第12号 : $isCombust, $isLodge, $isNoWindow, $isOneStairs, $isSprinkler, $sq, $sqFloor, $floor, $usedType, ${property.title}',
                            );
                          } else if (
                              // 第13号
                              (container.read(fireAlarmRequireProvider).floor ==
                                          FireAlarmFloorEnum.basement.title ||
                                      container
                                              .read(fireAlarmRequireProvider)
                                              .floor ==
                                          FireAlarmFloorEnum.floor2.title ||
                                      container
                                              .read(fireAlarmRequireProvider)
                                              .floor ==
                                          FireAlarmFloorEnum.floor3to10.title ||
                                      container
                                              .read(fireAlarmRequireProvider)
                                              .floor ==
                                          FireAlarmFloorEnum
                                              .floorOver11.title) &&
                                  container
                                          .read(fireAlarmRequireProvider)
                                          .usedType ==
                                      FireAlarmUsedTypeEnum.parking.title &&
                                  container
                                          .read(fireAlarmRequireProvider)
                                          .sqFloor >=
                                      200) {
                            expect(
                              container.read(fireAlarmRequireProvider).result,
                              RequireSentenceEnum.yes.title,
                              reason:
                                  '第13号 : $isCombust, $isLodge, $isNoWindow, $isOneStairs, $isSprinkler, $sq, $sqFloor, $floor, $usedType, ${property.title}',
                            );
                          } else if (
                              // 第14号
                              container.read(fireAlarmRequireProvider).floor ==
                                  FireAlarmFloorEnum.floorOver11.title) {
                            expect(
                              container.read(fireAlarmRequireProvider).result,
                              RequireSentenceEnum.yes.title,
                              reason:
                                  '第14号 : $isCombust, $isLodge, $isNoWindow, $isOneStairs, $isSprinkler, $sq, $sqFloor, $floor, $usedType, ${property.title}',
                            );
                          } else if (
                              // 第15号
                              container
                                          .read(fireAlarmRequireProvider)
                                          .usedType ==
                                      FireAlarmUsedTypeEnum.commRoom.title &&
                                  container
                                          .read(fireAlarmRequireProvider)
                                          .sqFloor >=
                                      500) {
                            expect(
                              container.read(fireAlarmRequireProvider).result,
                              RequireSentenceEnum.yes.title,
                              reason:
                                  '第15号 : $isCombust, $isLodge, $isNoWindow, $isOneStairs, $isSprinkler, $sq, $sqFloor, $floor, $usedType, ${property.title}',
                            );
                          } else {
                            expect(
                              container.read(fireAlarmRequireProvider).result,
                              RequireSentenceEnum.no.title,
                              reason:
                                  'other : $isCombust, $isLodge, $isNoWindow, $isOneStairs, $isSprinkler, $sq, $sqFloor, $floor, $usedType, ${property.title}',
                            );
                          }
                        });
                      });
                    });
                  });
                });
              });
            });
          });
        });
      });
    });
  });
}
