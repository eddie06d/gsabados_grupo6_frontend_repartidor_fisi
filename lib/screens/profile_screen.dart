import 'package:batery_app_repartidor/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  String textBtn = 'Actualizar datos';
  bool isEnabled = false;

  /* @override
  void initState() {
    setState(() {
      _userController.text = 'EddieHs06';
      _passwordController.text = '123456';
      _emailController.text = 'ejhuancahuire@gmail.com';
      _telefonoController.text = '2934567';
    });
    super.initState();
  } */

  @override
  Widget build(BuildContext context) {
    final repartidor = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _userController.text = repartidor['nombre'];
    _emailController.text = repartidor['correo'];
    _telefonoController.text = repartidor['telefono'];
    _passwordController.text = repartidor['clave'];

    return Scaffold(
      appBar: AppBar(  
        title: const Text('Mi Cuenta'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(user: repartidor,),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('http://assets.stickpng.com/images/585e4beacb11b227491c3399.png'),
            ),
            const SizedBox(height: 15),
            TextField(
              enabled: isEnabled,
              controller: _userController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                hintText: 'Ingrese su nombre',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              enabled: isEnabled,
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                hintText: 'Ingrese su contraseña',
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              enabled: isEnabled,
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Ingrese su email',
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              enabled: isEnabled,
              controller: _telefonoController,
              decoration: InputDecoration(
                labelText: 'Telefono',
                hintText: 'Ingrese su telefono',
                prefixIcon: const Icon(Icons.home),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            const SizedBox(height: 17),
            Container(
              width: double.infinity,
              child: MaterialButton(
                color: const Color(0xffFC6B68),
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(textBtn,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  )),
                onPressed: () {
                  setState(() {
                    if(textBtn == 'Actualizar datos') {
                      isEnabled = true;
                      textBtn = 'Guardar cambios';
                    } else {
                      isEnabled = false;
                      textBtn = 'Actualizar datos';
                    }
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}