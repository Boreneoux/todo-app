class ToDo {
  final int id;
  final String title;
  final String description;
  final String status;

  ToDo({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
  });

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'status': status,
      };
}
