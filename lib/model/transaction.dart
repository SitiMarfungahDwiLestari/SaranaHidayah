import 'dart:convert';

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
      items: map['items'] != null
          ? json.encode(map['items'])
          : null, // Encode items to string if needed
      totalPrice: map['total_price'] is String
          ? double.tryParse(map['total_price'])
          : map['total_price']?.toDouble(),
      paymentProof: map['payment_proof'],
      trackingNumber: map['tracking_number'],
      orderStatus: map['order_status'],
      confirmation: map['confirmation'],
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
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
