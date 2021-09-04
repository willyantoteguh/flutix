part of 'models.dart';

class FlutixTransaction extends DataModel {
  static String table = 'transactions';

  final String userID;
  final String title;
  final String subtitle;
  final int amount;
  final DateTime time;
  final String picture;

  FlutixTransaction(
      {@required this.userID,
      @required this.title,
      @required this.subtitle,
      this.amount = 0,
      @required this.time,
      this.picture});

  // @override
  // List<Object> get props => [userID, title, subtitle, amount, time, picture];

  static FlutixTransaction fromMap(Map<String, dynamic> map) {
    return FlutixTransaction(
        userID: map["userID"],
        title: map['title'],
        subtitle: map['subtitle'],
        time: map['time']);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'userID': userID,
      'title': title,
      'subtitle': subtitle,
      'time': title
    };

    if (id != null) {
      map['userID'] = userID;
    }
    return map;
  }
}
