part of 'models.dart';

class Theater extends Equatable {
  final String name;

  Theater(this.name);

  @override
  List<Object> get props => [name];
}

List<Theater> dummyTheaters = [
  Theater("CGV Royal Plaza"),
  Theater("CGV Galaxy Mall"),
  Theater("XXI Ciputra World"),
  Theater("XXI Pakuwon Trade Center")
];
