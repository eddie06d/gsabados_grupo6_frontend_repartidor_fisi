import 'package:batery_app_repartidor/models/pedido_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PedidosScreen extends StatefulWidget {
  const PedidosScreen({Key? key}) : super(key: key);

  @override
  State<PedidosScreen> createState() => _PedidosScreenState();
}

class _PedidosScreenState extends State<PedidosScreen> {
  List<Pedido> pedidos = []; // Lista de pedidos
  
  Future<List<Pedido>> getPedidos(String idRepartidor) async {
    var url = Uri.parse('https://us-central1-battery-app-api.cloudfunctions.net/app/api/pedidos');
    var response = await http.get(url);
    var datos = json.decode(response.body);
    var pedidosArr = <Pedido>[];
    for (var pedido in datos) {
      var pedidoObj = Pedido.fromJson(pedido);
      if(pedidoObj.repartidorId == idRepartidor) {
        pedidosArr.add(pedidoObj);
      }
    }
    return pedidosArr;
  }

  @override
  Widget build(BuildContext context) {
    final repartidor = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar( 
        title: const Text('Mis Pedidos'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getPedidos(repartidor['repartidor_id']),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData) {
              pedidos = snapshot.data;
              if(pedidos.isNotEmpty) {
                return Column(
                  children: [
                    for(var pedido in pedidos)
                      Card(
                        child: ListTile(
                          title: Text(pedido.estadoEntrega),
                          subtitle: Text(pedido.estadoPago),
                          trailing: Text(pedido.fecha),
                        ),
                      ),
                  ],
                );
              } else {
                return const Center(
                  child: Text('No tienes pedidos'),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}