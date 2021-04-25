class EventModel {
  final String docId;
  final String title;
  final String description;
  final DateTime startingTime;
  final DateTime endingTime;

  const EventModel({
    this.docId,
    this.title,
    this.description,
    this.startingTime,
    this.endingTime,
  });
}
