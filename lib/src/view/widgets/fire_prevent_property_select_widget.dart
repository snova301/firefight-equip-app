import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/view/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 防火対象物の選択widget
class FirePreventPropertySelectDD extends ConsumerWidget {
  const FirePreventPropertySelectDD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: DropdownButtonFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0), //角丸の設定
            ),
          ),
        ),
        // alignment: AlignmentDirectional.center,
        hint: const Text('防火対象物を選択してください'),
        isExpanded: true,
        value: ref.watch(testProvider),
        items: FirePreventPropertyEnum.values.map<DropdownMenuItem<String>>(
          (FirePreventPropertyEnum value) {
            return DropdownMenuItem<String>(
              alignment: AlignmentDirectional.centerStart,
              value: value.title,
              child: Text(
                value.title,
              ),
            );
          },
        ).toList(),
        onChanged: (String? value) {
          /// 値の変更
          ref.read(testProvider.state).state = value!;
        },
      ),
    );
  }
}
