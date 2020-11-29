part of 'services.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<SignSignUpResult> signUp(String email, String password,
      String name, List<String> selectedGenres, String selectedLanguage) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User user = result.user.convertToUser(
          name: name,
          selectedGenres: selectedGenres,
          selectedLanguage: selectedLanguage);

      await UserServices.updateUser(user);

      return SignSignUpResult(user: user);
    } catch (e) {
      return SignSignUpResult(message: e.toString().split(',')[1].trim());
    }
  }

  static Future<SignSignUpResult> signIn(String email, String password) async {
    try {AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

        User user = await result.user.fromFireStore(); //Membuat user dari FirebaseUser di result

        return SignSignUpResult(user: user);
        } catch (e){
          return SignSignUpResult(message: e.toString().split(',')[1].trim());
        }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Stream<FirebaseUser> get userStream => _auth.onAuthStateChanged;
}

class SignSignUpResult {
  final User user;
  final String message;

  SignSignUpResult({this.user, this.message});
}
