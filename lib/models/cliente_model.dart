// To parse this JSON data, do
//
//     final cliente = clienteFromJson(jsonString);

import 'dart:convert';

Cliente clienteFromJson(String str) => Cliente.fromJson(json.decode(str));

String clienteToJson(Cliente data) => json.encode(data.toJson());

class Cliente {
    Cliente({
        required this.clienteId,
        required this.nombre,
        required this.apellido,
        required this.correo,
        required this.clave,
        required this.direccion,
        required this.telefono,
    });

    String clienteId;
    String nombre;
    String apellido;
    String correo;
    String clave;
    String direccion;
    String telefono;

    factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        clienteId: json["cliente_id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        correo: json["correo"],
        clave: json["clave"],
        direccion: json["direccion"],
        telefono: json["telefono"],
    );

    Map<String, dynamic> toJson() => {
        "cliente_id": clienteId,
        "nombre": nombre,
        "apellido": apellido,
        "correo": correo,
        "clave": clave,
        "direccion": direccion,
        "telefono": telefono,
    };
}
