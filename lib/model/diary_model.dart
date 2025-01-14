class DiaryModel {
  int id;
  String title;
  String description;
  DateTime date;
  String? images;

  DiaryModel(this.id, this.title, this.description, this.date, [this.images]);
}
