class EventModel {
  static const String collectionName = 'Events';
  String id;

  String title;

  String description;

  String image;

  String eventName;

  DateTime dateTime;

  String time;

  bool isFavorite;

  String category;
  bool isDone;

  EventModel(
      {this.id = '',
      required this.title,
      required this.description,
      required this.category,
      required this.image,
      required this.eventName,
      required this.dateTime,
      required this.time,
      this.isFavorite = false,
      this.isDone = false});

  //constarctor json => object
  EventModel.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'] as String,
            title: json['title'] as String,
            description: json['description'],
            category: json['category'],
            image: json['image'],
            eventName: json[' eventName'],
            dateTime: json[' dateTime'],
            time: json[' time'],
            isDone: json['isDone'],
            isFavorite: json['isFavorite']);

// object => json
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      " title": title,
      "description": description,
      "category": category,
      "image": image,
      "eventName": eventName,
      "dateTime": dateTime,
      "time": time,
      "isDone": isDone,
      "isFavorite": isFavorite
    };
  }
}
