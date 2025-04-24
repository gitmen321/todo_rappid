class Task {
  final String id;
  final String title;
  final String description;
  final String ownerId;
  final List<String> sharedWith;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.ownerId,
    this.sharedWith = const [],
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'ownerId': ownerId,
      'sharedWith': sharedWith,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      ownerId: map['ownerId'],
      sharedWith: List<String>.from(map['sharedWith'] ?? []),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}