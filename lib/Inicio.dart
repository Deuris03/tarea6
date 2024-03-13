import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  TextEditingController _nameController = TextEditingController();
  String _gender = '';
  bool _isLoading = false;

  Future<void> _predictGender() async {
    setState(() {
      _isLoading = true;
    });

    final String name = _nameController.text.trim().toLowerCase();
    final response = await http.get(Uri.parse('https://api.genderize.io/?name=$name'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _gender = data['gender'];
      });
    } else {
      // Handle errors
      print('Error: ${response.statusCode}');
    }

    setState(() {
      _isLoading = false;
    });
  }

  Color _getBackgroundColor() {
    return _gender == 'male' ? Colors.blue : Colors.pink;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Distinguidor de Genero'),
      ),
      body: Container(
        color: Colors.grey[230], // Color gris claro de fondo
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => _predictGender(),
                child: Text('Generar'),
              ),
              SizedBox(height: 16.0),
              _isLoading
                  ? CircularProgressIndicator()
                  : _gender.isNotEmpty
                      ? _gender == 'male'
                          ? Container(
                              color: Colors.blue,
                              height: 100.0,
                            )
                          : Container(
                              color: Colors.pink,
                              height: 100.0,
                            )
                      : SizedBox.shrink(),
              SizedBox(height: 16.0),
              Image.asset('assets/img/Caja_Herramienta.jpeg'),
            ],
          ),
        ),
      ),
    );
  }
}
