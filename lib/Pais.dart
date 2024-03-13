import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Vista_Pais extends StatelessWidget {
  const Vista_Pais({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaisScreen(),
    );
  }
}

class PaisScreen extends StatefulWidget {
  const PaisScreen({Key? key});

  @override
  _PaisScreenState createState() => _PaisScreenState();
}

class _PaisScreenState extends State<PaisScreen> {
  TextEditingController _paisController = TextEditingController();
  List<Universidad> universidades = [];

  Future<void> obtenerUniversidades(String pais) async {
    String apiUrl = 'http://universities.hipolabs.com/search?country=$pais';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          universidades = data
              .map((universidad) => Universidad.fromJson(universidad))
              .toList();
        });
      } else {
        print('Error al obtener universidades: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error al obtener universidades: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Universidades por País'),
      ),
      backgroundColor: Colors.grey[230],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              color: Colors.red,
              width: 2.0,
            ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color.fromRGBO(238, 92, 92, 1),
                  const Color.fromRGBO(129, 155, 255, 1),
                ],
                stops: [0, 1.0],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _paisController,
                decoration: InputDecoration(
                  labelText: 'Ingrese el país en inglés',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  obtenerUniversidades(_paisController.text.trim());
                },
                child: const Text('Obtener Universidades'),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 235.0, 
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: universidades.length,
                  itemBuilder: (context, index) {
                    final universidad = universidades[index];
                    return Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text(universidad.nombre),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Dominio: ${universidad.dominio}'),
                            Text('Enlace: ${universidad.enlaceWeb}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Universidad {
  final String nombre;
  final String dominio;
  final String enlaceWeb;

  Universidad({
    required this.nombre,
    required this.dominio,
    required this.enlaceWeb,
  });

  factory Universidad.fromJson(Map<String, dynamic> json) {
    return Universidad(
      nombre: json['name'],
      dominio: json['domains'][0],
      enlaceWeb: json['web_pages'][0],
    );
  }
}
