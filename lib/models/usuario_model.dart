class Usuario {
  String uid;
  String avatar;
  bool borrado;
  String correo;
  bool correoBirthday;
  bool correoChristmas;
  bool correoNewYear;
  bool correoRecordatorioPagos;
  int fechaCreado;
  int fechaModificado;
  String nombre;
  String rfc;
  String telefono;

  Usuario();
  Usuario.fromJson(String key, Map value) {
    uid = key;
    avatar = value['avatar'];
    borrado = value['borrado'];
    correo = value['correo'];
    correoBirthday = value['correoBirthday'];
    correoChristmas = value['correoChristmas'];
    correoNewYear = value['correoNewYear'];
    correoRecordatorioPagos = value['correoRecordatorioPagos'];
    fechaCreado = value['fechaCreado'];
    fechaModificado = value['fechaModificado'];
    nombre = value['nombre'];
    rfc = value['rfc'];
    telefono = value['telefono'];
  }
}
