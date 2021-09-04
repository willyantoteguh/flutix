part of 'models.dart';

class TicketDB extends DataModel {
  static String table = 'newticket';

  int id;
  String movieDetail;
  String theater;
  String time;
  String bookingCode;
  String seats;
  String name;
  int totalSeats;
  double totalPrice;

  TicketDB(
      {this.id,
      this.movieDetail,
      this.theater,
      this.time,
      this.bookingCode,
      this.seats,
      this.name,
      this.totalSeats,
      this.totalPrice}); //constructor

  // Ticket copyWith(
  //         //method dengan this ambil perubahan data
  //         int id,
  //         MovieDetail movieDetail,
  //         Theater theater,
  //         DateTime time,
  //         String bookingCode,
  //         List<String> seats,
  //         String name,
  //         int totalPrice) =>
  //     Ticket(
  //         id ?? this.id,
  //         movieDetail ?? this.movieDetail,
  //         theater ?? this.theater,
  //         time ?? this.time,
  //         bookingCode ?? this.bookingCode,
  //         seats ?? this.seats,
  //         name ?? this.name,
  //         totalPrice ?? this.totalPrice);

  // String get seatsInString {
  //   String s = '';

  //   for (var seat in seats) {
  //     s += seat + ((seat != seats.last) ? ', ' : '');
  //   }

  //   return s;
  // }

  static TicketDB fromMap(Map<String, dynamic> map) {
    return TicketDB(
        id: map['id'],
        movieDetail: map['movieDetail'],
        theater: map['theater'],
        time: map['time'],
        bookingCode: map['bookingCode'],
        seats: map['seats'],
        name: map['name'],
        totalSeats: map['totalSeats'],
        totalPrice: map['totalPrice']);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'movieDetail': movieDetail,
      'theater': theater,
      'time': time,
      'bookingCode': bookingCode,
      'seats': seats,
      'name': name,
      'totalSeats': totalSeats,
      'totalPrice': totalPrice
    };

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  // @override
  // List<Object> get props => [
  //       movieDetail,
  //       theater,
  //       time,
  //       bookingCode,
  //       seats,
  //       name,
  //       totalPrice
  //     ]; //props
}
