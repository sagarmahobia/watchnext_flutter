class ShowCardInputModel {
  final int id;
  final String imageUrl;
  final String backdrop;
  final String title;

  final String type;

  final String vote;
  final int count;
  final DateTime? releaseDate;

  ShowCardInputModel(
    this.id,
    this.imageUrl,
    this.backdrop,
    this.title,
    this.type,
    this.vote,
    this.count,
    this.releaseDate,
  );
}
