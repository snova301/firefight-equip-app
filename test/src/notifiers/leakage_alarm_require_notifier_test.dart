import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/notifiers/leakage_alarm_require_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('test test', () {
    test('Riverpod test', () {
      /// ProviderContainerの定義
      final container = ProviderContainer(
        overrides: [
          leakageAlarmRequireProvider
              .overrideWithValue(LeakageAlarmRequireNotifier()),
        ],
      );

      /// 初期状態の確認
      expect(
        container.read(leakageAlarmRequireProvider).sq,
        0,
      );
      expect(
        container.read(leakageAlarmRequireProvider).isContractCurrent,
        false,
      );

      /// 値を変更してみる
      container
          .read(leakageAlarmRequireProvider.notifier)
          .updateIsContractCurrent(true);
      expect(
        container.read(leakageAlarmRequireProvider).isContractCurrent,
        true,
      );
    });
  });

  group('notifier test', () {
    /// 消防法施行令 第22条の1項の確認
    test('no21-1', () {
      /// ProviderContainerの定義
      final container = ProviderContainer(
        overrides: [
          leakageAlarmRequireProvider
              .overrideWithValue(LeakageAlarmRequireNotifier()),
        ],
      );

      /// 契約電流のループ
      [true, false].forEach((isContractCurrent) {
        container
            .read(leakageAlarmRequireProvider.notifier)
            .updateIsContractCurrent(isContractCurrent);

        /// 延べ面積のループ
        ['0', '150', '300', '500', '1000'].forEach((sq) {
          container.read(leakageAlarmRequireProvider.notifier).updateSq(sq);

          /// 床面積のループ
          ['0', '300'].forEach((sqFloor) {
            container
                .read(leakageAlarmRequireProvider.notifier)
                .updateSqFloor(sqFloor);

            /// 防火対象物のループ
            FirePreventPropertyEnum.values
                .toList()
                .forEach((firePreventProperty) {
              container
                  .read(leakageAlarmRequireProvider.notifier)
                  .updateFirePreventProperty(firePreventProperty);
              // print(firePreventProperty);

              /// 実行
              container.read(leakageAlarmRequireProvider.notifier).run();

              if (
                  // 第1号
                  firePreventProperty == FirePreventPropertyEnum.no17) {
                expect(
                  container.read(leakageAlarmRequireProvider).result,
                  RequireSentenceEnum.yes.title,
                );
              } else if (
                  // 第2号
                  (firePreventProperty == FirePreventPropertyEnum.no5I ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no5Ro ||
                          firePreventProperty == FirePreventPropertyEnum.no9I ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no9Ro) &&
                      container.read(leakageAlarmRequireProvider).sq >= 150) {
                expect(
                  container.read(leakageAlarmRequireProvider).result,
                  RequireSentenceEnum.yes.title,
                );
              } else if (
                  // 第3号
                  (firePreventProperty == FirePreventPropertyEnum.no1I ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no1Ro ||
                          firePreventProperty == FirePreventPropertyEnum.no2I ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no2Ro ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no2Ha ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no2Ni ||
                          firePreventProperty == FirePreventPropertyEnum.no3I ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no3Ro ||
                          firePreventProperty == FirePreventPropertyEnum.no4 ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no6I123 ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no6I4 ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no6Ro ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no6Ha ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no6Ni ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no12I ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no12Ro ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no16No2) &&
                      container.read(leakageAlarmRequireProvider).sq >= 300) {
                expect(
                  container.read(leakageAlarmRequireProvider).result,
                  RequireSentenceEnum.yes.title,
                );
              } else if (
                  // 第4号
                  (firePreventProperty == FirePreventPropertyEnum.no7 ||
                          firePreventProperty == FirePreventPropertyEnum.no8 ||
                          firePreventProperty == FirePreventPropertyEnum.no10 ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no11) &&
                      container.read(leakageAlarmRequireProvider).sq >= 500) {
                expect(
                  container.read(leakageAlarmRequireProvider).result,
                  RequireSentenceEnum.yes.title,
                );
              } else if (
                  // 第5号
                  (firePreventProperty == FirePreventPropertyEnum.no14 ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no15) &&
                      container.read(leakageAlarmRequireProvider).sq >= 1000) {
                expect(
                  container.read(leakageAlarmRequireProvider).result,
                  RequireSentenceEnum.yes.title,
                );
              } else if (
                  // 第6号
                  firePreventProperty == FirePreventPropertyEnum.no16I &&
                      container.read(leakageAlarmRequireProvider).sq >= 500 &&
                      container.read(leakageAlarmRequireProvider).sqFloor >=
                          300) {
                expect(
                  container.read(leakageAlarmRequireProvider).result,
                  RequireSentenceEnum.yes.title,
                );
              } else if (
                  // 第7号
                  (firePreventProperty == FirePreventPropertyEnum.no1I ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no1Ro ||
                          firePreventProperty == FirePreventPropertyEnum.no2I ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no2Ro ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no2Ha ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no2Ni ||
                          firePreventProperty == FirePreventPropertyEnum.no3I ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no3Ro ||
                          firePreventProperty == FirePreventPropertyEnum.no4 ||
                          firePreventProperty == FirePreventPropertyEnum.no5I ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no5Ro ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no6I123 ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no6I4 ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no6Ro ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no6Ha ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no6Ni ||
                          firePreventProperty == FirePreventPropertyEnum.no15 ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no16I ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no16Ro ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no16No2 ||
                          firePreventProperty ==
                              FirePreventPropertyEnum.no16No3) &&
                      container
                          .read(leakageAlarmRequireProvider)
                          .isContractCurrent) {
                expect(
                  container.read(leakageAlarmRequireProvider).result,
                  RequireSentenceEnum.yes.title,
                );
              } else {
                expect(
                  container.read(leakageAlarmRequireProvider).result,
                  RequireSentenceEnum.no.title,
                );
              }
            });
          });
        });
      });
    });
  });
}
