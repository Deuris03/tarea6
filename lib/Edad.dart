import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Vista_Edad extends StatelessWidget {
  const Vista_Edad({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AgePredictionScreen(),
    );
  }
}

class AgePredictionScreen extends StatefulWidget {
  const AgePredictionScreen({Key? key});

  @override
  _AgePredictionScreenState createState() => _AgePredictionScreenState();
}

class _AgePredictionScreenState extends State<AgePredictionScreen> {
  String nombre = "";
  int edad = 0;
  String estado = "";

  Future<void> predecirEdad(String name) async {
    String apiUrl = "https://api.agify.io/?name=$name";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      final data = json.decode(response.body);

      setState(() {
        edad = data['age'] ?? 0;
        determinarEstado();
      });
    } catch (error) {
      print('Error al obtener la edad: $error');
    }
  }

  void determinarEstado() {
    if (edad >= 15 && edad <= 24) {
      estado = 'Joven';
    } else if (edad >= 25 && edad <= 59) {
      estado = 'Adulto';
    } else if (edad >= 60) {
      estado = 'Anciano';
    } else {
      estado = 'Edad no clasificada';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predicción de Edad'),
      ),
      backgroundColor: Colors.grey[230], // Color de fondo del Scaffold
      body: Center(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            width: 620,
            height: 620,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNameTextField(),
                const SizedBox(height: 6),
                _buildPredictButton(),
                const SizedBox(height: 10),
                _buildResultText('Estado: $estado'),
                const SizedBox(height: 15),
                _buildImageAndAge(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameTextField() {
    return TextField(
      onChanged: (value) {
        setState(() {
          nombre = value;
        });
      },
      decoration: const InputDecoration(
        labelText: 'Ingrese su nombre',
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }

  Widget _buildPredictButton() {
    return ElevatedButton(
      onPressed: () {
        predecirEdad(nombre);
      },
      child: const Text('Predecir Edad'),
    );
  }

  Widget _buildResultText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18),
    );
  }

  Widget _buildImageAndAge() {
  return SingleChildScrollView(
    child: Container(
      width: 300,
      height: 300, // Ajusta el tamaño de la imagen según tus preferencias
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              _getImagePath(),
              height: 200, // Ajusta el tamaño de la imagen según tus preferencias
            ),
            const SizedBox(height: 10),
            Text(
              'Edad: $edad',
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

  String _getImagePath() {
    switch (estado) {
      case 'Joven':
        return 'assets/img/Joven.jpeg';
      case 'Adulto':
        return 'assets/img/Adulto.jpeg';
      case 'Anciano':
        return 'assets/img/Viejo.jpeg';
      default:
        break;
    }
    return 'assets/img/Viejo.jpeg';
  }
}
