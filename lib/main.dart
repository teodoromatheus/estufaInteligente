import 'package:flutter/material.dart';
import 'home_page.dart';
import 'automatico_page.dart';
import 'manual_page.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      home: AppEstufa(),
    ),
  );
}

class AppEstufa extends StatefulWidget {
  const AppEstufa({Key? key}) : super(key: key);

  @override
  State<AppEstufa> createState() => _AppEstufaState();
}

class _AppEstufaState extends State<AppEstufa> {
  int _paginaSelecionada = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Estufa Inteligente ',
              style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 28,
                  fontWeight: FontWeight.w600),
            ),
            Icon(
              Icons.eco_outlined,
              color: Colors.white,
              size: 35,
            )
          ],
        ),
        backgroundColor: Colors.green[700],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[50],
        currentIndex: _paginaSelecionada,
        selectedItemColor: Colors.green[700],
        selectedLabelStyle: TextStyle(fontFamily: 'Outfit'),
        onTap: (pagina){
          setState((){
            _paginaSelecionada = pagina;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Página Inicial'),
          BottomNavigationBarItem(
              icon: Icon(Icons.autorenew), label: 'Automatico'),
          BottomNavigationBarItem(
              icon: Icon(Icons.back_hand_sharp), label: 'Manual')
        ],
      ),
      body: IndexedStack(
        index: _paginaSelecionada,
        children: [
          HomePage(),
          AutomaticoPage(),
          ManualPage()
        ],
      ),
    );
  }
}