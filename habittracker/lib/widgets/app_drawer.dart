import 'package:flutter/material.dart';
import '../db/auth_helper.dart';
import 'package:habittracker/login_page.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String? username;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final user = await AuthHelper.instance.getLoggedInUsername();
    setState(() {
      username = user;
    });
  }

  void _logout() async {
    await AuthHelper.instance.logoutUser();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(username ?? 'Guest'),
            accountEmail: const Text(''),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Text(
                username != null ? username![0].toUpperCase() : '?',
                style: const TextStyle(fontSize: 28, color: Colors.black),
              ),
            ),
            decoration: BoxDecoration(color: Colors.black),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: _logout,
          ),
        ],
      ),
    );
  }
}

