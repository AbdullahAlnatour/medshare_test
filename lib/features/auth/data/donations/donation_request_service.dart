import 'dart:convert';
import 'package:http/http.dart' as http;
import 'donation_request_model.dart';

class DonationRequestService {
  final String baseUrl = "http://10.0.2.2:5149/api/Requests";

  Future<List<AdminDonationRequest>> getPendingEquipmentRequests(
      String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/getMyPendingEquipmentRequests"),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => AdminDonationRequest.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load equipment requests");
    }
  }

  Future<List<AdminDonationRequest>> getPendingMedicineRequests(
      String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/getMyPendingMedicineRequests"),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => AdminDonationRequest.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load medicine requests");
    }
  }
}