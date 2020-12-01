part of 'pages.dart';

class TicketPage extends StatefulWidget {
  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  bool isExpiredTickets = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        // note: CONTENT

        BlocBuilder<TicketBloc, TicketState>(
          builder: (_, ticketState) => Container(
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: TicketViewer(isExpiredTickets
                  ? ticketState.tickets
                      .where((ticket) => ticket.time.isBefore(DateTime.now()))
                      .toList()
                  : ticketState.tickets
                      .where((ticket) => !ticket.time.isBefore(DateTime.now()))
                      .toList())),
        ),
        // note: HEADER
        Container(height: 113, color: accentColor1),
        SafeArea(
          child: ClipPath(
            clipper: HeaderClipper(),
            child: Container(
              height: 113,
              color: accentColor1,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(left: 24, bottom: 32),
                        child: Text(
                          "My Ticket",
                          style: whiteTextFont.copyWith(fontSize: 20),
                        )),
                    Row(children: <Widget>[
                      Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isExpiredTickets = !isExpiredTickets;
                              });
                            },
                            child: Text("Newest",
                                style: whiteTextFont.copyWith(
                                  fontSize: 16,
                                  color: !isExpiredTickets
                                      ? Colors.white
                                      : Color(0xFF6F678E),
                                )),
                          ),
                          SizedBox(height: 15),
                          Container(
                            height: 4,
                            width: MediaQuery.of(context).size.width * 0.5,
                            color: !isExpiredTickets
                                ? accentColor2
                                : Colors.transparent,
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isExpiredTickets = !isExpiredTickets;
                              });
                            },
                            child: Text("Oldest",
                                style: whiteTextFont.copyWith(
                                  fontSize: 16,
                                  color: isExpiredTickets
                                      ? Colors.white
                                      : Color(0xFF6F678E),
                                )),
                          ),
                          SizedBox(height: 15),
                          Container(
                            height: 4,
                            width: MediaQuery.of(context).size.width * 0.5,
                            color: isExpiredTickets
                                ? accentColor2
                                : Colors.transparent,
                          )
                        ],
                      ),
                    ])
                  ]),
            ),
          ),
        )
      ],
    ));
  }
}

class TicketViewer extends StatelessWidget {
  final List<Ticket> tickets;

  TicketViewer(this.tickets);

  @override
  Widget build(BuildContext context) {
    var sortedTickets = tickets;
    sortedTickets
        .sort((ticket1, ticket2) => ticket1.time.compareTo(ticket2.time));

    return ListView.builder(
        itemCount: sortedTickets.length,
        itemBuilder: (_, index) => Container(
              margin: EdgeInsets.only(top: index == 0 ? 133 : 28),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 70,
                    height: 90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: NetworkImage(
                              imageBaseURL +
                                  'w500' +
                                  sortedTickets[index].movieDetail.posterPath,
                            ),
                            fit: BoxFit.cover)),
                  )
                ],
              ),
            ));
  }
}
