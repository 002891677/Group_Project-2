class AppUser {
  final String uid;
  final String? email;

  const AppUser({required this.uid, this.email});
}

class AuthService {
  AuthService._internal();
  static final AuthService instance = AuthService._internal();

  bool _loggedIn = false;
  AppUser? _user;

  bool get isLoggedIn => _loggedIn;

  // ✅ This is what your services are expecting
  AppUser? get currentUser => _user;

  Future<void> signIn(String email, String password) async {
    // TODO: Replace with FirebaseAuth signInWithEmailAndPassword
    _loggedIn = true;
    _user = AppUser(uid: 'demo-user', email: email);
  }

  Future<void> signUp(String email, String password) async {
    // TODO: Replace with FirebaseAuth createUserWithEmailAndPassword
    _loggedIn = true;
    _user = AppUser(uid: 'demo-user', email: email);
  }

  Future<void> signOut() async {
    // TODO: Replace with FirebaseAuth signOut
    _loggedIn = false;
    _user = null;
  }
}
