import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<File> _getBookmarkFile() async {
  final dir = await getApplicationDocumentsDirectory();
  return File('${dir.path}/bookmarks.txt');
}

Future<List<String>> loadSavedAlgos() async {
  final file = await _getBookmarkFile();
  if (!(await file.exists())) return [];
  final contents = await file.readAsLines();
  return contents.map((line) => line.trim()).toList();
}

Future<void> saveAlgo(String id) async {
  final file = await _getBookmarkFile();
  final ids = await loadSavedAlgos();
  if (!ids.contains(id)) {
    await file.writeAsString('$id\n', mode: FileMode.append);
  }
}

Future<void> removeAlgo(String id) async {
  final file = await _getBookmarkFile();
  final ids = await loadSavedAlgos();
  ids.remove(id);
  await file.writeAsString(ids.join('\n'));
}
