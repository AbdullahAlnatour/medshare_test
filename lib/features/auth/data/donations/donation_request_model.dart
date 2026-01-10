class AdminDonationRequest {
  final int requestId;
  final String itemName;
  final int quantity;
  final String? expirationDate;
  final int userId;
  final String userName;
  final String userEmail;
  final String type;

  AdminDonationRequest({
    required this.requestId,
    required this.itemName,
    required this.quantity,
    required this.expirationDate,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.type,
  });

  factory AdminDonationRequest.fromJson(Map<String, dynamic> json) {
    return AdminDonationRequest(
      requestId: json["requestId"],
      itemName: json["itemName"],
      quantity: json["quantity"],
      expirationDate: json["expirationDate"],
      userId: json["userId"],
      userName: json["userName"],
      userEmail: json["userEmail"],
      type: json["type"],
    );
  }
}