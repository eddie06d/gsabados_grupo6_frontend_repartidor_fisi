import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final user;

  const CustomDrawer({
    Key? key,
    required this.user
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(user['nombre']),
            accountEmail: Text(user['correo']),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                user['nombre'].toString().substring(0, 2).toUpperCase(), 
                style: const TextStyle(
                  fontSize: 40
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text(
              "Inicio",
              style: TextStyle(color: Colors.black),
            ),
            onTap: () => Navigator.pushNamed(context, 'home', arguments: user),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Mi Cuenta"),
            onTap: () => Navigator.pushNamed(context, 'profile', arguments: user),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text("Mis Pedidos"),
            onTap: () => Navigator.pushNamed(context, 'pedidos', arguments: user),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Cerrar Sesión"),
            onTap: () => Navigator.pushNamed(context, 'login'),
          )
        ],
      ),
    );
  }
}
