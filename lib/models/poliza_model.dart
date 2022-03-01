import 'package:assurance/models/auto_model.dart';

class Poliza {
  String id = '';
  String aseguradora = '';
  Auto auto;
  String clienteID = '';
  String clienteNombre = '';
  String cobertura = '';
  String estatus = '';
  String fechaEmision = '';
  String fechaInicio = '';
  String fechaPago = '';
  String fechaTerminacion = '';
  String formaPago = '';
  String inciso = '';
  String montoTotal = '';
  String numero = '';
  String ramo = '';
  //From Excel
  String clienteCorreo = '';
  String clienteFechaNacimiento = '';
  String clienteRFC = '';
  String clienteTelefono = '';
  String ejecutivo = '';
  String from = '';

  Poliza();
  Poliza.fromJson(String key, Map value) {
    id = key;
    if (value['aseguradora'] != null) {
      aseguradora = value['aseguradora'];
    }
    if (value['auto'] != null) {
      auto = Auto.fromJson(value['auto']);
    }
    if (value['clienteID'] != null) {
      clienteID = value['clienteID'];
    }
    if (value['clienteNombre'] != null) {
      clienteNombre = value['clienteNombre'];
    }
    if (value['cobertura'] != null) {
      cobertura = value['cobertura'];
    }
    if (value['ejecutivo'] != null) {
      ejecutivo = value['ejecutivo'];
    }
    if (value['estatus'] != null) {
      estatus = value['estatus'];
    }
    if (value['fechaEmision'] != null) {
      fechaEmision = value['fechaEmision'];
    }
    if (value['fechaInicio'] != null) {
      fechaInicio = value['fechaInicio'];
    }
    if (value['fechaPago'] != null) {
      fechaPago = value['fechaPago'];
    }
    if (value['fechaTerminacion'] != null) {
      fechaTerminacion = value['fechaTerminacion'];
    }
    if (value['formaPago'] != null) {
      formaPago = value['formaPago'];
    }
    if (value['from'] != null) {
      from = value['from'];
    }
    if (value['inciso'] != null) {
      inciso = value['inciso'];
    }
    if (value['montoTotal'] != null) {
      montoTotal = value['montoTotal'];
    }
    if (value['numero'] != null) {
      numero = value['numero'];
    }
    if (value['ramo'] != null) {
      ramo = value['ramo'];
    }
    if (value['clienteCorreo'] != null) {
      clienteCorreo = value['clienteCorreo'];
    }
    if (value['clienteFechaNacimiento'] != null) {
      clienteFechaNacimiento = value['clienteFechaNacimiento'];
    }
    if (value['clienteRFC'] != null) {
      clienteRFC = value['clienteRFC'];
    }
    if (value['clienteTelefono'] != null) {
      clienteTelefono = value['clienteTelefono'];
    }
  }
}
