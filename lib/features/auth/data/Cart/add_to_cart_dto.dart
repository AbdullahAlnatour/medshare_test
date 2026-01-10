class AddToCartDto {
  final int donationId;
  final int quantity;
  final int cartType; // 1 = Equipment, 2 = Medicine
  final String? itemName;

  AddToCartDto({
    required this.donationId,
    required this.quantity,
    required this.cartType,
    this.itemName,
  });

  Map<String, dynamic> toJson() {
    return {
      "donationId": donationId,
      "quantity": quantity,
      "cartType": cartType,
      "ItemName": itemName ?? "",
    };
  }
}
