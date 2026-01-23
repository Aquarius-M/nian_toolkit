// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../../nian_toolkit.dart';

class DioPluggable extends StatefulWidget implements Pluggable {
  const DioPluggable({super.key});

  @override
  Widget? buildWidget(BuildContext? context) => this;

  @override
  Widget? iconWidget() => PluginIcons.dio;

  @override
  int get index => 9998;

  @override
  String get name => '网络请求';

  @override
  void onTrigger() {}

  @override
  State<StatefulWidget> createState() {
    return _DioPluggableState();
  }
}

class _DioPluggableState extends State<DioPluggable> {
  @override
  Widget build(BuildContext context) {
    return const DioPage();
  }
}

// class DioPluggable extends StatefulWidget implements Pluggable {
//   const DioPluggable({super.key});

//   @override
//   State<DioPluggable> createState() => _DioPluggableState();

//   @override
//   Widget? buildWidget(BuildContext? context) => this;

//   @override
//   String get name => '网络请求';

//   @override
//   Widget? iconWidget() => PluginIcons.dio;

//   @override
//   int get index => 9998;

//   @override
//   void onTrigger() {}
// }

// class _DioPluggableState extends State<DioPluggable> {
//   @override
//   void initState() {
//     super.initState();
//     // Bind listener to refresh requests.
//     DioInspectorInstance.httpContainer.addListener(_listener);
//   }

//   @override
//   void dispose() {
//     DioInspectorInstance.httpContainer
//       ..removeListener(_listener) // First, remove refresh listener.
//       ..resetPaging(); // Then reset the paging field.
//     super.dispose();
//   }

//   /// Using [setState] won't cause too much performance regression,
//   /// since we've implemented the list with `findChildIndexCallback`.
//   void _listener() {
//     Future.microtask(() {
//       if (mounted &&
//           !context.debugDoingBuild &&
//           context.owner?.debugBuilding != true) {
//         setState(() {});
//       }
//     });
//   }

//   Widget _clearAllButton(BuildContext context) {
//     return TextButton(
//       onPressed: DioInspectorInstance.httpContainer.clearRequests,
//       style: _buttonStyle(
//         context,
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       ),
//       child: const Row(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           Text('清除记录'),
//           Icon(Icons.clear_all_rounded, size: 14),
//         ],
//       ),
//     );
//   }

//   Widget _itemList(BuildContext context) {
//     final List<Response<dynamic>> requests =
//         DioInspectorInstance.httpContainer.pagedRequests;
//     final int length = requests.length;
//     if (length > 0) {
//       return CustomScrollView(
//         slivers: <Widget>[
//           SliverList(
//             delegate: SliverChildBuilderDelegate((_, int index) {
//               final Response<dynamic> r = requests[index];
//               if (index == length - 2) {
//                 DioInspectorInstance.httpContainer.loadNextPage();
//               }
//               return _ResponseCard(
//                 key: ValueKey<int>(r.startTimeMilliseconds),
//                 response: r,
//               );
//             }, childCount: length),
//           ),
//         ],
//       );
//     }
//     return const Center(
//       child: Text(
//         '还没有网络请求...\n🧐',
//         style: TextStyle(fontSize: 28),
//         textAlign: TextAlign.center,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.black26,
//       child: DefaultTextStyle.merge(
//         style: Theme.of(context).textTheme.bodyMedium,
//         child: Align(
//           alignment: Alignment.bottomCenter,
//           child: Container(
//             constraints: BoxConstraints.tightFor(
//               width: double.maxFinite,
//               height: MediaQuery.of(context).size.height / 1.25,
//             ),
//             decoration: BoxDecoration(
//               borderRadius: const BorderRadius.vertical(
//                 top: Radius.circular(16),
//               ),
//               color: Theme.of(context).cardColor,
//             ),
//             child: Column(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Row(
//                     children: <Widget>[
//                       const Spacer(),
//                       Text(
//                         '网络请求',
//                         style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Expanded(
//                         child: Align(
//                           alignment: AlignmentDirectional.centerEnd,
//                           child: _clearAllButton(context),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: ColoredBox(
//                     color: Theme.of(context).canvasColor,
//                     child: _itemList(context),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _ResponseCard extends StatefulWidget {
//   const _ResponseCard({required super.key, required this.response});

//   final Response<dynamic> response;

//   @override
//   _ResponseCardState createState() => _ResponseCardState();
// }

// class _ResponseCardState extends State<_ResponseCard> {
//   final ValueNotifier<bool> _isExpanded = ValueNotifier<bool>(false);

//   @override
//   void dispose() {
//     _isExpanded.dispose();
//     super.dispose();
//   }

//   void _switchExpand() {
//     _isExpanded.value = !_isExpanded.value;
//   }

//   Response<dynamic> get _response => widget.response;

//   RequestOptions get _request => _response.requestOptions;

//   /// The start time for the [_request].
//   DateTime get _startTime => _response.startTime;

//   /// The end time for the [_response].
//   DateTime get _endTime => _response.endTime;

//   /// The duration between the request and the response.
//   Duration get _duration => _endTime.difference(_startTime);

//   /// Status code for the [_response].
//   int get _statusCode => _response.statusCode ?? 0;

