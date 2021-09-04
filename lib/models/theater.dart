part of 'models.dart';

class Theater extends DataModel {
static String table = 'theater';

  int idTheater;
  String name;

  Theater({this.idTheater, @required this.name});

  static Theater fromMap(Map<String, dynamic> map) {
    return Theater(
      idTheater: map['id'], 
      name: map['name']);
  } 

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name' : name
    };

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
  // @override
  // List<Object> get props => [name];
}

List<Theater> dummyTheaters = [
  Theater(name: "CGV Royal Plaza"),
  Theater(name:"CGV Galaxy Mall"),
  Theater(name:"XXI Ciputra World"),
  Theater(name:"XXI Pakuwon Trade Center")
];
