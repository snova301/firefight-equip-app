import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// テキスト入力用のwidget
class InputTextCard extends ConsumerWidget {
  final String title; // タイトル
  final String? unit; // 単位
  final String message; // tooltip用メッセージ
  final TextEditingController controller; // TextEditingController

  const InputTextCard({
    Key? key,
    required this.title,
    this.unit,
    required this.message,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Card(
        elevation: 2,

        /// cardの中身はcolumnで実現
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// タイトル部分
            Container(
              margin: const EdgeInsets.fromLTRB(8, 8, 0, 0),
              child: Tooltip(
                message: message,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
              ),
            ),

            /// 表示
            Row(
              children: [
                /// テキスト入力部分
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                    child: TextField(
                      controller: controller,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                        LengthLimitingTextInputFormatter(6),
                      ],
                    ),
                  ),
                ),

                /// 単位部分
                unit != null
                    ? Container(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Text(
                          unit!,
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
