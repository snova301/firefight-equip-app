import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 結果表示用のwidget
class OutputText extends ConsumerWidget {
  final String? preface; // 序文
  final double? prefaceFontSize; // 序文のフォントサイズ
  final Color? prefaceFontColor; // 序文のフォントサイズ
  final String? result; // 出力結果

  const OutputText({
    Key? key,
    this.preface,
    this.prefaceFontSize,
    this.prefaceFontColor,
    this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 序文
          preface == null
              ? Container()
              : Flexible(
                  child: Text(
                    preface!,
                    style: TextStyle(
                      fontSize: prefaceFontSize ?? 14,
                      color: prefaceFontColor ?? Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.visible,
                  ),
                ),
          // 本文
          result == null
              ? Container()
              : Text(
                  result!,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                  // overflow: TextOverflow.visible,
                ),
        ],
      ),
    );
  }
}
