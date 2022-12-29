import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ドロップダウンリスト選択widget
class DDButton extends ConsumerWidget {
  final String value; // 値
  final List<String> list; // ドロップダウンの候補リスト
  final Function(String newVal) func; // 実行関数
  final String strTitle; // タイトルの文字列
  final String? strHint; // ヒントの文字列

  const DDButton({
    Key? key,
    required this.value,
    required this.list,
    required this.func,
    required this.strTitle,
    this.strHint,
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
            child: Text(
              '$strTitle' 'を選択してください',
            ),
          ),

          /// ドロップダウン
          DropdownButtonFormField(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0), //角丸の設定
                ),
              ),
            ),
            // alignment: AlignmentDirectional.center,
            hint: Text(strHint ?? ''),
            isExpanded: true,
            value: value,
            items: list.map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  alignment: AlignmentDirectional.centerStart,
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
            onChanged: (String? value) {
              /// 値の変更
              func(value!);
            },
          ),
        ],
      ),
    );
  }
}
