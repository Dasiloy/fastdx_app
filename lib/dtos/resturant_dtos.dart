class CreateResturantDto {
  final String id;
  final String name;

  const CreateResturantDto({required this.name, required this.id});

  Map<String, dynamic> get toMap {
    return {"name": name};
  }
}
