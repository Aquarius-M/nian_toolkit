import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nian_toolkit/nian_toolkit.dart';

class ResponseCard extends StatefulWidget {
  const ResponseCard({super.key, required this.response});

  final Response<dynamic> response;

  @override
  ResponseCardState createState() => ResponseCardState();
}

class ResponseCardState extends State<ResponseCard> {
  final ValueNotifier<bool> _isExpanded = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _isExpanded.dispose();
    super.dispose();
  }

  void _switchExpand() {
    _isExpanded.value = !_isExpanded.value;
  }

  Response<dynamic> get _response => widget.response;
  RequestOptions get _request => _response.requestOptions;

  /// The start time for the [_request].
  DateTime get _startTime => _response.startTime;

  /// The end time for the [_response].
  DateTime get _endTime => _response.endTime;

  /// The duration between the request and the response.
  Duration get _duration => _endTime.difference(_startTime);

  /// Status code for the [_response].
  int get _statusCode => _response.statusCode ?? 0;

  /// The method that the [_request] used.
  String get _method => _request.method;

  /// The [Uri] that the [_request] requested.
  Uri get _requestUri => _request.uri;

  Color get _statusColor {
    if (_statusCode >= 200 && _statusCode < 300) return Colors.green;
    if (_statusCode >= 300 && _statusCode < 400) return Colors.orange;
    if (_statusCode >= 400 && _statusCode < 500) return Colors.red;
    if (_statusCode >= 500 && _statusCode < 600) return Colors.redAccent;
    return Colors.grey;
  }

  Color get _methodColor {
    switch (_method.toUpperCase()) {
      case 'GET':
        return Colors.blue;
      case 'POST':
        return Colors.orange;
      case 'PUT':
        return Colors.purple;
      case 'DELETE':
        return Colors.red;
      case 'PATCH':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  String? get _requestHeadersBuilder {
    final Map<String, List<String>> map = _request.headers.map(
      (key, value) => MapEntry(
        key,
        value is Iterable
            ? value.map((v) => v.toString()).toList()
            : [value.toString()],
      ),
    );
    final Headers headers = Headers.fromMap(map);
    if (headers.isEmpty) {
      return null;
    }
    return '$headers'.replaceAll(RegExp(r'[\n\r]+$'), "");
  }

  String? get _responseHeadersBuilder {
    final Map<String, List<String>> map = _response.headers.map;
    final Headers headers = Headers.fromMap(map);
    if (headers.isEmpty) {
      return null;
    }
    return '$headers'.replaceAll(RegExp(r'[\n\r]+$'), "");
  }

  /// Data for the [_request].
  String? get _requestDataBuilder {
    if (_request.data is Map || _request.data is List) {
      try {
        return _encoder.convert(_request.data);
      } catch (e) {
        return _request.data.toString();
      }
    }
    return _request.data?.toString().replaceAll(RegExp(r'[\n\r]+$'), "");
  }

  /// Data for the [_response].
  String? get _responseDataBuilder {
    final data = _response.data;
    if (data == null) {
      return null;
    }
    if (data is Map || data is List) {
      try {
        return _encoder.convert(data).replaceAll(RegExp(r'[\n\r]+$'), "");
      } catch (e) {
        return data.toString().replaceAll(RegExp(r'[\n\r]+$'), "");
      }
    }
    return data.toString().replaceAll(RegExp(r'[\n\r]+$'), "");
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _infoContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildTag(_method, _methodColor),
            const SizedBox(width: 8),
            _buildTag(_statusCode.toString(), _statusColor),
            const Spacer(),
            Text(
              '${_duration.inMilliseconds}ms',
              style: TextStyle(
                color: _duration.inMilliseconds > 1000
                    ? Colors.red
                    : Theme.of(context).textTheme.bodySmall?.color,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              _startTime.hms(),
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          _requestUri.toString(),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _detailedContent(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isExpanded,
      builder: (_, bool value, _) {
        return AnimatedCrossFade(
          firstChild: const SizedBox(width: double.infinity),
          secondChild: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Divider(),
                _TagText(
                  tag: 'Request Headers',
                  content: _requestHeadersBuilder,
                ),
                _TagText(tag: 'Request Data', content: _requestDataBuilder),
                _TagText(
                  tag: 'Response Headers',
                  content: _responseHeadersBuilder,
                ),
                _TagText(tag: 'Response Body', content: _responseDataBuilder),
              ],
            ),
          ),
          crossFadeState: value
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: _switchExpand,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _infoContent(context),
              _detailedContent(context),
            ],
          ),
        ),
      ),
    );
  }
}

class _TagText extends StatelessWidget {
  const _TagText({required this.tag, this.content});

  final String tag;
  final String? content;

  @override
  Widget build(BuildContext context) {
    if (content == null || content!.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$tag:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
              ),
            ),
            child: SelectableText(
              content ?? "",
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

extension _DateTimeExtension on DateTime {
  String hms([String separator = ':']) =>
      '$hour$separator'
      '${'$minute'.padLeft(2, '0')}$separator'
      '${'$second'.padLeft(2, '0')}';
}

const JsonEncoder _encoder = JsonEncoder.withIndent('  ');
