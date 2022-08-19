import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 結果表示用のwidget
class OutputText extends ConsumerWidget {
  final String? preface; // 序文
  final String result; // 出力結果
  final double? resultFontSize; // 結果のフォントサイズ
  final Color? resultFontColor; // 結果のフォントサイズ

  const OutputText({
    Key? key,
    this.preface,
    this.resultFontSize,
    this.resultFontColor,
    required this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 序文
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: Text(
              preface ?? '',
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.clip,
            ),
          ),
          // 本文
          Text(
            result,
            style: TextStyle(
              fontSize: resultFontSize ?? 18,
              color: resultFontColor ?? Colors.red,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.clip,
          ),
        ],
      ),
    );
  }
}
