part of 'shared.dart';

const double defaultMargin = 24;

Color mainColor = Color(0xFF8F1299);
Color accentColor1 = Color(0xFF2C1F63);
Color accentColor2 = Color(0xFFFBD460);
Color accentColor3 = Color(0xFFADADAD);

TextStyle blackTextFont = GoogleFonts.montserrat()
    .copyWith(color: Colors.black, fontWeight: FontWeight.w500);

TextStyle whiteTextFont = GoogleFonts.montserrat()
    .copyWith(color: Colors.white, fontWeight: FontWeight.w500);

TextStyle purpleTextFont = GoogleFonts.montserrat()
    .copyWith(color: mainColor, fontWeight: FontWeight.w500);

TextStyle greyTextFont = GoogleFonts.montserrat()
    .copyWith(color: accentColor3, fontWeight: FontWeight.w500);


TextStyle whiteNumberFont = GoogleFonts.openSans()
    .copyWith(color: Colors.white);

TextStyle yellowNumberFont = GoogleFonts.openSans()
    .copyWith(color: accentColor2);

    TextStyle boldTextFont = GoogleFonts.poppins()
    .copyWith(color: Colors.black, fontWeight: FontWeight.w900);