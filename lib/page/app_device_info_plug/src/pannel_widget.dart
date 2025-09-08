import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PannelWidget extends StatelessWidget {
  String title;
  String? text;
  Widget? child;
  VoidCallback? onTap;
  VoidCallback? onLongTap;

  PannelWidget(
    this.title, {
    super.key,
    this.text,
    this.child,
    this.onTap,
    this.onLongTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      onLongPress: onLongTap ?? () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Text(
                '$title${text != null ? ':' : ''}',
                strutStyle: const StrutStyle(
                  forceStrutHeight: true,
                  // height: 1.5,
                ),
              ),
            ),
            Expanded(
              child:
                  child ??
                  Row(
                    children: [
                      Expanded(
                        child: text != null
                            ? RichText(
                                strutStyle: const StrutStyle(
                                  forceStrutHeight: true,
                                ),
                                text: TextSpan(
                                  text: text,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              )
                            : const SizedBox(),
                      ),
                      const Icon(Icons.keyboard_arrow_right_rounded),
                    ],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
