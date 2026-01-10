import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/api/api_client.dart';

Future<void> createEquipmentRequest({
  required String itemName,
  String? itemDesc,
  required int quantity,
  required int condition,
  String? accessories,
  required bool isAvailable,
  required bool isWorkingFully,
  required List<XFile> images,
}) async {
  final List<MultipartFile> imageFiles = [];

  for (final image in images) {
    if (kIsWeb) {
      // Flutter Web
      final bytes = await image.readAsBytes();
      imageFiles.add(
        MultipartFile.fromBytes(
          bytes,
          filename: image.name,
        ),
      );
    } else {
      // Android / iOS
      imageFiles.add(
        await MultipartFile.fromFile(
          image.path,
          filename: image.name,
        ),
      );
    }
  }

  final formData = FormData.fromMap({
    'ItemName': itemName,
    'ItemDesc': itemDesc,
    'Quantity': quantity,
    'Condition': condition,
    'Accessories': accessories,
    'IsAvailable': isAvailable,
    'IsWokringFully': isWorkingFully,
    'Images': imageFiles,
  });

  await ApiClient.dio.post(
    '/Requests/createEquipmentRequest',
    data: formData,
  );
}

Future<void> createMedicineRequest({
  required String itemName,
  String? itemDesc,
  String? strength,
  required int quantity,
  required int dosageForm,
  required DateTime expirationDate,
  required bool isAvailable,
  required bool unOpened,
  required List<XFile> images,
}) async {
  final List<MultipartFile> imageFiles = [];

  for (final image in images) {
    if (kIsWeb) {
      final bytes = await image.readAsBytes();
      imageFiles.add(
        MultipartFile.fromBytes(bytes, filename: image.name),
      );
    } else {
      imageFiles.add(
        await MultipartFile.fromFile(image.path, filename: image.name),
      );
    }
  }

  final formData = FormData.fromMap({
    'ItemName': itemName,
    'ItemDesc': itemDesc,
    'Strength': strength,
    'Quantity': quantity,
    'DosageForm': dosageForm,
    'ExpirationDate': expirationDate.toIso8601String(),
    'IsAvailable': isAvailable,
    'UnOpend': unOpened,
    'Images': imageFiles,
  });

  await ApiClient.dio.post(
    '/Requests/createMedicineRequest',
    data: formData,
  );
}