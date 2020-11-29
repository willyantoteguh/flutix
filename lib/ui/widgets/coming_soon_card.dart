part of 'widgets.dart';

class ComingSoonCard extends StatelessWidget {
  final Movie movie; //parameter
  final Function onTap;

  ComingSoonCard(this.movie, {this.onTap}); //onTap opsional dgn tambahan {}

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
              image: NetworkImage(imageBaseURL + "w500" + movie.posterPath),
              fit: BoxFit.cover)),
    );
  }
}

// Text(movie.title)
