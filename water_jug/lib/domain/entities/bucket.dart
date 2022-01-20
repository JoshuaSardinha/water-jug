class Bucket {
  // The ID is unnecessary, but it is being used to simulate more realistic queries in the repositories
  // It should also be in a Model, instead of in this Entity, but this is for demonstration purposes
  final int id;
  final int capacity;
  int content;
  final String? name;

  Bucket({ required this.id, required this.capacity, this.content = 0, this.name });
}