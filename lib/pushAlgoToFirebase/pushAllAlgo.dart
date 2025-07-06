import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> pushAllAlgos() async {
  try {
    final String jsonString = await rootBundle.loadString(
      'assets/json/all_algorithms_full_UPDATED_ALL.json',
    );
    final List<dynamic> jsonData = jsonDecode(jsonString);

    if (jsonData.isEmpty) {
      print("JSON is empty.");
      return;
    }

    for (var algo in jsonData) {
      if (algo is Map<String, dynamic>) {
        final String? algoId = algo['id'];

        if (algoId == null || algoId.isEmpty) {
          print('Skipping: Missing or empty ID.');
          continue;
        }

        await FirebaseFirestore.instance
            .collection('algorithms')
            .doc(algoId)
            .set(algo);

        print("✅ Pushed: $algoId");
      } else {
        print("Skipping: Not a valid JSON object.");
      }
    }

    print("🎉 All algorithms pushed successfully.");
  } catch (e) {
    print("❌ Failed to push algorithms: $e");
  }
}

class pushAllAlgo extends StatefulWidget {
  const pushAllAlgo({super.key});

  @override
  State<pushAllAlgo> createState() => _pushAllAlgoState();
}

class _pushAllAlgoState extends State<pushAllAlgo> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: pushAllAlgos,
          child: Row(
            children: [Text("Upload All"), Icon(Icons.arrow_upward_rounded)],
          ),
        ),
      ),
    );
  }
}
