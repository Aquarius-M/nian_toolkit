import 'package:flutter/material.dart';

import '../../../app_theme/theme.dart';
import 'fps_info.dart';
import 'collection_util.dart';
import 'fps_chart.dart';

class FpsPage extends StatefulWidget {
  const FpsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return FpsPageState();
  }
}

class FpsPageState extends State<FpsPage> {
  @override
  Widget build(BuildContext context) {
    List<FpsInfo> list = CommonStorage.instance.getAll();
    Widget info(String text) {
      return Text(text, style: context.f12MediumTextPrimary);
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 30,
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                info('近${CommonStorage.instance.items.length}帧'),
                info('最大耗时:${CommonStorage.instance.max.toStringAsFixed(1)}'),
                info(
                  '平均耗时:${CommonStorage.instance.getAvg().toStringAsFixed(1)}',
                ),
                info(
                  '总耗时:${CommonStorage.instance.totalNum.toStringAsFixed(1)}',
                ),
              ],
            ),
          ),
          Container(
            height: 30,
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Builder(
              builder: (context) {
                int A = 0;
                int B = 0;
                int C = 0;
                int D = 0;
                for (int i = 0; i < list.length; i++) {
                  int value = list[i].getValue().toInt();
                  if (value > 66) {
                    D++;
                  } else if (value > 33) {
                    C++;
                  } else if (value > 18) {
                    B++;
                  } else {
                    A++;
                  }
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    info('流畅：$A'),
                    info('良好：$B'),
                    info('轻微卡顿：$C'),
                    info('卡顿：$D'),
                  ],
                );
              },
            ),
          ),
          Divider(
            height: 1,
            color: context.appColor.borderInput,
            indent: 16,
            endIndent: 16,
          ),
          FpsBarChart(data: list),
        ],
      ),
    );
  }
}
