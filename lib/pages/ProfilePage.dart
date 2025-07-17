import 'dart:io';

import 'package:algosapp/components/smallCard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Map<String, dynamic>> bookmarkedAlgos = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadBookmarkedAlgos();
  }

  Future<void> _loadBookmarkedAlgos() async {
    try {
      final ids = await loadSavedAlgos();
      List<Map<String, dynamic>> loaded = [];

      for (String id in ids) {
        final doc = await FirebaseFirestore.instance
            .collection('algorithms')
            .doc(id)
            .get();

        if (doc.exists) {
          final data = doc.data()!;
          loaded.add({
            'id': id,
            'name': data['name'],
            'category': data['category'] ?? 'Uncategorized',
            'color': Colors.yellow, // You can map category to color here
          });
        }
      }

      if (mounted) {
        setState(() {
          bookmarkedAlgos = loaded;
          loading = false;
        });
      }
    } catch (e) {
      print('Failed to load bookmarks: $e');
    }
  }

  // Read list of saved IDs from file
  Future<List<String>> loadSavedAlgos() async {
    final file = await _getLocalFile();
    if (!await file.exists()) return [];

    final content = await file.readAsString();
    return content.split('\n').where((id) => id.trim().isNotEmpty).toList();
  }

  // Get the file used for storing bookmarks
  Future<File> _getLocalFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/saved_algos.txt');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0D0D0D),
      appBar: AppBar(
        title: const Text(
          'Your Saved Algos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff1A1A1A),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator(color: Colors.yellow))
          : bookmarkedAlgos.isEmpty
          ? const Center(
              child: Text(
                'No saved algorithms',
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: bookmarkedAlgos.length,
              itemBuilder: (context, index) {
                final algo = bookmarkedAlgos[index];
                return smallCard(
                  CardId: algo['id'],
                  CardName: algo['name'],
                  CardCategoryName: (algo['category'] is List)
                      ? (algo['category'] as List).join(', ')
                      : (algo['category'] ?? 'Uncategorized'),
                  Cardcolor: algo['color'],
                  isBookmarked: true,
                );
              },
            ),
    );
  }
}
