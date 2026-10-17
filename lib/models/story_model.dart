class Story {
  final String id;
  final String title;
  final String icon;
  final String description;
  final String content;
  final String moral;
  final String? imageUrl;

  Story({
    required this.id,
    required this.title,
    required this.icon,
    required this.description,
    required this.content,
    required this.moral,
    this.imageUrl,
  });
}
