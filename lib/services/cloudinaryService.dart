import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dio/dio.dart';
import 'package:dotenv/dotenv.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http; // ✅ Add this import

Future<String?> uploadToCloudinary(File? imageFile) async {
  if (imageFile == null) {
    print("No File Selected");
    return null;
  }

  String cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '';
  var uri = Uri.parse(
    "https://api.cloudinary.com/v1_1/$cloudName/image/upload",
  ); // use `image/upload`

  var request = http.MultipartRequest("POST", uri);

  var fileBytes = await imageFile.readAsBytes();
  var multipartFile = http.MultipartFile.fromBytes(
    'file',
    fileBytes,
    filename: imageFile.path.split("/").last,
  );

  request.files.add(multipartFile);

  request.fields['upload_preset'] = "mainImages"; // ✅ Your preset
  // no need for 'resource_type' unless you're uploading non-image files

  var response = await request.send();
  var responseBody = await response.stream.bytesToString();
  print(responseBody);

  if (response.statusCode == 200) {
    final data = jsonDecode(responseBody);
    return data['secure_url']; // ✅ This is the public image URL
  } else {
    print("Upload failed with status: ${response.statusCode}");
    return null;
  }
}
