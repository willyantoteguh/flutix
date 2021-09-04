part of 'pages.dart';

class MoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      // note: Membuat HEADER
      Container(
          decoration: BoxDecoration(
              color: accentColor1,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )),
          padding: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 30),
          child: BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
            if (userState is UserLoaded) {
              if (imageFileToUpload != null) {
                uploadImage(imageFileToUpload).then((downloadURL) {
                  imageFileToUpload = null;
                  context.bloc<UserBloc>().add(
                      UpdateData(profileImage: downloadURL)); //Update Data User
                });
              }

              return Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      context.bloc<PageBloc>().add(GoToProfilePage());
                    },
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Color(0xFF5F5588), width: 1),
                        ),
                        child: Stack(
                          children: <Widget>[
                            SpinKitFadingCircle(
                              color: accentColor2,
                              size: 50,
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: (userState.user.profilePicture ==
                                              ''
                                          ? AssetImage("assets/user_pic.png")
                                          : NetworkImage(
                                              userState.user.profilePicture)),
                                      fit: BoxFit.cover)),
                            )
                          ],
                        )),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width -
                            2 * defaultMargin -
                            50 -
                            12 -
                            16,
                        child: Text(
                          userState.user.name,
                          style: whiteTextFont.copyWith(fontSize: 18),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      Text(
                        NumberFormat.currency(
                                locale: "id_ID",
                                symbol: "IDR ",
                                decimalDigits: 0)
                            .format(userState.user.balance),
                        style: yellowNumberFont.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      )
                    ],
                  )
                ],
              );
            } else {
              return SpinKitFadingCircle(
                color: accentColor2,
                size: 50,
              );
            }
          })),

      // note: TITLE
      Container(
        margin: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
        child: Text("Now Playing",
            style: blackTextFont.copyWith(
                fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      SizedBox(
        height: 140,
        child: BlocBuilder<MovieBloc, MovieState>(builder: (_, movieState) {
          if (movieState is MovieLoaded) {
            List<Movie> movies = movieState.movies.sublist(0, 6);

            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (_, index) => Container(
                      margin: EdgeInsets.only(
                          left: (index == 0) ? defaultMargin : 0,
                          right: (index == movies.length - 1)
                              ? defaultMargin
                              : 16),
                      child: MovieCard(
                        movies[index],
                        onTap: () {
                          context
                              .bloc<PageBloc>()
                              .add(GoToMovieDetailPage(movies[index]));
                        },
                      ),
                    ));
          } else {
            return SpinKitFadingCircle(
              color: mainColor,
              size: 50,
            );
          }
        }),
      ),

      // note: BROWSE MOVIE
      Container(
        margin: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
        child: Text(
          "Browse Movie",
          style:
              blackTextFont.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      BlocBuilder<UserBloc, UserState>(
        builder: (_, userState) {
          if (userState is UserLoaded) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      userState.user.selectedGenres.length,
                      (index) =>
                          BrowseButton(userState.user.selectedGenres[index]))),
            );
          } else {
            return SpinKitFadingCircle(
              color: mainColor,
              size: 50,
            );
          }
        },
      ),

      // note: COMING SOON
      Container(
        margin: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
        child: Text("Coming Soon",
            style: blackTextFont.copyWith(
                fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      SizedBox(
        height: 140,
        child: BlocBuilder<MovieBloc, MovieState>(builder: (_, movieState) {
          if (movieState is MovieLoaded) {
            List<Movie> movies = movieState.movies.sublist(10);

            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: (movies == null)  ? 1 : movies.length,
                itemBuilder: (_, index) => Container(
                      margin: EdgeInsets.only(
                          left: (index == 0) ? defaultMargin : 0,
                          right: (index == movies.length - 1)
                              ? defaultMargin
                              : 16),
                      child: ComingSoonCard(movies[index]),
                    ));
          } else {
            return SpinKitFadingCircle(
              color: mainColor,
              size: 50,
            );
          }
        }),
      ),

      // note: PROMO CARD
      Container(
        margin: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
        child: Text("Get Lucky Day",
            style: blackTextFont.copyWith(
                fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      Column(
        children: dummyPromos
            .map((e) => Padding(
                  padding:
                      EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 16),
                  child: PromoCard(e),
                ))
            .toList(),
      ),
      SizedBox(
        height: 100,
      )
    ]);
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(0, size.height, 20, size.height);
    path.lineTo(size.width - 20, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 20);
    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
