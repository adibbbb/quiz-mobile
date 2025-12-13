class AppUser {
  final String id;
  final String name;
  final String role;
  final String? className;

  AppUser({
    required this.id,
    required this.name,
    required this.role,
    this.className,
  });

  factory AppUser.fromMap(String id, Map<String, dynamic> map) {
    return AppUser(
      id: id,
      name: map['name'],
      role: map['role'],
      className: map['class'],
    );
  }
}
