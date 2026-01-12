import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/storage/token_storage.dart';
import 'donation_equipment_model.dart';
import 'donation_medicine_model.dart';

class DRHomeService {
  final String baseUrl = "http://10.0.2.2:5149/api/donations";

  // 🔹 Get approved equipment
  Future<List<DonationEquipmentModel>> getApprovedEquipment() async {
    final token = await TokenStorage.getAccessToken();

    final res = await http.get(
      Uri.parse("$baseUrl/GetApprovedEquipment"),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    print("Equipment status: ${res.statusCode}");
    print("Equipment body: ${res.body}");

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => DonationEquipmentModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load approved equipment");
    }
  }


  // 🔹 Get approved medicines
  Future<List<DonationMedicineModel>> getApprovedMedicines() async {
    final token = await TokenStorage.getAccessToken();

    final res = await http.get(
      Uri.parse("$baseUrl/GetApprovedMedicines"),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    print("Medicine status: ${res.statusCode}");
    print("Medicine body: ${res.body}");

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => DonationMedicineModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load approved medicines");
    }
  }

}
