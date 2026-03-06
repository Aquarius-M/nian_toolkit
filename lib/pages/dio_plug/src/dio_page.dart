import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:nian_toolkit/toolkit.dart';
import 'package:nian_toolkit/pages/dio_plug/src/instances.dart';

import '../../../app_theme/theme.dart';
import 'widgets/response_card.dart';

class DioPage extends StatefulWidget {
  const DioPage({super.key});

  @override
  State<DioPage> createState() => _DioPageState();
}

class _DioPageState extends State<DioPage> {
  bool showSearchBar = false;
  late final TextEditingController _searchController;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    // Bind listener to refresh requests.
    DioInspectorInstance.httpContainer.addListener(_listener);
  }

  @override
  void dispose() {
    DioInspectorInstance.httpContainer
      ..removeListener(_listener) // First, remove refresh listener.
      ..resetPaging(); // Then reset the paging field.
    _searchController.dispose();
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
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        constraints: BoxConstraints.tightFor(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.75,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          color: context.appColor.backgroundPrimary,
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
                  Text('网络请求', style: context.f20BoldTextPrimary),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      setState(() {
                        showSearchBar = !showSearchBar;
                        if (showSearchBar == false) {
                          _searchController.clear();
                          _query = '';
                        }
                      });
                    },
                    child: Icon(
                      Icons.search_rounded,
                      color: context.appColor.textPrimary,
                    ),
                  ),
                  SizedBox(width: 12),
                  InkWell(
                    onTap: () {
                      //  DioInspectorInstance.httpContainer.clearRequests();
                      _searchController.clear();
                      setState(() {
                        _query = '';
                        showSearchBar = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.appColor.error.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: context.appColor.error.withValues(alpha: 0.5),
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
                            color: context.appColor.error,
                          ),
                          Text(
                            '清空',
                            style: TextStyle(
                              color: context.appColor.error,
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
            if (showSearchBar)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _searchController,
                  cursorHeight: 20,
                  onChanged: (value) {
                    setState(() {
                      _query = value;
                    });
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: "URL",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(
                        color:
                            context.appColor.textPrimary.withValues(alpha: 0.5),
                      ),
                    ),
                    suffixIcon: _query != ""
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                                _query = '';
                              });
                            },
                            icon: Icon(
                              Icons.clear_rounded,
                              color: context.appColor.textPrimary,
                            ),
                          )
                        : null,
                  ),
                ),
              ),
            SizedBox(height: 8),
            Expanded(child: _itemList(context)),
          ],
        ),
      ),
    );
  }

  List<Response<dynamic>> _filterRequests(List<Response<dynamic>> requests) {
    final String query = _query.trim();
    if (query.isEmpty) {
      return requests;
    }
    final String lowerQuery = query.toLowerCase();
    return requests.where((response) {
      final String uri = response.requestOptions.uri.toString().toLowerCase();
      return uri.contains(lowerQuery);
    }).toList();
  }

  Widget _itemList(BuildContext context) {
    final bool hasQuery = _query.trim().isNotEmpty;
    final List<Response<dynamic>> baseRequests = hasQuery
        ? DioInspectorInstance.httpContainer.requests
        : DioInspectorInstance.httpContainer.pagedRequests;
    final List<Response<dynamic>> requests = _filterRequests(baseRequests);

    final int length = requests.length;
    if (length > 0) {
      return CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate((_, int index) {
              final Response<dynamic> r = requests[index];
              if (!hasQuery && index == length - 2) {
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
