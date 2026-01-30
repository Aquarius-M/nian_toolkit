import 'package:flutter/material.dart';

import 'package:nian_toolkit/toolkit.dart';

import '../../../app_theme/theme.dart';

// ignore: must_be_immutable
class PannelWidget extends StatelessWidget {
  String title;
  String? text;
  Widget? child;

  PannelWidget(this.title, {super.key, this.text, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: () {
          KitUtils.copy(context, text, toastText: '复制成功');
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: context.appColor.backgroundInput,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Text(
                  '$title${text != null ? ':' : ''}',
                  style: context.f16MediumTextPrimary,
                ),
              ),
              Expanded(
                child: text != null
                    ? Text(
                        text!,
                        style: context.f16MediumTextPrimary,
                        textAlign: TextAlign.right,
                      )
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
