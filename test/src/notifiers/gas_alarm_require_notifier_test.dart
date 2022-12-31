import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/model/gas_alarm_require_model.dart';
import 'package:firefight_equip/src/notifiers/gas_alarm_require_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('test test', () {
    test('Riverpod test', () {
      /// ProviderContainerの定義
      final container = ProviderContainer(
        overrides: [
          /// riverpod v2.x
          gasAlarmRequireProvider.overrideWithProvider(StateNotifierProvider<
              GasAlarmRequireNotifier, GasAlarmRequireClass>((ref) {
            return GasAlarmRequireNotifier();
          })),

          /// riverpod v1.x
          // gasAlarmRequireProvider.overrideWithValue(GasAlarmRequireNotifier()),
        ],
      );

      /// 初期状態の確認
      expect(
        container.read(gasAlarmRequireProvider).sq,
        0,
      );
      expect(
        container.read(gasAlarmRequireProvider).isHotSpring,
        false,
      );

      /// 値を変更してみる
      container.read(gasAlarmRequireProvider.notifier).updateIsHotSpring(true);
      expect(
        container.read(gasAlarmRequireProvider).isHotSpring,
        true,
      );
    });
  });

  group('notifier test', () {
    /// 消防法施行令 第21条の2の1項の確認
    test('no21-1', () {
      /// ProviderContainerの定義
      final container = ProviderContainer(
        overrides: [
          /// riverpod v2.x
          gasAlarmRequireProvider.overrideWithProvider(StateNotifierProvider<
              GasAlarmRequireNotifier, GasAlarmRequireClass>((ref) {
            return GasAlarmRequireNotifier();
          })),

          /// riverpod v1.x
          // gasAlarmRequireProvider.overrideWithValue(GasAlarmRequireNotifier()),
        ],
      );

      /// 温泉のループ
      [true, false].forEach((isHotSpring) {
        container
            .read(gasAlarmRequireProvider.notifier)
            .updateIsHotSpring(isHotSpring);

        /// 地階のループ
        [true, false].forEach((isUnderGround) {
          container
              .read(gasAlarmRequireProvider.notifier)
              .updateIsUnderGround(isUnderGround);

          /// 延べ面積のループ
          ['0', '500', '1000'].forEach((sq) {
            container.read(gasAlarmRequireProvider.notifier).updateSq(sq);

            /// 床面積のループ
            ['0', '500', '1000'].forEach((sqFloor) {
              container
                  .read(gasAlarmRequireProvider.notifier)
                  .updateSqFloor(sqFloor);

              /// 防火対象物のループ
              FirePreventPropertyEnum.values
                  .toList()
                  .forEach((firePreventProperty) {
                print(firePreventProperty);

                /// データのアップデート
                container
                    .read(gasAlarmRequireProvider.notifier)
                    .updateFirePreventProperty(firePreventProperty);

                container.read(gasAlarmRequireProvider.notifier).run();

                if (
                    // 第1号
                    firePreventProperty == FirePreventPropertyEnum.no16No2 &&
                        container.read(gasAlarmRequireProvider).sq >= 1000) {
                  expect(
                    container.read(gasAlarmRequireProvider).result,
                    RequireSentenceEnum.yes.title,
                  );
                } else if (
                    // 第2号
                    firePreventProperty == FirePreventPropertyEnum.no16No3 &&
                        container.read(gasAlarmRequireProvider).sq >= 1000 &&
                        container.read(gasAlarmRequireProvider).sqFloor >=
                            500) {
                  expect(
                    container.read(gasAlarmRequireProvider).result,
                    RequireSentenceEnum.yes.title,
                  );
                } else if (
                    // 第3号
                    container.read(gasAlarmRequireProvider).isHotSpring) {
                  expect(
                    container.read(gasAlarmRequireProvider).result,
                    RequireSentenceEnum.yes.title,
                  );
                } else if (
                    // 第4号
                    firePreventProperty.isSpecific &&
                        container.read(gasAlarmRequireProvider).isUnderGround &&
                        container.read(gasAlarmRequireProvider).sqFloor >=
                            1000) {
                  expect(
                    container.read(gasAlarmRequireProvider).result,
                    RequireSentenceEnum.yes.title,
                  );
                } else if (
                    // 第5号
                    firePreventProperty == FirePreventPropertyEnum.no16I &&
                        container.read(gasAlarmRequireProvider).isUnderGround &&
                        container.read(gasAlarmRequireProvider).sq >= 1000 &&
                        container.read(gasAlarmRequireProvider).sqFloor >=
                            500) {
                  expect(
                    container.read(gasAlarmRequireProvider).result,
                    RequireSentenceEnum.yes.title,
                  );
                } else {
                  expect(
                    container.read(gasAlarmRequireProvider).result,
                    RequireSentenceEnum.no.title,
                  );
                }
              });
            });
          });
        });
      });
    });
  });
}
