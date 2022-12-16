class FeaturedNews {
  final int id;
  final String title;
  final String cover;

  FeaturedNews(this.id, this.title, this.cover);

  factory FeaturedNews.fromJson(json) {
    return FeaturedNews(
      json['id'] as int,
      json['title'] as String,
      json['image'] as String,
    );
  }
}
