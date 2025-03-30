class News {
  final String id;
  final String title;
  final String description; // Ensure this field is present
  final String imageUrl;
  final String timestamp;

  News({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.timestamp,
  });
}
