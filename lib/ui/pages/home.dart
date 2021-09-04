part of 'pages.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DBServices dbService;

  @override
  void initState() {
    super.initState();
    dbService = new DBServices();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mainColor,
      child: SafeArea(
        child: new Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Colors.redAccent,
          //   title: Text("SQFLITE CRUD"),
          // ),
          body: _fetchData(context),
        ),
      ),
    );
  }

  Widget _fetchData(BuildContext context) {
    return FutureBuilder<List<TicketDB>>(
      future: dbService.getTickets(),
      builder: (BuildContext context, AsyncSnapshot<List<TicketDB>> tickets) {
        if (tickets.hasData) {
          return _buildUI(tickets.data);
        }

        return CircularProgressIndicator();
      },
    );
  }

  Widget _buildUI(List<TicketDB> tickets) {
    List<Widget> widgets = new List<Widget>();

    widgets.add(
      Column(
        children: [_buildHeader(context), _buildDataTable(tickets)],
      ),
    );

    return Padding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      ),
      padding: EdgeInsets.symmetric(vertical: defaultMargin, horizontal: 0),
    );
  }

  Widget _buildHeader(BuildContext context) =>
      // padding: const EdgeInsets.symmetric(horizontal: 10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
              context.bloc<PageBloc>().add(GoToMainPage());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Icon(Icons.arrow_back_ios),
            ),
          ),
          Center(
            child: Text(
              'My Tickets',
              style: boldTextFont.copyWith(fontSize: 18),
            ),
          ),
        ],
      );

  Widget _buildDataTable(List<TicketDB> model) {
    return DataTable(
      columns: [
        DataColumn(
          label: Text(
            "Title",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            "Price",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            "Seats",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            "Time",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            "Price",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            "Action",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
      sortColumnIndex: 1,
      horizontalMargin: 20,
      rows: model
          .map(
            (data) => DataRow(
              cells: <DataCell>[
                DataCell(
                  Text(
                    (data.movieDetail == null)
                        ? "Untitled Movie"
                        : data.movieDetail,
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    style: blackTextFont.copyWith(fontSize: 12),
                  ),
                ),
                DataCell(
                  Text(
                    (data.theater == null) ? "Unknown Teather" : data.theater,
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    style: blackTextFont.copyWith(fontSize: 12),
                  ),
                ),
                DataCell(
                  Text(
                    (data.totalSeats == null)
                        ? "Empty Seats"
                        : data.totalSeats.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    style: blackTextFont.copyWith(fontSize: 12),
                  ),
                ),
                DataCell(
                  Text(
                    // (data.seats == null) ? "Empty Seats" : data.time.substring(0,16),
                    (data.seats == null) ? "Empty Seats" : data.time,
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    style: blackTextFont.copyWith(fontSize: 12),
                  ),
                ),
                DataCell(
                  Text(
                      "@ ${priceFormat().format((data.totalPrice == null) ? 2000 : data.totalPrice)}",
                      style: blackTextFont.copyWith(fontSize: 12)),
                ),
                DataCell(
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new IconButton(
                          padding: EdgeInsets.all(0),
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateDbWidget(
                                  isEditMode: true,
                                  model: data,
                                ),
                              ),
                            );
                          },
                        ),
                        new IconButton(
                          padding: EdgeInsets.all(0),
                          icon: Icon(Icons.clear_rounded),
                          onPressed: () {
                            ConfirmDialog.showMessage(
                              context,
                              "Delete Ticket",
                              "Seriously, Sure to delete ?",
                              "Yes",
                              () {
                                dbService.deleteProduct(data).then((value) {
                                  setState(() {
                                    Navigator.of(context).pop();
                                  });
                                });
                              },
                              buttonText2: "No",
                              isConfirmationDialog: true,
                              onPressed2: () {
                                Navigator.of(context).pop();
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
          .toList(),
      columnSpacing: 1.0,
    );
  }

  NumberFormat priceFormat() {
    return NumberFormat.currency(
        locale: 'id', symbol: 'Rp. ', decimalDigits: 0);
  }
}
