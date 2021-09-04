part of 'widgets.dart';

class UpdateDbWidget extends StatefulWidget {
  UpdateDbWidget({Key key, this.model, this.isEditMode = false})
      : super(key: key);
  TicketDB model;
  bool isEditMode;

  @override
  _UpdateDbWidgetState createState() => _UpdateDbWidgetState();
}

class _UpdateDbWidgetState extends State<UpdateDbWidget> {
  TicketDB model;
  DBServices dbService;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    dbService = new DBServices();
    model = new TicketDB();

    if (widget.isEditMode) {
      model = widget.model;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Form(
        key: globalFormKey,
        child: _formUI(),
      ),
    );
  }

  Widget _formUI() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: defaultMargin),
      child:
          // FormHelper.fieldLabel("Product Name"),
          // FormHelper.textInput(
          //   context,
          //   model.movieDetail,
          //   (value) => {
          //     this.model.movieDetail = value,
          //   },
          //   onValidate: (value) {
          //     if (value.toString().isEmpty) {
          //       return 'Please enter Product Name.';
          //     }
          //     return null;
          //   },
          // ),
          // FormHelper.fieldLabel("Time"),
          // FormHelper.textInput(
          //     context,
          //     model.time,
          //     // model.time.substring(11, 16),
          //     (value) => {
          //           this.model.time = value,
          //         },
          //     isTextArea: true, onValidate: (value) {
          //   return null;
          // }),
          // FormHelper.fieldLabel("Total Price"),
          // FormHelper.textInput(
          //   context,
          //   model.totalPrice,
          //   (value) => {
          //     this.model.totalPrice = double.parse(value),
          //   },
          //   isNumberInput: true,
          //   onValidate: (value) {
          //     if (value.toString().isEmpty) {
          //       return 'Please enter price.';
          //     }

          //     if (value.toString().isNotEmpty &&
          //         double.parse(value.toString()) <= 0) {
          //       return 'Please enter valid price.';
          //     }
          //     return null;
          //   },
          // ),
          TicketView(
        backgroundPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        backgroundColor: Color(0xFF8F1299),
        contentPadding: EdgeInsets.symmetric(vertical: 24, horizontal: 0),
        drawArc: false,
        triangleAxis: Axis.vertical,
        borderRadius: 6,
        drawDivider: true,
        trianglePos: .5,
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                  child: Text('Update Ticket',
                      style: boldTextFont.copyWith(fontSize: 20))),
              SizedBox(height: defaultMargin),
              Text(model.movieDetail),
              SizedBox(height: 5),
              Text(model.theater),
              SizedBox(height: 5),
              Text(model.bookingCode),
              SizedBox(height: 5),
              Text(model.time),
              SizedBox(height: 5),
              Text(model.seats),
              Container(
                margin: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width / 3),
                child: FormHelper.textInput(
                  context,
                  model.totalSeats,
                  (value) => {
                    this.model.totalSeats = int.parse(value),
                  },
                  isNumberInput: true,
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return 'Please enter total seats.';
                    }

                    if (value.toString().isNotEmpty &&
                        double.parse(value.toString()) <= 0) {
                      return 'Please enter your valid total seats.';
                    }

                     if (value.toString().isNotEmpty &&
                        double.parse(value.toString()) > 3) {
                      return 'Max 3 seats.';
                    }
                    return null;
                  },
                ),
              ),
              Text(
                '*Add more seats here..',
                style: greyTextFont.copyWith(fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 15),
              btnSubmit(),
            ],
          ),
        ),
      ),

      // _productCategory(),
      // FormHelper.fieldLabel("Select Product Photo"),
      // FormHelper.picPicker(
      //   model.,
      //   (file) => {
      //     setState(
      //       () {
      //         model.productPic = file.path;
      //       },
      //     )
      //   },
      // ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Widget btnSubmit() {
    return new Align(
      alignment: Alignment.center,
      child: InkWell(
          onTap: () {
            if (validateAndSave()) {
              print(model.toMap());
              if (widget.isEditMode) {
                dbService.updateTheaters(model).then((value) {
                  FormHelper.showMessage(
                    context,
                    "Update Ticket",
                    "Successfully Updated",
                    "Ok",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                  );
                });
              }
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 60),
            width: double.infinity,
            height: 46,
            margin: EdgeInsets.symmetric(horizontal: 60),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: mainColor),
            child: Center(
              child: Text(
                "Save",
                style: whiteTextFont.copyWith(fontSize: 16),
              ),
            ),
          )),
    );
  }
}
