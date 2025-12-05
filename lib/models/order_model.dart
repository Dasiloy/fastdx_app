import "dart:math";

import 'package:fastdx_app/core/core.dart';
import 'package:fastdx_app/helpers/helpers.dart';
import 'package:fastdx_app/models/delivery_address_model.dart';
import 'package:fastdx_app/models/order_item_model.dart';
import 'package:fastdx_app/models/resturant_model.dart';
import 'package:fastdx_app/models/rider_model.dart';
import 'package:fastdx_app/models/transaction_model.dart';
import 'package:fastdx_app/models/user_model.dart';

class AppOrder implements EntityInterface {
  @override
  final String id;
  final String orderId;

  final double tax;
  final double discount;
  final double subtotal;
  final double deliveryFee;

  final List<OrderItem> items;

  final DateTime createdAt;

  final OrderStatusEnum status;
  final OrderDeliveryModeEnum deliveryMode;
  final OrderDeliveryAddress orderDeliveryAddress;

  final RiderInfo? rider;
  final String? orderNotes;
  final AppUser? customer;
  final DateTime? acceptedAt;
  final DateTime? dispatchedAt;
  final DateTime? completedAt;
  final DateTime? cancelledAt;
  final AppResturant? restaurant;
  final AppTransaction? transaction;
  final String? estimatedDeliveryTime;

  const AppOrder({
    required this.id,
    required this.orderId,
    required this.tax,
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
    required this.items,
    required this.createdAt,
    required this.status,
    required this.deliveryMode,
    required this.orderDeliveryAddress,
    this.restaurant,
    this.customer,
    this.transaction,
    this.rider,
    this.acceptedAt,
    this.dispatchedAt,
    this.completedAt,
    this.cancelledAt,
    this.orderNotes,
    this.estimatedDeliveryTime,
  });

  factory AppOrder.fromJson(Map<String, dynamic> json) {
    return AppOrder(
      id: json["id"],
      orderId: json["orderId"],
      tax: (json["tax"] as num).toDouble(),
      subtotal: (json["subtotal"] as num).toDouble(),
      deliveryFee: (json["deliveryFee"] as num).toDouble(),
      discount: (json["discount"] as num).toDouble(),
      items: List.from(
        json["items"],
      ).map((item) => OrderItem.fromJson(item)).toList(),
      createdAt: DateTime.parse(json["createdAt"]),
      status: OrderStatusEnum.values.firstWhere(
        (stat) => stat.name == json["status"],
      ),
      deliveryMode: OrderDeliveryModeEnum.values.firstWhere(
        (delivery) => delivery.name == json["deliveryMode"],
      ),
      orderDeliveryAddress: OrderDeliveryAddress.fromJson(
        json["orderDeliveryAddress"],
      ),
      acceptedAt: DateTime.tryParse(json["acceptedAt"] ?? ""),
      dispatchedAt: DateTime.tryParse(json["dispatchedAt"] ?? ""),
      completedAt: DateTime.tryParse(json["completedAt"] ?? ""),
      cancelledAt: DateTime.tryParse(json["cancelledAt"] ?? ""),
      orderNotes: json["orderNotes"],
      estimatedDeliveryTime: json["estimatedDeliveryTime"],
      customer: json["customer"] != null
          ? AppUser.fromJson(json["customer"])
          : null,
      restaurant: json["resturant"] != null
          ? AppResturant.fromJson(json["resturant"])
          : null,
      rider: json["rider"] != null ? RiderInfo.fromJson(json["rider"]) : null,
    );
  }

  double get total => subtotal + deliveryFee + tax - discount;

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  bool get isDelivery => deliveryMode == OrderDeliveryModeEnum.delivery;

  bool get isPickup => deliveryMode == OrderDeliveryModeEnum.pickUp;

  bool get isCancelled => status == OrderStatusEnum.cancelled;

  bool get isCompleted => status == OrderStatusEnum.completed;

  bool get isPending => status == OrderStatusEnum.pending;

  bool get isAccepted => status == OrderStatusEnum.accepted;

  bool get isDispatched => status == OrderStatusEnum.dispatched;

  String get formatedDate => Utils.formatDate(createdAt);

  Duration? get processingTime {
    if (acceptedAt == null) return null;
    return acceptedAt!.difference(createdAt);
  }

  Duration? get deliveryTime {
    if (completedAt == null || dispatchedAt == null) return null;
    return completedAt!.difference(dispatchedAt!);
  }

  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  static String get generatedOrderId {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = Random().nextInt(999);

    return '${timestamp.toString().substring(timestamp.toString().length - 4)}${random.toString().padLeft(3, '0')}';
  }

  static List<AppOrder> getRuningOrders(List<AppOrder> orders) {
    return orders
        .where((order) => order.status == OrderStatusEnum.accepted)
        .toList();
  }

  static List<AppOrder> getOrderRequests(List<AppOrder> orders) {
    return orders
        .where((order) => order.status == OrderStatusEnum.pending)
        .toList();
  }
}
