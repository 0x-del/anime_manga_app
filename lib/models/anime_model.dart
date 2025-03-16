class Anime {
  final String title;
  final String imageUrl;
  final double score; // ✅ make sure this line exists

  Anime({required this.title, required this.imageUrl, required this.score});

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      title: json['title'] ?? 'No Title',
      imageUrl: json['images']['jpg']['image_url'] ?? '',
      score: (json['score'] ?? 0).toDouble(), // ✅ ensure this matches the API
    );
  }
}
