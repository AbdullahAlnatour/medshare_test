import '../../../core/api/api_client.dart';
import '../../../core/storage/token_storage.dart';
import 'login_request_model.dart';
import 'login_response_model.dart';

class AuthService {
  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final request = LoginRequest(
        email: email,
        password: password,
      );

      final response = await ApiClient.dio.post(
        '/Auth/Login',
        data: request.toJson(),
      );

      //print('STATUS: ${response.statusCode}');
      //print('DATA: ${response.data}');

      final loginResponse = LoginResponse.fromJson(response.data);

      await TokenStorage.saveTokens(
        accessToken: loginResponse.accessToken,
        refreshToken: loginResponse.refreshToken,
      );

      return loginResponse;
    } catch (e) {
      print('AUTH SERVICE ERROR: $e');
      rethrow;
    }
  }
}
