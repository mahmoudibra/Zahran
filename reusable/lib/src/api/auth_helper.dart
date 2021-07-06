part of api_helpers;

abstract class IAuthenticated {
  bool get authenticated;
}

abstract class AuthProvider<TUser extends IAuthenticated> {
  Future<Map<String, String>> getAuthHeaders(Uri uri);
  Future<void> authenticateUser(TUser data);
  Future<void> removeUserData();
  Future<TUser> getUserData();
}
