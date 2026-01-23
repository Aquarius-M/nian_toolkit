import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nian_toolkit/nian_toolkit.dart';
import 'package:nian_toolkit/page/dio_plug/src/instances.dart';

import 'widgets/response_card.dart';

class DioPage extends StatefulWidget {
  const DioPage({super.key});

  @override
  State<DioPage> createState() => _DioPageState();
}

class _DioPageState extends State<DioPage> {
  @override
  void initState() {
    super.initState();
    // Bind listener to refresh requests.
    DioInspectorInstance.httpContainer.addListener(_listener);
  }

  @override
  void dispose() {
    DioInspectorInstance.httpContainer
      ..removeListener(_listener) // First, remove refresh listener.
      ..resetPaging(); // Then reset the paging field.
    super.dispose();
  }

  void _listener() {
    Future.microtask(() {
      if (mounted &&
          !context.debugDoingBuild &&
          context.owner?.debugBuilding != true) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          constraints: BoxConstraints.tightFor(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height * 0.85,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              // Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  children: <Widget>[
                    Text(
                      '网络请求',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: DioInspectorInstance.httpContainer.clearRequests,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.redAccent.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.redAccent.withValues(alpha: 0.5),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.clear_all_outlined,
                              color: Colors.redAccent,
                            ),
                            Text(
                              '清空',
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ColoredBox(
                  color: Theme.of(context).canvasColor,
                  child: _itemList(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemList(BuildContext context) {
    final List<Response<dynamic>> requests =
        DioInspectorInstance.httpContainer.pagedRequests;
    final int length = requests.length;
    if (length > 0) {
      return CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate((_, int index) {
              final Response<dynamic> r = requests[index];
              if (index == length - 2) {
                DioInspectorInstance.httpContainer.loadNextPage();
              }
              return ResponseCard(
                key: ValueKey<int>(r.startTimeMilliseconds),
                response: r,
              );
            }, childCount: length),
          ),
        ],
      );
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.network_check_rounded,
            size: 80,
            color: Theme.of(context).disabledColor.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          Text(
            '暂无网络请求',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).disabledColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
