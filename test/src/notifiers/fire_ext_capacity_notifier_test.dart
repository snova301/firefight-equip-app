import 'package:firefight_equip/src/model/fire_ext_capacity_model.dart';
import 'package:firefight_equip/src/notifiers/fire_ext_capacity_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('test test', () {
    test('Riverpod test', () {
      /// ProviderContainerの定義
      final container = ProviderContainer(
        overrides: [
          /// riverpod v2.x
          fireExtCapacityProvider.overrideWithProvider(StateNotifierProvider<
              FireExtCapacityNotifier, FireExtCapacityClass>((ref) {
            return FireExtCapacityNotifier();
          })),

          /// riverpod v1.x
          // fireExtCapacityProvider.overrideWithValue(FireExtCapacityNotifier()),
        ],
      );

      /// 初期状態の確認
      expect(
        container.read(fireExtCapacityProvider).sq,
        0,
      );
      expect(
        container.read(fireExtCapacityProvider).isCombust,
        false,
      );

      /// 値を変更してみる
      container.read(fireExtCapacityProvider.notifier).updateIsCombust(true);
      expect(
        container.read(fireExtCapacityProvider).isCombust,
        true,
      );
    });
  });
}
