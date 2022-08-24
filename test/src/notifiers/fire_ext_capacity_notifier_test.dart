import 'package:firefight_equip/src/notifiers/fire_ext_capacity_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('test test', () {
    test('Riverpod test', () {
      /// ProviderContainerの定義
      final container = ProviderContainer(
        overrides: [
          fireExtCapacityProvider.overrideWithValue(FireExtCapacityNotifier()),
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
