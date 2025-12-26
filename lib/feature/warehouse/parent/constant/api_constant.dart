enum EnumApiInfo {
  // Auth APIs
  userLogin('auth/login', EnumApiMethod.post),
  userRegister('auth/register', EnumApiMethod.post),
  userLogout('auth/logout', EnumApiMethod.post),
  tokenRefresh('auth/refresh', EnumApiMethod.post),
  forgotPassword('auth/forgot-password', EnumApiMethod.post),
  resetPassword('auth/reset-password', EnumApiMethod.post),
  // Home APIs
  homeCreate('home', EnumApiMethod.post),
  homeFetch('home', EnumApiMethod.get),
  homeModify('home', EnumApiMethod.put),
  homeDelete('home', EnumApiMethod.delete),
  // Room APIs
  roomCreate('room', EnumApiMethod.post),
  roomFetch('room', EnumApiMethod.get),
  roomModify('room', EnumApiMethod.put),
  roomDelete('room', EnumApiMethod.delete),
  // Warehouse APIs
  itemCreate('item', EnumApiMethod.post),
  itemFetch('item', EnumApiMethod.get),
  itemUpdateNormal('item/normal', EnumApiMethod.put),
  itemUpdatePosition('item/position', EnumApiMethod.put),
  itemUpdateQuantity('item/quantity', EnumApiMethod.put),
  itemDelete('item', EnumApiMethod.delete),
  cabinetCreate('cabinet', EnumApiMethod.post),
  cabinetFetch('cabinet', EnumApiMethod.get),
  cabinetModify('cabinet', EnumApiMethod.put),
  cabinetDelete('cabinet', EnumApiMethod.delete),
  categoryCreate('category', EnumApiMethod.post),
  categoryFetch('category', EnumApiMethod.get),
  categoryModify('category', EnumApiMethod.put),
  categoryDelete('category', EnumApiMethod.delete),
  logCreate('log', EnumApiMethod.post),
  logFetch('log', EnumApiMethod.get),
  logDelete('log', EnumApiMethod.delete);

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
