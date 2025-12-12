class AuthService {
  // later your teammate will turn this into a real singleton with Firebase
  static final AuthService instance = AuthService._internal();
  AuthService._internal();

  // simple in-memory "logged in" flag for now
  bool _loggedIn = false;

  bool get isLoggedIn => _loggedIn;

  Future<void> signIn(String email, String password) async {
    // TODO(Sai): Replace with FirebaseAuth signInWithEmailAndPassword
    await Future.delayed(const Duration(milliseconds: 300));
    _loggedIn = true;
  }

  Future<void> signUp(String email, String password) async {
    // TODO(Sai): Replace with FirebaseAuth createUserWithEmailAndPassword
    await Future.delayed(const Duration(milliseconds: 300));
    _loggedIn = true;
  }

  Future<void> signOut() async {
    // TODO(Sai): Replace with FirebaseAuth signOut
    await Future.delayed(const Duration(milliseconds: 200));
    _loggedIn = false;
  }
}
