/// ---------------------------------------------------------------------------
/// [EntityInterface]
///
/// An abstract interface that defines the basic structure of an entity.
///
/// Every entity implementing this interface must:
/// 1. Have a getter unique `id` of type [String].
/// 2. Implement `toJson` to serialize the entity into a JSON map.
///
/// Example usage:
/// ```dart
/// class User implements EntityInterface {
///   @override
///   final String id;
///   final String name;
///
///   User({required this.id, required this.name});
///
///   @override
///   Map<String, dynamic> toJson() => {'id': id, 'name': name};
///
///   factory User.fromJson(Map<String, dynamic> data) =>
///       User(id: data['id'], name: data['name']);
/// }
/// ```
/// ---------------------------------------------------------------------------
abstract class EntityInterface {
  String get id; // every class must define this getter;

  const EntityInterface();

  Map<String, dynamic> toJson();
}
