class Transaction {
  int? id;
  int? userId;
  String? items;
  double? totalPrice;
  String? paymentProof;
  String? trackingNumber;
  bool? orderStatus;
  bool? confirmation;
  DateTime? createdAt;
  DateTime? updatedAt;

  Transaction({
    this.id,
    this.userId,
    this.items,
    this.totalPrice,
    this.paymentProof,
    this.trackingNumber,
    this.orderStatus,
    this.confirmation,
    this.createdAt,
    this.updatedAt,
  });

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      userId: map['user_id'],
      items: map['items'],
      totalPrice: map['total_price'],
      paymentProof: map['payment_proof'],
      trackingNumber: map['tracking_number'],
      orderStatus: map['order_status'],
      confirmation: map['confirmation'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'items': items,
      'total_price': totalPrice,
      'payment_proof': paymentProof,
      'tracking_number': trackingNumber,
      'order_status': orderStatus,
      'confirmation': confirmation,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
