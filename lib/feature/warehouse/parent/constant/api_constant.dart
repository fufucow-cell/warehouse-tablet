enum EnumApiInfo {
  itemCreate('item', EnumApiMethod.post),
  itemFetch('item', EnumApiMethod.get),
  itemModify('item', EnumApiMethod.put),
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
