import 'package:batery_app_repartidor/models/cliente_model.dart';
import 'package:batery_app_repartidor/models/pedido_model.dart';
import 'package:batery_app_repartidor/models/producto_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailsPedidoScreen extends StatefulWidget {
  const DetailsPedidoScreen({Key? key}) : super(key: key);

  @override
  State<DetailsPedidoScreen> createState() => _DetailsPedidoScreenState();
}

class _DetailsPedidoScreenState extends State<DetailsPedidoScreen> {
  Cliente? cliente;
  List<Producto> productos = [];
  List<Producto> prods = [];

  Future<Cliente> getCliente(String id) async {
    var url = Uri.parse('https://us-central1-battery-app-api.cloudfunctions.net/app/api/clientes/$id');
    var response = await http.get(url);
    var datos = json.decode(response.body);
    return Cliente.fromJson(datos);
  }

  Future<List<Producto>> getProductos() async {
    List<Producto> productosArr = [];
    var url = Uri.parse('https://us-central1-battery-app-api.cloudfunctions.net/app/api/productos');
    var response = await http.get(url);
    var datos = json.decode(response.body);
    for(var prod in datos) {
      productosArr.add(Producto.fromJson(prod));
    }
    return productosArr;
  }

  @override
  void initState() {
    super.initState();
    getProductos().then((res) {
      setState(() {
        productos = res;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final pedido =  args['pedido'] as Pedido;
    final repartidor = args['repartidor'] as Map<String, dynamic>;
    //print(repartidor);

    for(var prod in pedido.productos){
      for(var product in productos){
        if(prod.productoId == product.id){
          prods.add(product);
          break;
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del pedido'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 
          20),
          child: Container(
            width: double.infinity,
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Pedido ${pedido.pedidoId}',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Datos generales',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Estado de entrega: ${pedido.estadoEntrega}',
                            style: const TextStyle(
                              fontSize: 15,
                              //fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Estado de pago: ${pedido.estadoPago}',
                            style: const TextStyle(
                              fontSize: 15
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Fecha: ${pedido.fecha}',
                            style: const TextStyle(
                              fontSize: 15
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Monto: ${pedido.monto}',
                            style: const TextStyle(
                              fontSize: 15
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FutureBuilder<Cliente>(
                        future: getCliente(pedido.clienteId),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            cliente = snapshot.data;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'Datos del cliente',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Nombres: ${cliente?.nombre} ${cliente?.apellido}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Correo: ${cliente?.correo}',
                                  style: const TextStyle(
                                    fontSize: 15
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Dirección: ${cliente?.direccion}',
                                  style: const TextStyle(
                                    fontSize: 15
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Teléfono: ${cliente?.telefono}',
                                  style: const TextStyle(
                                    fontSize: 15
                                  ),
                                )
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return const Center(child: CircularProgressIndicator());
                        }, 
                      )
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Datos de los productos',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(height: 10),
                          for(var i=0; i<prods.length; i++)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Producto ${i+1}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Modelo: ${prods[i].modelo}',
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Marca: ${prods[i].marca}',
                                      style: const TextStyle(
                                        fontSize: 15
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Precio: ${prods[i].precio}',
                                  style: const TextStyle(
                                    fontSize: 15
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Descripcion: ${prods[i].descripcion}',
                                  style: const TextStyle(
                                    fontSize: 15
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            )      
                        ],
                      )
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  child: MaterialButton(
                    color: const Color(0xffFC6B68),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                      child: const Text(
                        'Tomar pedido',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        )
                      ),
                    onPressed: pedido.estadoEntrega == 'No entregado' ? () async {
                     /*  var url = Uri.parse('https://us-central1-battery-app-api.cloudfunctions.net/app/api/pedidos/${pedido.pedidoId}');
                      var ped = pedido.toJson();
                      ped['estado_entrega'] = 'entregado';
                      ped['repartidor_id'] = repartidor['repartidor_id'];
                      var res = await http.put(url, body: ped);
                      if(res.statusCode == 200){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Pedido tomado correctamente",),
                        ));
                        Navigator.pushNamed(context, 'home', arguments: repartidor);
                      } */
                    } : null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}