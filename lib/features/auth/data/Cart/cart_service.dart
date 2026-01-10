git adimport '../../../../core/storage/token_storage.dart';
import '../../../../core/api/api_client.dart' as _api;
import 'add_to_cart_dto.dart';
import 'cart_response_model.dart';

class CartService {
  Future<CartResponseModel> getMyCart() async {
    print('🟡 getMyCart called');

    try {
      final resp = await _api.ApiClient.dio.get('/Requests/myCart');
      print('🟢 getMyCart status: ${resp.statusCode}');
      return CartResponseModel.fromJson(resp.data);
    } catch (e) {
      print('🔴 getMyCart error: $e');
      rethrow;
    }
  }

  /// Adds item to cart and returns `true` if server responded with 200.
  /// Returns `false` if an error occurred or non-200 status.
  Future<bool> addToCart(AddToCartDto dto) async {
    print('🟡 addToCart dto: ${dto.toJson()}');

    late String endpoint;
    if (dto.cartType == 1) {
      endpoint = 'addEquipmentToCart';
    } else if (dto.cartType == 2) {
      endpoint = 'addMedicineToCart';
    } else {
      print('🔴 addToCart invalid cartType: ${dto.cartType}');
      return false;
    }

    try {
      print('🟡 ApiClient.baseUrl: ${_api.ApiClient.dio.options.baseUrl}');
      final resp = await _api.ApiClient.dio.put(
        '/Requests/$endpoint',
        data: dto.toJson(),
      );
      print('🟢 addToCart status: ${resp.statusCode}');
      return resp.statusCode == 200;
    } catch (e) {
      print('🔴 addToCart error: $e');
      return false;
    }
  }

  Future<void> removeFromCart(AddToCartDto dto) async {
    try {
      final resp = await _api.ApiClient.dio.put(
        '/Requests/removeFromCart',
        data: dto.toJson(),
      );
      if (resp.statusCode != 200)
        throw Exception('Failed to remove item from cart (${resp.statusCode})');
    } catch (e) {
      print('🔴 removeFromCart error: $e');
      rethrow;
    }
  }

  Future<void> checkout() async {
    try {
      final resp = await _api.ApiClient.dio.put('/Requests/checkoutMyCart');
      if (resp.statusCode != 200)
        throw Exception('Checkout failed (${resp.statusCode})');
    } catch (e) {
      print('🔴 checkout error: $e');
      rethrow;
    }
  }
}
