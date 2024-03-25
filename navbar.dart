import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Hate Speech Detection'),
      backgroundColor: Colors.deepPurple,
      drawer: Drawer(
        backgroundColor: Colors.deepPurple[100],
        child: const Column(
          children: [
            DrawerHeader(
              child: Icon(
                Icons.account_circle_outlined,
                size: 48,
              ),
            ),
            //List of Nav bar
            //CONTACT
            ListTile(
              leading: Icon(Icons.call),
              title: Text("C O N T A C T"),
              // onTap: (){
              //   Navigator.pushNamed(context, '/contact.dart');
              // },
            ),
            //HISTORY
            ListTile(
              leading: Icon(Icons.history),
              title: Text("HISTORY"),
            ),
            ListTile(
              leading: Icon(Icons.abc),
              title: Text("ABC"),
            )

          ],
        ),
      ),
    );
  }
}
