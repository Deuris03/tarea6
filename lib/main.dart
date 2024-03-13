import 'package:flutter/material.dart';
import 'package:tarea6/Clima.dart';
import 'Inicio.dart';
import 'Contactame.dart';
import 'Noticias.dart';
import 'Edad.dart';
import 'Pais.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// ...

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  final List<Widget> _pages = [
    Inicio(),
    Vista_Edad(),
    Vista_Pais(),
    Vista_Clima(),
    NoticiasWordPress(),
    Contratame(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarea 6 (Couteau)'),
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromRGBO(238, 92, 92, 1)!, Color.fromRGBO(129, 155, 255, 1)!],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.white], // Cambiar a blanco
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Text(
                  'Menú',
                  style: TextStyle(
                    color: Colors.black, // Cambiar a negro u otro color según necesites
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.ac_unit),
                title: Text('Genero'),
                onTap: () {
                  _navigateToPage(0);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.table_chart),
                title: Text('Edad'),
                onTap: () {
                  _navigateToPage(1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.analytics),
                title: Text('País'),
                onTap: () {
                  _navigateToPage(2);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.analytics),
                title: Text('Clima'),
                onTap: () {
                  _navigateToPage(3);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.analytics),
                title: Text('Noticias'),
                onTap: () {
                  _navigateToPage(4);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.analytics),
                title: Text('Contactame'),
                onTap: () {
                  _navigateToPage(5);
                  Navigator.pop(context);
                },
              ),
              
            ],
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  void _navigateToPage(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }
}
