class GetNews {
  final int id;
  final String cover;
  final String title;
  final String portalLogo;
  final String portalTitle;
  final String category;
  final int likes;
  final int comments;
  final String description;

  GetNews(this.id, this.cover, this.title, this.portalLogo, this.portalTitle, this.category, this.likes, this.comments, this.description);

  factory GetNews.fromJson(json) {
    return GetNews(
      json['id'] as int,
      json['image'] as String,
      json['title'] as String,
      json['author']['avatar'] as String,
      json['author']['name'] as String,
      json['category']['title'] as String,
      json['views_count'] as int,
      json['views_count'] as int,
      json['description'] as String,
    );
  }
}
