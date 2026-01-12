class UnavailableRequest {
  final String itemName;
  final String? itemDesc;
  final String status;

  UnavailableRequest({
    required this.itemName,
    this.itemDesc,
    required this.status,
  });

  factory UnavailableRequest.fromJson(Map<String, dynamic> json) {
    return UnavailableRequest(
      itemName: json["itemName"],
      itemDesc: json["itemDesc"],
      status: json["status"] ?? "Pending",
    );
  }
}

