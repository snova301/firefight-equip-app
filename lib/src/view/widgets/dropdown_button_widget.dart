import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 防火対象物の選択widget
class DDButton extends ConsumerWidget {
  final String value; // 値
  final List<String> list; // ドロップダウンの候補リスト
  final Function(String newVal) func; // 実行関数
  final String? strHint; // ヒントの文字列

  const DDButton({
    Key? key,
    required this.value,
    required this.list,
    required this.func,
    this.strHint,
  }) : super(key: key);

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
        hint: strHint == null ? null : Text(strHint!),
        isExpanded: true,
        value: value,
        items: list.map<DropdownMenuItem<String>>(
          (String value) {
            return DropdownMenuItem<String>(
              alignment: AlignmentDirectional.centerStart,
              value: value,
              child: Text(
                value,
              ),
            );
          },
        ).toList(),
        onChanged: (String? value) {
          /// 値の変更
          func(value!);
        },
      ),
    );
  }
}
