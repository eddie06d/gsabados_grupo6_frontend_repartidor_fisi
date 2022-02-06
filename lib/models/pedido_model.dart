// To parse this JSON data, do
//
//     final scanModel = scanModelFromJson(jsonString);

import 'dart:convert';

Pedido scanModelFromJson(String str) => Pedido.fromJson(json.decode(str));

String scanModelToJson(Pedido data) => json.encode(data.toJson());

class Pedido {
    Pedido({
        required this.pedidoId,
        required this.fecha,
        required this.monto,
        required this.clienteId,
        required this.estadoPago,
        required this.estadoEntrega,
        required this.repartidorId,
        required this.productos,
    });

    String pedidoId;
    String fecha;
    String monto;
    String clienteId;
    String estadoPago;
    String estadoEntrega;
    String repartidorId;
    List<ProductoPedido> productos;

    factory Pedido.fromJson(Map<String, dynamic> json) => Pedido(
        pedidoId: json["pedido_id"],
        fecha: json["fecha"],
        monto: json["monto"],
        clienteId: json["cliente_id"],
        estadoPago: json["estado_pago"],
        estadoEntrega: json["estado_entrega"],
        repartidorId: json["repartidor_id"],
        productos: List<ProductoPedido>.from(json["productos"].map((x) => ProductoPedido.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "pedido_id": pedidoId,
        "fecha": fecha,
        "monto": monto,
        "cliente_id": clienteId,
        "estado_pago": estadoPago,
        "estado_entrega": estadoEntrega,
        "repartidor_id": repartidorId,
        "productos": List<dynamic>.from(productos.map((x) => x.toJson())),
    };
}

class ProductoPedido {
    ProductoPedido({
        required this.productoId,
        required this.cantidad,
    });

    String productoId;
    String cantidad;

    factory ProductoPedido.fromJson(Map<String, dynamic> json) => ProductoPedido(
        productoId: json["producto_id"],
        cantidad: json["cantidad"].toString(),
    );

    Map<String, dynamic> toJson() => {
        "producto_id": productoId,
        "cantidad": cantidad,
    };
}
