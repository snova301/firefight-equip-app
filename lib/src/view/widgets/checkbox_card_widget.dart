import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// チェックボックスを実現
class CheckBoxCard extends ConsumerWidget {
  final String title; // 入力文字列
  final bool isChecked; // チェックボックスの状態
  final Function(bool newBool) func;

  const CheckBoxCard({
    Key? key,
    required this.title,
    required this.isChecked,
    required this.func,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: CheckboxListTile(
        value: isChecked,
        onChanged: (bool? newBool) {
          func(newBool!);
        },
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 13,
          ),
          overflow: TextOverflow.clip,
        ),
      ),
    );
  }
}
