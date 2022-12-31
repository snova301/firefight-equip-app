import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/model/fire_ext_require_model.dart';
import 'package:firefight_equip/src/notifiers/fire_ext_require_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('test test', () {
    test('Riverpod test', () {
      /// ProviderContainerの定義
      final container = ProviderContainer(
        overrides: [
          /// riverpod v2.x
          fireExtRequireProvider.overrideWithProvider(StateNotifierProvider<
              FireExtRequireNotifier, FireExtRequireClass>((ref) {
            return FireExtRequireNotifier();
          })),

          /// riverpod v1.x
          // fireExtRequireProvider.overrideWithValue(FireExtRequireNotifier()),
        ],
      );

      /// 初期状態の確認
      expect(
        container.read(fireExtRequireProvider).sq,
        0,
      );
      expect(
        container.read(fireExtRequireProvider).isNoWindow,
        false,
      );

      /// 値を変更してみる
      container.read(fireExtRequireProvider.notifier).updateIsNoWindow(true);
      expect(
        container.read(fireExtRequireProvider).isNoWindow,
        true,
      );
    });
  });

  group('notifier test', () {
    /// 消防法施行令 第10条1項1号イの確認
    test('no10-1-1-I', () {
      /// ProviderContainerの定義
      final container = ProviderContainer(
        overrides: [
          /// riverpod v2.x
          fireExtRequireProvider.overrideWithProvider(StateNotifierProvider<
              FireExtRequireNotifier, FireExtRequireClass>((ref) {
            return FireExtRequireNotifier();
          })),

          /// riverpod v1.x
          // fireExtRequireProvider.overrideWithValue(FireExtRequireNotifier()),
        ],
      );

      /// foreachで防火対象物のループを回す
      FirePreventPropertyEnum.values.toList().forEach((element) {
        // print(element);
        container
            .read(fireExtRequireProvider.notifier)
            .updateFirePreventProperty(element);
        container.read(fireExtRequireProvider.notifier).run();

        if (element == FirePreventPropertyEnum.no1I ||
            element == FirePreventPropertyEnum.no2I ||
            element == FirePreventPropertyEnum.no2Ro ||
            element == FirePreventPropertyEnum.no2Ha ||
            element == FirePreventPropertyEnum.no2Ni ||
            element == FirePreventPropertyEnum.no6I123 ||
            element == FirePreventPropertyEnum.no6Ro ||
            element == FirePreventPropertyEnum.no16No2 ||
            element == FirePreventPropertyEnum.no16No3 ||
            element == FirePreventPropertyEnum.no17 ||
            element == FirePreventPropertyEnum.no20) {
          expect(
            container.read(fireExtRequireProvider).result,
            RequireSentenceEnum.yes.title,
          );
        } else {
          expect(
            container.read(fireExtRequireProvider).result,
            RequireSentenceEnum.no.title,
          );
        }
      });
    });

    /// 消防法施行令 第10条1項1号ロの確認
    test('no10-1-1-Ro', () {
      /// ProviderContainerの定義
      final container = ProviderContainer(
        overrides: [
          /// riverpod v2.x
          fireExtRequireProvider.overrideWithProvider(StateNotifierProvider<
              FireExtRequireNotifier, FireExtRequireClass>((ref) {
            return FireExtRequireNotifier();
          })),

          /// riverpod v1.x
          // fireExtRequireProvider.overrideWithValue(FireExtRequireNotifier()),
        ],
      );

      /// foreachで防火対象物のループを回す
      FirePreventPropertyEnum.values.toList().forEach((element) {
        // print(element);
        container
            .read(fireExtRequireProvider.notifier)
            .updateFirePreventProperty(element);
        container.read(fireExtRequireProvider.notifier).updateIsUsedFire(true);
        container.read(fireExtRequireProvider.notifier).run();
        if (element == FirePreventPropertyEnum.no1I ||
            element == FirePreventPropertyEnum.no2I ||
            element == FirePreventPropertyEnum.no2Ro ||
            element == FirePreventPropertyEnum.no2Ha ||
            element == FirePreventPropertyEnum.no2Ni ||
            element == FirePreventPropertyEnum.no6I123 ||
            element == FirePreventPropertyEnum.no6Ro ||
            element == FirePreventPropertyEnum.no16No2 ||
            element == FirePreventPropertyEnum.no16No3 ||
            element == FirePreventPropertyEnum.no17 ||
            element == FirePreventPropertyEnum.no20) {
          expect(
            container.read(fireExtRequireProvider).result,
            RequireSentenceEnum.yes.title,
          );
        } else if (element == FirePreventPropertyEnum.no3I ||
            element == FirePreventPropertyEnum.no3Ro) {
          expect(
            container.read(fireExtRequireProvider).result,
            RequireSentenceEnum.yes.title,
          );
        } else {
          expect(
            container.read(fireExtRequireProvider).result,
            RequireSentenceEnum.no.title,
          );
        }
      });
    });

    /// 消防法施行令 第10条1項2号の確認
    test('no10-1-2', () {
      /// ProviderContainerの定義
      final container = ProviderContainer(
        overrides: [
          /// riverpod v2.x
          fireExtRequireProvider.overrideWithProvider(StateNotifierProvider<
              FireExtRequireNotifier, FireExtRequireClass>((ref) {
            return FireExtRequireNotifier();
          })),

          /// riverpod v1.x
          // fireExtRequireProvider.overrideWithValue(FireExtRequireNotifier()),
        ],
      );

      /// 面積指定
      container.read(fireExtRequireProvider.notifier).updateSq('150');

      /// foreachで防火対象物のループを回す
      FirePreventPropertyEnum.values.toList().forEach((element) {
        // print(element);
        container
            .read(fireExtRequireProvider.notifier)
            .updateFirePreventProperty(element);
        container.read(fireExtRequireProvider.notifier).run();
        if (element == FirePreventPropertyEnum.no1I ||
            element == FirePreventPropertyEnum.no2I ||
            element == FirePreventPropertyEnum.no2Ro ||
            element == FirePreventPropertyEnum.no2Ha ||
            element == FirePreventPropertyEnum.no2Ni ||
            element == FirePreventPropertyEnum.no6I123 ||
            element == FirePreventPropertyEnum.no6Ro ||
            element == FirePreventPropertyEnum.no16No2 ||
            element == FirePreventPropertyEnum.no16No3 ||
            element == FirePreventPropertyEnum.no17 ||
            element == FirePreventPropertyEnum.no20) {
          expect(
            container.read(fireExtRequireProvider).result,
            RequireSentenceEnum.yes.title,
          );
        } else if (element == FirePreventPropertyEnum.no3I ||
            element == FirePreventPropertyEnum.no3Ro) {
          expect(
            container.read(fireExtRequireProvider).result,
            RequireSentenceEnum.yes.title,
          );
        } else if (element == FirePreventPropertyEnum.no1Ro ||
            element == FirePreventPropertyEnum.no4 ||
            element == FirePreventPropertyEnum.no5I ||
            element == FirePreventPropertyEnum.no5Ro ||
            element == FirePreventPropertyEnum.no6I4 ||
            element == FirePreventPropertyEnum.no6Ha ||
            element == FirePreventPropertyEnum.no6Ni ||
            element == FirePreventPropertyEnum.no9I ||
            element == FirePreventPropertyEnum.no9Ro ||
            element == FirePreventPropertyEnum.no12I ||
            element == FirePreventPropertyEnum.no12Ro ||
            element == FirePreventPropertyEnum.no13I ||
            element == FirePreventPropertyEnum.no13Ro ||
            element == FirePreventPropertyEnum.no14) {
          expect(
            container.read(fireExtRequireProvider).result,
            RequireSentenceEnum.yes.title,
          );
        } else {
          expect(
            container.read(fireExtRequireProvider).result,
            RequireSentenceEnum.no.title,
          );
        }
      });
    });

    /// 消防法施行令 第10条1項3号の確認
    test('no10-1-3', () {
      /// ProviderContainerの定義
      final container = ProviderContainer(
        overrides: [
          /// riverpod v2.x
          fireExtRequireProvider.overrideWithProvider(StateNotifierProvider<
              FireExtRequireNotifier, FireExtRequireClass>((ref) {
            return FireExtRequireNotifier();
          })),

          /// riverpod v1.x
          // fireExtRequireProvider.overrideWithValue(FireExtRequireNotifier()),
        ],
      );

      /// 面積指定
      container.read(fireExtRequireProvider.notifier).updateSq('300');

      /// foreachで防火対象物のループを回す
      FirePreventPropertyEnum.values.toList().forEach((element) {
        // print(element);
        container
            .read(fireExtRequireProvider.notifier)
            .updateFirePreventProperty(element);
        container.read(fireExtRequireProvider.notifier).run();
        if (element == FirePreventPropertyEnum.no1I ||
            element == FirePreventPropertyEnum.no2I ||
            element == FirePreventPropertyEnum.no2Ro ||
            element == FirePreventPropertyEnum.no2Ha ||
            element == FirePreventPropertyEnum.no2Ni ||
            element == FirePreventPropertyEnum.no6I123 ||
            element == FirePreventPropertyEnum.no6Ro ||
            element == FirePreventPropertyEnum.no16No2 ||
            element == FirePreventPropertyEnum.no16No3 ||
            element == FirePreventPropertyEnum.no17 ||
            element == FirePreventPropertyEnum.no20) {
          expect(
            container.read(fireExtRequireProvider).result,
            RequireSentenceEnum.yes.title,
          );
        } else if (element == FirePreventPropertyEnum.no3I ||
            element == FirePreventPropertyEnum.no3Ro) {
          expect(
            container.read(fireExtRequireProvider).result,
            RequireSentenceEnum.yes.title,
          );
        } else if (element == FirePreventPropertyEnum.no1Ro ||
            element == FirePreventPropertyEnum.no4 ||
            element == FirePreventPropertyEnum.no5I ||
            element == FirePreventPropertyEnum.no5Ro ||
            element == FirePreventPropertyEnum.no6I4 ||
            element == FirePreventPropertyEnum.no6Ha ||
            element == FirePreventPropertyEnum.no6Ni ||
            element == FirePreventPropertyEnum.no9I ||
            element == FirePreventPropertyEnum.no9Ro ||
            element == FirePreventPropertyEnum.no12I ||
            element == FirePreventPropertyEnum.no12Ro ||
            element == FirePreventPropertyEnum.no13I ||
            element == FirePreventPropertyEnum.no13Ro ||
            element == FirePreventPropertyEnum.no14) {
          expect(
            container.read(fireExtRequireProvider).result,
            RequireSentenceEnum.yes.title,
          );
        } else if (element == FirePreventPropertyEnum.no7 ||
            element == FirePreventPropertyEnum.no8 ||
            element == FirePreventPropertyEnum.no10 ||
            element == FirePreventPropertyEnum.no11 ||
            element == FirePreventPropertyEnum.no15 ||
            element == FirePreventPropertyEnum.no14) {
          expect(
            container.read(fireExtRequireProvider).result,
            RequireSentenceEnum.yes.title,
          );
        } else {
          expect(
            container.read(fireExtRequireProvider).result,
            RequireSentenceEnum.no.title,
          );
        }
      });
    });

    /// 消防法施行令 第10条1項4号の確認
    test('no10-1-4', () {
      /// ProviderContainerの定義
      final container = ProviderContainer(
        overrides: [
          /// riverpod v2.x
          fireExtRequireProvider.overrideWithProvider(StateNotifierProvider<
              FireExtRequireNotifier, FireExtRequireClass>((ref) {
            return FireExtRequireNotifier();
          })),

          /// riverpod v1.x
          // fireExtRequireProvider.overrideWithValue(FireExtRequireNotifier()),
        ],
      );

      /// 面積指定
      container.read(fireExtRequireProvider.notifier).updateIsCombust(true);

      /// foreachで防火対象物のループを回す
      FirePreventPropertyEnum.values.toList().forEach((element) {
        // print(element);
        container
            .read(fireExtRequireProvider.notifier)
            .updateFirePreventProperty(element);
        container.read(fireExtRequireProvider.notifier).run();
        expect(
          container.read(fireExtRequireProvider).result,
          RequireSentenceEnum.yes.title,
        );
      });
    });

    /// 消防法施行令 第10条1項5号の確認
    test('no10-1-5', () {
      /// ProviderContainerの定義
      final container = ProviderContainer(
        overrides: [
          /// riverpod v2.x
          fireExtRequireProvider.overrideWithProvider(StateNotifierProvider<
              FireExtRequireNotifier, FireExtRequireClass>((ref) {
            return FireExtRequireNotifier();
          })),

          /// riverpod v1.x
          // fireExtRequireProvider.overrideWithValue(FireExtRequireNotifier()),
        ],
      );

      /// 無窓階判定
      container.read(fireExtRequireProvider.notifier).updateIsNoWindow(true);
      container.read(fireExtRequireProvider.notifier).updateSqFloor('50');

      /// foreachで防火対象物のループを回す
      FirePreventPropertyEnum.values.toList().forEach((element) {
        // print(element);
        container
            .read(fireExtRequireProvider.notifier)
            .updateFirePreventProperty(element);
        container.read(fireExtRequireProvider.notifier).run();

        expect(
          container.read(fireExtRequireProvider).result,
          RequireSentenceEnum.yes.title,
        );
      });
    });
  });
}
