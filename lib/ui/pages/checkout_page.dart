part of 'pages.dart';

class CheckoutPage extends StatefulWidget {
  final TicketDB ticket;
  final MovieDetail movieDetail;

  CheckoutPage(this.ticket, {this.movieDetail});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  TicketDB ticket;
  DBServices dbServices;

  @override
  void initState() {
    ticket = new TicketDB();
    dbServices = new DBServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double total = 26500;

    return WillPopScope(
        onWillPop: () async {
          context
              .bloc<PageBloc>()
              .add(GoToSelectSeatPage(widget.ticket, widget.movieDetail));

          return;
        },
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                color: accentColor1,
              ),
              SafeArea(
                  child: Container(
                color: Colors.white,
              )),
              ListView(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      // note: BACK BUTTON
                      Row(
                        children: <Widget>[
                          Container(
                            margin:
                                EdgeInsets.only(top: 20, left: defaultMargin),
                            padding: EdgeInsets.all(1),
                            child: GestureDetector(
                              onTap: () {
                                context.bloc<PageBloc>().add(GoToSelectSeatPage(
                                    widget.ticket, widget.movieDetail));
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                    
                      Column(
                        children: <Widget>[
                          // note: PAGE TITLE
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              "Checkout\nMovie",
                              style: blackTextFont.copyWith(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          // note: MOVIE DESCRIPTION
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          2 * defaultMargin -
                                          70 -
                                          20,
                                      child: Text(
                                        widget.ticket.movieDetail,
                                        style: blackTextFont.copyWith(
                                            fontSize: 18),
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.clip,
                                      )),
                                ],
                              )
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: defaultMargin),
                              child: Divider(
                                color: Color(0xFFE4E4E4),
                                thickness: 1,
                              )),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: defaultMargin),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Order ID",
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                  widget.ticket.bookingCode,
                                  style: whiteNumberFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: defaultMargin),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Cinema",
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.55,
                                  child: Text(
                                    widget.ticket.theater,
                                    textAlign: TextAlign.end,
                                    style: whiteNumberFont.copyWith(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: defaultMargin),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Date & Time",
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                  (widget.ticket.time),
                                  style: whiteNumberFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: defaultMargin),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Seat Numbers",
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.55,
                                  child: Text(
                                    widget.ticket.seats,
                                    textAlign: TextAlign.end,
                                    style: whiteNumberFont.copyWith(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: defaultMargin),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Price",
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                  // "IDR 25.000 x ${widget.ticket.seats.length}",
                                  "IDR 25.000 ",
                                  style: whiteNumberFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: defaultMargin),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Fee",
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                  // "IDR 1.500 x ${widget.ticket.seats.l}",
                                  "IDR 1.500",
                                  style: whiteNumberFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: defaultMargin),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Total",
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                  NumberFormat.currency(
                                          locale: 'id_ID',
                                          decimalDigits: 0,
                                          symbol: 'IDR ')
                                      .format(total),
                                  style: whiteNumberFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 20),
                              child: Divider(
                                color: Color(0xFFE4E4E4),
                                thickness: 1,
                              )),
                          // Padding(
                          //   padding:
                          //       EdgeInsets.symmetric(horizontal: defaultMargin),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: <Widget>[
                          //       Text("Your Wallet",
                          //           style: greyTextFont.copyWith(
                          //               fontSize: 16,
                          //               fontWeight: FontWeight.w400)),
                          //       // Text(
                          //       //   NumberFormat.currency(
                          //       //           locale: 'id_ID',
                          //       //           decimalDigits: 0,
                          //       //           symbol: 'IDR ')
                          //       //       .format(user.balance),
                          //       //   style: whiteNumberFont.copyWith(
                          //       //       color: user.balance >= total
                          //       //           ? Color(0xFF3E9D9D)
                          //       //           : Color(0xFFFF5C83),
                          //       //       fontSize: 16,
                          //       //       fontWeight: FontWeight.w600),
                          //       // )
                          //     ],
                          //   ),
                          // ),

                          //! Alternatif button
                          // InkWell(

                          //   // child: Container(
                          //   //   height: 40.0,
                          //   //   margin: EdgeInsets.all(10),
                          //   //   width: 100,
                          //   //   color: Colors.blueAccent,
                          //   //   child: Center(
                          //   //     child: Text(
                          //   //       "Save Product",
                          //   //       style: TextStyle(
                          //   //         color: Colors.white,
                          //   //         fontWeight: FontWeight.bold,
                          //   //       ),
                          //   //     ),
                          //   //   ),
                          //   // ),
                          // ),

                          InkWell(
                              onTap: () {
                                print(widget.ticket.toMap());

                                dbServices
                                    .addTransaction(TicketDB(
                                        id: widget.ticket.id,
                                        movieDetail: widget.ticket.movieDetail,
                                        theater: widget.ticket.theater,
                                        time: widget.ticket.time,
                                        bookingCode: widget.ticket.bookingCode,
                                        seats: widget.ticket.seats,
                                        totalSeats: widget.ticket.totalSeats,
                                        name: widget.ticket.name,
                                        totalPrice: total.toDouble()))
                                    .then((value) {
                                  ConfirmDialog.showMessage(
                                      context, "Ticket", "Successfully", "OK",
                                      () {
                                    context.bloc<PageBloc>().add(GoToHome());
                                  });
                                });
                              },
                              child: Container(
                                width: 250,
                                height: 46,
                                margin: EdgeInsets.only(top: 36, bottom: 50),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: mainColor),
                                child: Center(
                                  child: Text(
                                    "Checkout Now",
                                    style: whiteTextFont.copyWith(fontSize: 16),
                                  ),
                                ),
                              )

                              // if (user.balance >= total) {
                              //   FlutixTransaction transaction =
                              //       FlutixTransaction(
                              //           userID: user.id,
                              //           title: widget
                              //               .ticket.movieDetail.title,
                              //           subtitle:
                              //               widget.ticket.theater.name,
                              //           time: DateTime.now(),
                              //           amount: -total,
                              //           picture: widget.ticket
                              //               .movieDetail.posterPath);

                              //   context.bloc<PageBloc>().add(
                              //       GoToSuccessPage(
                              //           widget.ticket.copyWith(
                              //               totalPrice: total),
                              //           transaction));
                              // } else {
                              //   // # Uang tidak cukup
                              // }
                              ),
                        ],
                      )
                      //   },
                      // ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
