/*
Nombre: Deuris Andres Estevez Bueno
Matricula: 2022-0233
*/

import 'package:flutter/material.dart';

class Contratame extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const Contratame();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Información'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color.fromRGBO(238, 92, 92, 1),
                  const Color.fromRGBO(129, 155, 255, 1),
                ],
                stops: [0, 1.0],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(
                      'assets/img/Foto.jpg'), // Reemplaza con la ruta de tu foto
                ),
                const SizedBox(height: 20),
                const Text(
                  ' Deuris Andres Estevez Bueno',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Desarrollador de Software',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Sobre Mí: Sigo Vivo',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  '¡Hola! Soy un amante del Frond-End ',
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 10),
                _buildContactInfo(
                    'Correo Electrónico', 'Deurisamdresestevez@gmail.com'),
                _buildContactInfo('Teléfono', '829-937-9424'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfo(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(value),
        const SizedBox(height: 10),
      ],
    );
  }
}
