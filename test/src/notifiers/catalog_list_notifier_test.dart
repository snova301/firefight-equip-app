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
}
