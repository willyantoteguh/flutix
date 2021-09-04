part of 'pages.dart';

class SelectSeatPage extends StatefulWidget {
  final TicketDB ticket;
  final MovieDetail movieDetail;

  SelectSeatPage(this.ticket, this.movieDetail);

  @override
  _SelectSeatPageState createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  List<String> selectedSeats = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          context
              .bloc<PageBloc>()
              .add(GoToSelectSchedulePage(widget.movieDetail));

          return;
        },
        child: Scaffold(
            body: Stack(
          children: <Widget>[
            Container(
              color: mainColor,
            ),
            SafeArea(
              child: Container(color: Colors.white),
            ),
            ListView(
              children: <Widget>[
                // note: HEADER
                Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 20, left: defaultMargin),
                          padding: EdgeInsets.all(1),
                          child: GestureDetector(
                            onTap: () {
                              context.bloc<PageBloc>().add(
                                  GoToSelectSchedulePage(widget.movieDetail));
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 20, right: defaultMargin),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(right: 16),
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    (widget.movieDetail.title == null) ? '' : widget.movieDetail.title,
                                    style: blackTextFont.copyWith(fontSize: 20),
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                    textAlign: TextAlign.end,
                                  )),
                              Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                          image: NetworkImage(imageBaseURL +
                                              'w154' +
                                              widget.movieDetail.posterPath),
                                          fit: BoxFit.cover)))
                            ],
                          ),
                        )
                      ],
                    ),
                    // note: CINEMA SCREEN
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      width: 277,
                      height: 84,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/screen.png"))),
                    ),
                    generateSeats(),
                    SizedBox(height: 30),
                    // note: NEXT BUTTON
                    Align(
                      alignment: Alignment.topCenter,
                      child: FloatingActionButton(
                          elevation: 0,
                          backgroundColor: selectedSeats.length > 0
                              ? mainColor
                              : Color(0xFFE4E4E4),
                          child: Icon(
                            Icons.arrow_forward,
                            color: selectedSeats.length > 0
                                ? Colors.white
                                : Color(0xFFBEBEBE),
                          ),
                          onPressed: selectedSeats.length > 0
                              ? () {
                                  context.bloc<PageBloc>().add(
                                        GoToCheckoutPage(
                                            TicketDB(
                                                id: int.tryParse(
                                                    randomAlphaNumeric(1)
                                                        .toUpperCase()),
                                                movieDetail:
                                                    widget.movieDetail.title,
                                                theater: widget.ticket.theater,
                                                time: widget.ticket.time,
                                                bookingCode:
                                                    randomAlphaNumeric(12)
                                                        .toUpperCase(),
                                                seats: selectedSeats[0].toString(),
                                                totalSeats: selectedSeats.length,
                                                name: widget.ticket.name,
                                                totalPrice: null),
                                            MovieDetail(widget.movieDetail)),
                                      );
                                }
                              : null),
                    ),
                    SizedBox(height: 50)
                  ],
                ),
              ],
            )
          ],
        )));
  }

  Column generateSeats() {
    List<int> numberofSeats = [2, 4, 5, 5, 6];
    List<Widget> widgets = [];

    for (int i = 0; i < numberofSeats.length; i++) {
      widgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            numberofSeats[i],
            (index) => Padding(
                  padding: EdgeInsets.only(
                      right: index < numberofSeats[i] - 1 ? 10 : 0, bottom: 10),
                  child: SelectableBox(
                    "${String.fromCharCode(i + 65)}${index + 1}",
                    width: 40,
                    height: 40,
                    textStyle: whiteNumberFont.copyWith(color: Colors.black),
                    isSelected: selectedSeats
                        .contains("${String.fromCharCode(i + 65)}${index + 1}"),
                    onTap: () {
                      String seatNumber =
                          "${String.fromCharCode(i + 65)}${index + 1}";
                      setState(() {
                        if (selectedSeats.contains(seatNumber)) {
                          selectedSeats.remove(seatNumber);
                        }  else {
                          selectedSeats.add(seatNumber);
                        }
                      });
                    },
                    isEnabled: index == 5,
                  ),
                )),
      ));
    }

    return Column(children: widgets);
  }
}
