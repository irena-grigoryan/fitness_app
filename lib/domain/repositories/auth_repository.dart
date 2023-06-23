abstract class AuthRepository {
  Future registration(String email, String password);
  Future login(String email, String password);
  Future saveKeys(String? token, String? localId);
  Future resetPassword(String email);
  Future logout();
  Future deactivate();
  Future getToken();
}