//   /// Colors matching status.
//   Color get _statusColor {
//     if (_statusCode >= 200 && _statusCode < 300) {
//       return Colors.lightGreen;
//     }
//     if (_statusCode >= 300 && _statusCode < 400) {
//       return Colors.orangeAccent;
//     }
//     if (_statusCode >= 400 && _statusCode < 500) {
//       return Colors.purple;
//     }
//     if (_statusCode >= 500 && _statusCode < 600) {
//       return Colors.red;
//     }
//     return Colors.blueAccent;
//   }

//   /// The method that the [_request] used.
//   String get _method => _request.method;

//   /// The [Uri] that the [_request] requested.
//   Uri get _requestUri => _request.uri;

//   String? get _requestHeadersBuilder {
//     final Map<String, List<String>> map = _request.headers.map(
//       (key, value) => MapEntry(
//         key,
//         value is Iterable ? value.map((v) => v.toString()).toList() : [value],
//       ),
//     );
//     final Headers headers = Headers.fromMap(map);
//     if (headers.isEmpty) {
//       return null;
//     }
//     return '$headers'.replaceAll(RegExp(r'[\n\r]+$'), "");
//   }

//   String? get _responseHeadersBuilder {
//     final Map<String, List<String>> map = _response.headers.map;
//     final Headers headers = Headers.fromMap(map);
//     if (headers.isEmpty) {
//       return null;
//     }
//     return '$headers'.replaceAll(RegExp(r'[\n\r]+$'), "");
//   }

//   /// Data for the [_request].
//   String? get _requestDataBuilder {
//     if (_request.data is Map) {
//       return _encoder.convert(_request.data);
//     }
//     return _request.data?.toString().replaceAll(RegExp(r'[\n\r]+$'), "");
//   }

//   /// Data for the [_response].
//   String? get _responseDataBuilder {
//     final data = _response.data;
//     if (data == null) {
//       return null;
//     }
//     if (_response.data is Map || _response.data is List) {
//       return _encoder
//           .convert(_response.data)
//           .replaceAll(RegExp(r'[\n\r]+$'), "");
//     }
//     return _response.data.toString().replaceAll(RegExp(r'[\n\r]+$'), "");
//   }

//   // String? get _responseHeadersBuilder {
//   //   if (_response.headers.isEmpty) {
//   //     return null;
//   //   }
//   //   return '${_response.headers}';
//   // }

//   Widget _infoContent(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("URL: $_requestUri", style: const TextStyle(fontSize: 16)),
//         const SizedBox(height: 10),
//         Row(
//           children: <Widget>[
//             Text(_startTime.hms()),
//             const SizedBox(width: 6),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(3),
//                 color: _statusColor,
//               ),
//               child: Text(
//                 _statusCode.toString(),
//                 style: const TextStyle(color: Colors.white, fontSize: 12),
//               ),
//             ),
//             const SizedBox(width: 6),
//             Text(_method, style: const TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(width: 6),
//             Text('${_duration.inMilliseconds}ms'),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _detailedContent(BuildContext context) {
//     return ValueListenableBuilder<bool>(
//       valueListenable: _isExpanded,
//       builder: (_, bool value, _) {
//         if (!value) {
//           return const SizedBox.shrink();
//         }
//         return Padding(
//           padding: const EdgeInsets.only(top: 8),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               const Divider(color: Colors.grey),
//               _TagText(
//                 tag: 'Url',
//                 content: "$_requestUri",
//                 shouldStartFromNewLine: true,
//               ),
//               _TagText(tag: 'Request headers', content: _requestHeadersBuilder),
//               _TagText(tag: 'Request data', content: "$_requestDataBuilder"),
//               _TagText(
//                 tag: 'Response headers',
//                 content: _responseHeadersBuilder,
//               ),
//               _TagText(tag: 'Response body', content: _responseDataBuilder),
//               // _TagText(
//               //   tag: 'Response headers',
//               //   content: _responseHeadersBuilder,
//               // ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8.0),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withValues(alpha: 0.2),
//             spreadRadius: 3,
//             blurRadius: 5,
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             InkWell(
//               onTap: () {
//                 _switchExpand();
//               },
//               child: _infoContent(context),
//             ),
//             _detailedContent(context),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _TagText extends StatelessWidget {
//   const _TagText({
//     required this.tag,
//     this.content,
//     this.shouldStartFromNewLine = true,
//   });

//   final String tag;
//   final String? content;
//   final bool shouldStartFromNewLine;

//   TextSpan get span {
//     return TextSpan(children: <TextSpan>[TextSpan(text: content!)]);
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (content == null) {
//       return const SizedBox.shrink();
//     }
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: shouldStartFromNewLine
//           ? Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "$tag: ",
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 6),
//                 SelectableText.rich(span),
//               ],
//             )
//           : Row(
//               children: [
//                 Text(
//                   "$tag: ",
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 SelectableText.rich(span),
//               ],
//             ),
//     );
//   }
// }

// extension _DateTimeExtension on DateTime {
//   String hms([String separator = ':']) =>
//       '$hour$separator'
//       '${'$minute'.padLeft(2, '0')}$separator'
//       '${'$second'.padLeft(2, '0')}';
// }

// const JsonEncoder _encoder = JsonEncoder.withIndent('  ');

// ButtonStyle _buttonStyle(
//   BuildContext context, {
//   EdgeInsetsGeometry? padding,
//   Color? color,
// }) {
//   return TextButton.styleFrom(
//     padding: padding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//     minimumSize: Size.zero,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999999)),
//     backgroundColor: color ?? Colors.blueAccent,
//     foregroundColor: Colors.white,
//     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//   );
// }
