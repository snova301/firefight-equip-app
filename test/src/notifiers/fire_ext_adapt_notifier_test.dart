import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/model/fire_ext_adapt_model.dart';
import 'package:firefight_equip/src/notifiers/fire_ext_adapt_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('test test', () {
    test('Riverpod test', () {
      /// ProviderContainerの定義
      final container = ProviderContainer(
        overrides: [
          /// riverpod v2.x
          fireExtAdaptProvider.overrideWithProvider(
              StateNotifierProvider<FireExtAdaptNotifier, FireExtAdaptClass>(
                  (ref) {
            return FireExtAdaptNotifier();
          })),

          /// riverpod v1.x
          // fireExtAdaptProvider.overrideWithValue(FireExtAdaptNotifier()),
        ],
      );

      /// 初期状態の確認
      expect(
        container.read(fireExtAdaptProvider).fireExtAdapt,
        FireExtAdaptEnum.none,
      );

      /// 値を変更してみる
      container
          .read(fireExtAdaptProvider.notifier)
          .updateFireExt(FireExtAdaptEnum.chemForm);
      expect(
        container.read(fireExtAdaptProvider).fireExtAdapt,
        FireExtAdaptEnum.chemForm,
      );
    });
  });

  group('notifier test', () {
    /// 各消火器の適応火災
    test('fire ext adapt', () {
      /// ProviderContainerの定義
      final container = ProviderContainer(
        overrides: [
          /// riverpod v2.x
          fireExtAdaptProvider.overrideWithProvider(
              StateNotifierProvider<FireExtAdaptNotifier, FireExtAdaptClass>(
                  (ref) {
            return FireExtAdaptNotifier();
          })),

          /// riverpod v1.x
          // fireExtAdaptProvider.overrideWithValue(FireExtAdaptNotifier()),
        ],
      );

      /// 消火器の種類のループ
      for (var fireExtAdapt in FireExtAdaptEnum.values) {
        print(fireExtAdapt);

        /// 値の変更
        container
            .read(fireExtAdaptProvider.notifier)
            .updateFireExt(fireExtAdapt);

        /// 各消火器ごとの分岐
        /// 何も選択されていないとき
        if (fireExtAdapt == FireExtAdaptEnum.none) {
          // A火災
          expect(container.read(fireExtAdaptProvider).resultA, '-');
          // B火災
          expect(container.read(fireExtAdaptProvider).resultB, '-');
          // C火災
          expect(container.read(fireExtAdaptProvider).resultC, '-');
        }

        /// 水消火器(棒状)
        else if (fireExtAdapt == FireExtAdaptEnum.waterRod) {
          // A火災
          expect(container.read(fireExtAdaptProvider).resultA, '○');
          // B火災
          expect(container.read(fireExtAdaptProvider).resultB, '-');
          // C火災
          expect(container.read(fireExtAdaptProvider).resultC, '-');
        }

        /// 水消火器(霧状)
        else if (fireExtAdapt == FireExtAdaptEnum.waterFog) {
          // A火災
          expect(container.read(fireExtAdaptProvider).resultA, '○');
          // B火災
          expect(container.read(fireExtAdaptProvider).resultB, '-');
          // C火災
          expect(container.read(fireExtAdaptProvider).resultC, '○');
        }

        /// 強化液消火器(棒状)
        else if (fireExtAdapt == FireExtAdaptEnum.loadedStreamRod) {
          // A火災
          expect(container.read(fireExtAdaptProvider).resultA, '○');
          // B火災
          expect(container.read(fireExtAdaptProvider).resultB, '○');
          // C火災
          expect(container.read(fireExtAdaptProvider).resultC, '-');
        }

        /// 強化液消火器(霧状)
        else if (fireExtAdapt == FireExtAdaptEnum.loadedStreamFog) {
          // A火災
          expect(container.read(fireExtAdaptProvider).resultA, '○');
          // B火災
          expect(container.read(fireExtAdaptProvider).resultB, '○');
          // C火災
          expect(container.read(fireExtAdaptProvider).resultC, '○');
        }

        /// 機械泡消火器
        else if (fireExtAdapt == FireExtAdaptEnum.form) {
          // A火災
          expect(container.read(fireExtAdaptProvider).resultA, '○');
          // B火災
          expect(container.read(fireExtAdaptProvider).resultB, '○');
          // C火災
          expect(container.read(fireExtAdaptProvider).resultC, '-');
        }

        /// 化学泡消火器
        else if (fireExtAdapt == FireExtAdaptEnum.chemForm) {
          // A火災
          expect(container.read(fireExtAdaptProvider).resultA, '○');
          // B火災
          expect(container.read(fireExtAdaptProvider).resultB, '○');
          // C火災
          expect(container.read(fireExtAdaptProvider).resultC, '-');
        }

        /// 二酸化炭素消火器
        else if (fireExtAdapt == FireExtAdaptEnum.co2) {
          // A火災
          expect(container.read(fireExtAdaptProvider).resultA, '-');
          // B火災
          expect(container.read(fireExtAdaptProvider).resultB, '○');
          // C火災
          expect(container.read(fireExtAdaptProvider).resultC, '○');
        }

        /// ハロゲン化物消火器
        else if (fireExtAdapt == FireExtAdaptEnum.halide) {
          // A火災
          expect(container.read(fireExtAdaptProvider).resultA, '△');
          // B火災
          expect(container.read(fireExtAdaptProvider).resultB, '○');
          // C火災
          expect(container.read(fireExtAdaptProvider).resultC, '○');
        }

        /// リン酸塩類粉末消火器
        else if (fireExtAdapt == FireExtAdaptEnum.powderABC) {
          // A火災
          expect(container.read(fireExtAdaptProvider).resultA, '○');
          // B火災
          expect(container.read(fireExtAdaptProvider).resultB, '○');
          // C火災
          expect(container.read(fireExtAdaptProvider).resultC, '○');
        }

        /// 炭酸水素塩類粉末消火器
        else if (fireExtAdapt == FireExtAdaptEnum.powderABC) {
          // A火災
          expect(container.read(fireExtAdaptProvider).resultA, '-');
          // B火災
          expect(container.read(fireExtAdaptProvider).resultB, '○');
          // C火災
          expect(container.read(fireExtAdaptProvider).resultC, '○');
        }
      }
    });
  });
}
