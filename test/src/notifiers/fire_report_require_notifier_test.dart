import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/notifiers/fire_report_require_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('test test', () {
    test('Riverpod test', () {
      /// ProviderContainerの定義
      final container = ProviderContainer(
        overrides: [
          fireReportRequireProvider
              .overrideWithValue(FireReportRequireNotifier()),
        ],
      );

      /// 初期状態の確認
      expect(
        container.read(fireReportRequireProvider).sq,
        0,
      );
      expect(
        container.read(fireReportRequireProvider).isAlwaysReport,
        false,
      );

      /// 値を変更してみる
      container
          .read(fireReportRequireProvider.notifier)
          .updateIsAlwaysReport(true);
      expect(
        container.read(fireReportRequireProvider).isAlwaysReport,
        true,
      );
    });

    group('notifier test', () {
      /// 消防法施行令 第23条1項1号
      test('No23-1-1', () {
        /// ProviderContainerの定義
        final container = ProviderContainer(
          overrides: [
            fireReportRequireProvider
                .overrideWithValue(FireReportRequireNotifier()),
          ],
        );

        /// foreachで防火対象物のループを回す
        FirePreventPropertyEnum.values.toList().forEach((element) {
          // print(element);
          container
              .read(fireReportRequireProvider.notifier)
              .updateFirePreventProperty(element);
          container.read(fireReportRequireProvider.notifier).run();

          if (element == FirePreventPropertyEnum.no6I123 ||
              element == FirePreventPropertyEnum.no6Ro ||
              element == FirePreventPropertyEnum.no16No2 ||
              element == FirePreventPropertyEnum.no16No3) {
            expect(
              container.read(fireReportRequireProvider).result,
              RequireSentenceEnum.yes.title,
            );
          } else {
            expect(
              container.read(fireReportRequireProvider).result,
              RequireSentenceEnum.no.title,
            );
          }
        });
      });

      /// 消防法施行令 第23条1項2号
      test('No23-1-2', () {
        /// ProviderContainerの定義
        final container = ProviderContainer(
          overrides: [
            fireReportRequireProvider
                .overrideWithValue(FireReportRequireNotifier()),
          ],
        );

        /// 延べ面積の設定
        container.read(fireReportRequireProvider.notifier).updateSq('500');

        /// foreachで防火対象物のループを回す
        FirePreventPropertyEnum.values.toList().forEach((element) {
          // print(element);
          container
              .read(fireReportRequireProvider.notifier)
              .updateFirePreventProperty(element);
          container.read(fireReportRequireProvider.notifier).run();

          if (element == FirePreventPropertyEnum.no6I123 ||
              element == FirePreventPropertyEnum.no6Ro ||
              element == FirePreventPropertyEnum.no16No2 ||
              element == FirePreventPropertyEnum.no16No3) {
            expect(
              container.read(fireReportRequireProvider).result,
              RequireSentenceEnum.yes.title,
            );
          } else if (element == FirePreventPropertyEnum.no1I ||
              element == FirePreventPropertyEnum.no1Ro ||
              element == FirePreventPropertyEnum.no2I ||
              element == FirePreventPropertyEnum.no2Ro ||
              element == FirePreventPropertyEnum.no2Ha ||
              element == FirePreventPropertyEnum.no2Ni ||
              element == FirePreventPropertyEnum.no4 ||
              element == FirePreventPropertyEnum.no5I ||
              element == FirePreventPropertyEnum.no6I4 ||
              element == FirePreventPropertyEnum.no6Ha ||
              element == FirePreventPropertyEnum.no6Ni ||
              element == FirePreventPropertyEnum.no12I ||
              element == FirePreventPropertyEnum.no12Ro ||
              element == FirePreventPropertyEnum.no17 ||
              element == FirePreventPropertyEnum.no16No3) {
            expect(
              container.read(fireReportRequireProvider).result,
              RequireSentenceEnum.yes.title,
            );
          } else {
            expect(
              container.read(fireReportRequireProvider).result,
              RequireSentenceEnum.no.title,
            );
          }
        });
      });

      /// 消防法施行令 第23条1項3号
      test('No23-1-3', () {
        /// ProviderContainerの定義
        final container = ProviderContainer(
          overrides: [
            fireReportRequireProvider
                .overrideWithValue(FireReportRequireNotifier()),
          ],
        );

        /// 延べ面積の設定
        container.read(fireReportRequireProvider.notifier).updateSq('1000');

        /// foreachで防火対象物のループを回す
        FirePreventPropertyEnum.values.toList().forEach((element) {
          // print(element);
          container
              .read(fireReportRequireProvider.notifier)
              .updateFirePreventProperty(element);
          container.read(fireReportRequireProvider.notifier).run();

          if (element == FirePreventPropertyEnum.no6I123 ||
              element == FirePreventPropertyEnum.no6Ro ||
              element == FirePreventPropertyEnum.no16No2 ||
              element == FirePreventPropertyEnum.no16No3) {
            expect(
              container.read(fireReportRequireProvider).result,
              RequireSentenceEnum.yes.title,
            );
          } else if (element == FirePreventPropertyEnum.no1I ||
              element == FirePreventPropertyEnum.no1Ro ||
              element == FirePreventPropertyEnum.no2I ||
              element == FirePreventPropertyEnum.no2Ro ||
              element == FirePreventPropertyEnum.no2Ha ||
              element == FirePreventPropertyEnum.no2Ni ||
              element == FirePreventPropertyEnum.no4 ||
              element == FirePreventPropertyEnum.no5I ||
              element == FirePreventPropertyEnum.no6I4 ||
              element == FirePreventPropertyEnum.no6Ha ||
              element == FirePreventPropertyEnum.no6Ni ||
              element == FirePreventPropertyEnum.no12I ||
              element == FirePreventPropertyEnum.no12Ro ||
              element == FirePreventPropertyEnum.no17 ||
              element == FirePreventPropertyEnum.no16No3) {
            expect(
              container.read(fireReportRequireProvider).result,
              RequireSentenceEnum.yes.title,
            );
          } else if (element == FirePreventPropertyEnum.no3I ||
              element == FirePreventPropertyEnum.no3Ro ||
              element == FirePreventPropertyEnum.no5Ro ||
              element == FirePreventPropertyEnum.no7 ||
              element == FirePreventPropertyEnum.no8 ||
              element == FirePreventPropertyEnum.no9I ||
              element == FirePreventPropertyEnum.no9Ro ||
              element == FirePreventPropertyEnum.no10 ||
              element == FirePreventPropertyEnum.no11 ||
              element == FirePreventPropertyEnum.no13I ||
              element == FirePreventPropertyEnum.no13Ro ||
              element == FirePreventPropertyEnum.no14 ||
              element == FirePreventPropertyEnum.no15) {
            expect(
              container.read(fireReportRequireProvider).result,
              RequireSentenceEnum.yes.title,
            );
          } else {
            expect(
              container.read(fireReportRequireProvider).result,
              RequireSentenceEnum.no.title,
            );
          }
        });
      });

      /// 消防法施行令 第23条1項 但し書き
      test('No23-1-x', () {
        /// ProviderContainerの定義
        final container = ProviderContainer(
          overrides: [
            fireReportRequireProvider
                .overrideWithValue(FireReportRequireNotifier()),
          ],
        );

        /// 距離設定ON
        container
            .read(fireReportRequireProvider.notifier)
            .updateIsDistance(true);

        /// foreachで防火対象物のループを回す
        FirePreventPropertyEnum.values.toList().forEach((element) {
          // print(element);
          container
              .read(fireReportRequireProvider.notifier)
              .updateFirePreventProperty(element);
          container.read(fireReportRequireProvider.notifier).run();

          expect(
            container.read(fireReportRequireProvider).result,
            RequireSentenceEnum.no.title,
          );
        });
      });

      /// 消防法施行令 第23条3項
      test('No23-3', () {
        /// ProviderContainerの定義
        final container = ProviderContainer(
          overrides: [
            fireReportRequireProvider
                .overrideWithValue(FireReportRequireNotifier()),
          ],
        );

        /// 常時通報ONの設定
        container
            .read(fireReportRequireProvider.notifier)
            .updateIsAlwaysReport(true);
        container.read(fireReportRequireProvider.notifier).updateSq('500');

        /// foreachで防火対象物のループを回す
        FirePreventPropertyEnum.values.toList().forEach((element) {
          // print(element);
          container
              .read(fireReportRequireProvider.notifier)
              .updateFirePreventProperty(element);
          container.read(fireReportRequireProvider.notifier).run();

          if (element == FirePreventPropertyEnum.no5I ||
              element == FirePreventPropertyEnum.no6I123 ||
              element == FirePreventPropertyEnum.no6I4 ||
              element == FirePreventPropertyEnum.no6Ro ||
              element == FirePreventPropertyEnum.no6Ha) {
            expect(
              container.read(fireReportRequireProvider).result,
              RequireSentenceEnum.yes.title,
            );
          } else {
            expect(
              container.read(fireReportRequireProvider).result,
              RequireSentenceEnum.no.title,
            );
          }
        });
      });
    });
  });
}
