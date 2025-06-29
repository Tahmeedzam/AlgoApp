import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> pushFirstAlgo() async {
  try {
    final String jsonString = await rootBundle.loadString(
      'assets/json/all_algorithms_full_UPDATED_ALL.json',
    );
    final List<dynamic> jsonData = jsonDecode(jsonString);

    if (jsonData.isNotEmpty && jsonData.first is Map<String, dynamic>) {
      Map<String, dynamic> firstAlgo = jsonData.first;
      final String? algoId = firstAlgo['id'];

      if (algoId == null || algoId.isEmpty) {
        print('Error: ID field is missing or empty');
        return;
      }

      // Push to Firestore collection 'algorithms'
      await FirebaseFirestore.instance
          .collection('algorithms')
          .doc(algoId)
          .set(firstAlgo);

      print("Algorithm with ID '$algoId' pushed successfully.");
    } else {
      print("JSON is empty or not in expected format.");
    }
  } catch (e) {
    print("Failed to push algorithm: $e");
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
          onPressed: pushFirstAlgo,
          child: Row(
            children: [Text("Upload All"), Icon(Icons.arrow_upward_rounded)],
          ),
        ),
      ),
    );
  }
}
