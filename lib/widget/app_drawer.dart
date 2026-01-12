import 'package:flutter/material.dart';
import 'package:food_delivery/admin/admin_login.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.33,
            width: double.infinity,
            color: const Color(0xFF0F0F0F),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40,),
                Image.asset(
                    'images/logo.png',
                    height: 120,
                  ),

                const SizedBox(height: 10),

              ],
            ),
          ),

          ListTile(
            leading: const Icon(Icons.admin_panel_settings),
            title: const Text('Admin Login'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AdminLogin(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
