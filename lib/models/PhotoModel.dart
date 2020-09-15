class PhotoModel {
  final String id;
  final String description;
  final String altDescription;
  final String fullUrl;
  final String thumbUrl;
  final String authorName;

  PhotoModel(this.id, this.description, this.altDescription, this.fullUrl,
      this.thumbUrl, this.authorName);

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
        json['id'] as String,
        json['description'] as String,
        json['alt_description'] as String,
        json['urls']['full'] as String,
        json['urls']['thumb'] as String,
        json['user']['name'] as String
    );
  }
}