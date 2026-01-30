import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';

import '../../../app_theme/theme.dart';

class FileManagerPage extends StatefulWidget {
  const FileManagerPage({super.key});

  @override
  State<FileManagerPage> createState() => _FileManagerPageState();
}

class _FileManagerPageState extends State<FileManagerPage> {
  List<FileSystemEntity> _files = [];
  String _currentPath = '';
  final List<String> _pathHistory = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadInitialDirectory();
  }

  Future<void> _loadInitialDirectory() async {
    setState(() => _loading = true);
    try {
      final appDir = await getApplicationDocumentsDirectory();
      _currentPath = appDir.parent.path;
      await _loadDirectory(_currentPath);
    } catch (e) {
      log('加载目录失败: $e');
    }
    setState(() => _loading = false);
  }

  Future<void> _loadDirectory(String path) async {
    setState(() => _loading = true);
    try {
      final dir = Directory(path);
      final entities = await dir.list().toList();
      entities.sort((a, b) {
        // 文件夹排在前面
        if (a is Directory && b is! Directory) return -1;
        if (a is! Directory && b is Directory) return 1;
        return a.path.compareTo(b.path);
      });
      setState(() {
        _files = entities;
        _currentPath = path;
      });
    } catch (e) {
      log('加载目录失败: $e');
    }
    setState(() => _loading = false);
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }

  Future<int> _getFileSize(FileSystemEntity entity) async {
    if (entity is File) {
      try {
        return await entity.length();
      } catch (e) {
        return 0;
      }
    }
    return 0;
  }

  Future<void> _deleteFile(FileSystemEntity entity) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        backgroundColor: context.appColor.backgroundPopup,
        title: const Text('确认删除'),
        content: Text('确定要删除 ${entity.path.split('/').last} 吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('删除', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        if (entity is Directory) {
          await entity.delete(recursive: true);
        } else {
          await entity.delete();
        }
        await _loadDirectory(_currentPath);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('删除失败: $e')));
        }
      }
    }
  }

  Future<void> _showFileInfo(FileSystemEntity entity) async {
    final stat = await entity.stat();
    final size = await _getFileSize(entity);

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: context.appColor.backgroundPopup,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        title: Text(entity.path.split('/').last),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('路径: ${entity.path}'),
            const SizedBox(height: 8),
            Text('类型: ${entity is Directory ? "文件夹" : "文件"}'),
            const SizedBox(height: 8),
            if (entity is File) Text('大小: ${_formatFileSize(size)}'),
            const SizedBox(height: 8),
            Text('修改时间: ${stat.modified}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('文件管理器', style: context.f18MediumTextPrimary),
        actions: [
          if (_pathHistory.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                final previousPath = _pathHistory.removeLast();
                _loadDirectory(previousPath);
              },
            ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            color: context.appColor.backgroundInput,
            child: Row(
              children: [
                const Icon(Icons.folder, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _currentPath,
                    style: const TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _files.length,
                    itemBuilder: (context, index) {
                      final entity = _files[index];
                      final isDirectory = entity is Directory;
                      final name = entity.path.split('/').last;

                      return ListTile(
                        leading: Icon(
                          isDirectory ? Icons.folder : Icons.insert_drive_file,
                          color: isDirectory ? Colors.blue : Colors.grey,
                        ),
                        title: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: context.f16MediumTextPrimary,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            FutureBuilder<int>(
                              future: _getFileSize(entity),
                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.data! > 0) {
                                  return Text(
                                    _formatFileSize(snapshot.data!),
                                    style: context.f14RegularTextTertiary,
                                  );
                                }
                                return SizedBox();
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          if (isDirectory) {
                            _pathHistory.add(_currentPath);
                            _loadDirectory(entity.path);
                          } else {
                            _showFileInfo(entity);
                          }
                        },
                        trailing: PopupMenuButton(
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'info',
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(Icons.info_outline),
                                  Text('详情'),
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(Icons.delete, color: Colors.red),
                                  Text(
                                    '删除',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          onSelected: (value) {
                            if (value == 'info') {
                              _showFileInfo(entity);
                            } else if (value == 'delete') {
                              _deleteFile(entity);
                            }
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
