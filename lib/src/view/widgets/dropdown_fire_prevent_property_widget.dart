import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 防火対象物の選択widget
class FirePreventPropertySelectDD extends ConsumerWidget {
  final String value; // 値
  final Function(FirePreventPropertyEnum newVal) func; // 実行関数

  const FirePreventPropertySelectDD({
    Key? key,
    required this.value,
    required this.func,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Column(
        children: [
          /// テキスト
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            alignment: Alignment.centerLeft,
            child: const Text(
              '防火対象物を選択してください',
            ),
          ),

          /// ドロップダウン
          DropdownButtonFormField(
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
            value: value,
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
              /// 値の検索とFirePreventPropertyEnumへの変換
              var newVal = FirePreventPropertyEnum.values
                  .firstWhere((element) => element.title == value!);

              /// 値の変更
              func(newVal);
            },
          ),
        ],
      ),
    );
  }
}
