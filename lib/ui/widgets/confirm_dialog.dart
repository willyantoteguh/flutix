part of 'widgets.dart';

class ConfirmDialog {
  static void showMessage(BuildContext context, String title, String message,
      String buttonText, Function onPressed,
      {bool isConfirmationDialog = false,
      String buttonText2 = "",
      Function onPressed2}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title, style: boldTextFont,),
          content: new Text(message, style: blackTextFont),
          actions: [
            Visibility(
              visible: isConfirmationDialog,
              child: new FlatButton(
                onPressed: () {
                  return onPressed2();
                },
                child: new Text(buttonText2,),
              ),
            ),
            new FlatButton(
              onPressed: () {
                return onPressed();
              },
              child: new Text(buttonText),
            ),
          ],
        );
      },
    );
  }
}
