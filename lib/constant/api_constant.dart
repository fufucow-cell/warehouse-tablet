enum EnumApiInfo {
  userLogin('auth/login', EnumApiMethod.post),
  userRegister('auth/register', EnumApiMethod.post),
  userLogout('auth/logout', EnumApiMethod.post),
  tokenRefresh('auth/refresh', EnumApiMethod.post),
  forgotPassword('auth/forgot-password', EnumApiMethod.post),
  resetPassword('auth/reset-password', EnumApiMethod.post),
  homeCreate('home', EnumApiMethod.post),
  homeFetch('home', EnumApiMethod.get),
  homeModify('home', EnumApiMethod.put),
  homeDelete('home', EnumApiMethod.delete),
  roomCreate('room', EnumApiMethod.post),
  roomFetch('room', EnumApiMethod.get),
  roomModify('room', EnumApiMethod.put),
  roomDelete('room', EnumApiMethod.delete);

  const EnumApiInfo(this.path, this.method);
  final String path;
  final EnumApiMethod method;
}

enum EnumApiMethod {
  get,
  post,
  put,
  delete;

  String get value => name.toUpperCase();
}
