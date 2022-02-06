import 'package:batery_app_repartidor/models/pedido_model.dart';
import 'package:batery_app_repartidor/widgets/custom_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Pedido> pedidos = []; // Lista de pedidos
  
  Future<List<Pedido>> getPedidos() async {
    var url = Uri.parse('https://us-central1-battery-app-api.cloudfunctions.net/app/api/pedidos');
    var response = await http.get(url);
    var datos = json.decode(response.body);
    var pedidosArr = <Pedido>[];
    for (var pedido in datos) {
      pedidosArr.add(Pedido.fromJson(pedido));
    }
    return pedidosArr;
  }

  @override
  void initState() {
    super.initState();
    getPedidos().then((value) {
      setState(() {
        pedidos = value;
        //print(pedidos);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final repartidor = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    if(pedidos.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Batery App Repartidor'),
          centerTitle: true,
        ),
        drawer: CustomDrawer(user: repartidor,),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Batery App Repartidor'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(user: repartidor,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 15),
              Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Text('N° pedidos:'),
                      const SizedBox(width: 7),
                      Text(
                        pedidos.length.toString(), 
                        style: const TextStyle(
                          fontSize: 15, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              for(final pedido in pedidos)
                Card(
                  color: pedido.estadoEntrega == 'No entregado' ? const Color(0xffFC6B68) : Colors.green[300],
                  elevation: 3,
                  child: Padding(  
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Pedido ${pedido.pedidoId}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Column(
                              children: [
                                const Text(
                                  'Estado de entrega:',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  pedido.estadoEntrega,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'Estado de pago:',
                                  style: TextStyle(
                                    fontSize: 15,
                                    //fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  pedido.estadoPago,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  'Monto:',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  pedido.monto,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Fecha:',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  pedido.fecha,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                            MaterialButton(
                              color: Colors.amber,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: const Text(
                                'Ver Detalles',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                )
                              ),
                              onPressed: () => Navigator.pushNamed(context, 'details', arguments: {
                                'pedido': pedido,
                                'repartidor': repartidor
                              }),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  )
                )
            ],
          ),
        ),
      )
    );
  }
}