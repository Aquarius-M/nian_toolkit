import 'dart:io';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../../../app_theme/theme.dart';

class LogListPage extends StatefulWidget {
  const LogListPage({super.key});

  @override
  State<LogListPage> createState() => _LogListPageState();
}

class _LogListPageState extends State<LogListPage> {
  ScrollController scrollController = ScrollController();
  String logStr = '';

  TextEditingController? textEditingController;
  FocusNode focusNode = FocusNode();

  /// 文件流
  static IOSink? _sink;
  @override
  void initState() {
    super.initState();
    _loadLog();
  }

  @override
  void dispose() {
    scrollController.dispose();
    textEditingController?.dispose();
    super.dispose();
  }

  Future _loadLog({String? path}) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String outPath = '${appDocDir.path}/log';
    File file = File(
      path != null
          ? '$outPath/$path'
          : '$outPath/.${DateTime.now().toString().replaceAll(RegExp(r'(?<=\d\d-\d\d-\d\d)[\S|\s]+'), '')}.log',
    );
    String fileName = file.path.split('/').last;
    if (!await file.exists()) {
      await file.create(recursive: true);
    }
    var content = file.readAsStringSync();
    setState(() {
      logStr = content;
    });
    textEditingController = TextEditingController(text: fileName);
  }

  Future _clean() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String outPath = '${appDocDir.path}/log';
    File file = File(
      '$outPath/.${DateTime.now().toString().replaceAll(RegExp(r'(?<=\d\d-\d\d-\d\d)[\S|\s]+'), '')}.log',
    );
    if (await file.exists()) {
      _sink = file.openWrite(mode: FileMode.write);
      _sink?.writeAll(utf8.encode(''));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('日志', style: context.f18BoldTextPrimary),
        actions: [
          IconButton(
            onPressed: () async {
              if (scrollController.offset ==
                  scrollController.position.maxScrollExtent) {
                scrollController.jumpTo(0);
                setState(() {});
              } else {
                scrollController.jumpTo(
                  scrollController.position.maxScrollExtent,
                );
                setState(() {});
              }
            },
            icon: const Icon(Icons.unfold_more_rounded),
          ),
          IconButton(
            onPressed: () async {
              _loadLog();
            },
            icon: const Icon(Icons.sync),
          ),
          IconButton(
            onPressed: () async {
              await _clean();
              // 确保在清除后重新加载日志
              await _loadLog();
            },
            icon: const Icon(Icons.cleaning_services_outlined),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              height: 32,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: context.appColor.backgroundInput,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: textEditingController,
                focusNode: focusNode,
                textInputAction: TextInputAction.done,
                textAlign: TextAlign.center,
                style: context.f16MediumTextPrimary,
                decoration: InputDecoration(
                  hintStyle: context.f16MediumTextDisable,
                  hintText: '日志名称',
                  fillColor: Colors.transparent,
                  filled: true,
                  isDense: true,
                  counterText: '',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
                onSubmitted: (value) {
                  if (value != "") {
                    _loadLog(path: value);
                  } else {
                    _loadLog();
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              child: Text(
                logStr,
                softWrap: true,
                style: context.f13MediumTextPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
