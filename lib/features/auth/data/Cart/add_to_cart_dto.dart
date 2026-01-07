class AddToCartDto {
  final int donationId;
  final int quantity;
  final int cartType; // 1 = Equipment, 2 = Medicine

  AddToCartDto({
    required this.donationId,
    required this.quantity,
    required this.cartType,
  });

  Map<String, dynamic> toJson() {
    return {
      "donationId": donationId,
      "quantity": quantity,
      "cartType": cartType,
    };
  }
}
