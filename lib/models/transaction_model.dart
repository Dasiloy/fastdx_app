import 'package:fastdx_app/core/core.dart';

class AppTransaction implements EntityInterface {
  @override
  final String id;

  final String orderId;
  final double amount;
  final OrderPaymentStatusEnum status;
  final OrderPaymentMethodEnum method;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String? reference;
  final String? description;

  const AppTransaction({
    required this.id,
    required this.orderId,
    required this.amount,
    required this.status,
    required this.method,
    required this.createdAt,
    this.completedAt,
    this.reference,
    this.description,
  });

  @override
  AppTransaction.fromJson(Map<String, dynamic> json)
    : id = json["id"],
      orderId = json["orderId"],
      amount = (json["amount"] as num).toDouble(),
      status = OrderPaymentStatusEnum.values[json["status"]],
      method = OrderPaymentMethodEnum.values[json["method"]],
      createdAt = DateTime.parse(json["createdAt"]),
      completedAt = json["completedAt"] != null
          ? DateTime.parse(json["completedAt"])
          : null,
      reference = json["reference"],
      description = json["description"];

  @override
  Map<String, dynamic> toJson() {
    return {
      "orderId": orderId,
      "amount": amount,
      "status": status.index,
      "method": method.index,
      "createdAt": createdAt.toIso8601String(),
      "completedAt": completedAt?.toIso8601String(),
      "reference": reference,
      "description": description,
    };
  }
}
