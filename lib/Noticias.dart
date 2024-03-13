// ignore_for_file: file_names, library_private_types_in_public_api, avoid_print, use_super_parameters

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';


class NoticiasWordPress extends StatefulWidget {
  const NoticiasWordPress({Key? key}) : super(key: key);

  @override
  _NoticiasWordPressState createState() => _NoticiasWordPressState();
}

class _NoticiasWordPressState extends State<NoticiasWordPress> {
  final String apiUrl = 'https://cnnespanol.cnn.com/wp-json/wp/v2/posts?per_page=3';

  late List<NewsItem> newsItems;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    newsItems = [];
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (mounted) {
        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          setState(() {
            newsItems = data.map((item) => NewsItem.fromJson(item)).toList();
            isLoading = false;
          });
        } else {
          print('Failed to load data. Status code: ${response.statusCode}');
          setState(() {
            isLoading = false;
          });
        }
      }
    } catch (error) {
      print('Error: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WordPress Noticias'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : newsItems.isNotEmpty
              ? ListView.builder(
                  itemCount: newsItems.length,
                  itemBuilder: (context, index) {
                    return NewsCard(newsItems[index]);
                  },
                )
              : const Center(
                  child: Text('No hay noticias disponibles.'),
                ),
    );
  }
}

class NewsItem {
  final String title;
  final String summary;
  final String link;

  NewsItem({
    required this.title,
    required this.summary,
    required this.link,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    final cleanedSummary = _cleanHtmlTags(json['excerpt']['rendered']);
    return NewsItem(
      title: json['title']['rendered'],
      summary: cleanedSummary,
      link: json['link'],
    );
  }

  static String _cleanHtmlTags(String htmlText) {
    return htmlText.replaceAll(RegExp(r'<[^>]*>'), '');
  }
}

class NewsCard extends StatelessWidget {
  final NewsItem newsItem;

  const NewsCard(this.newsItem, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {
          launchUrl(Uri.parse(newsItem.link));
          // Puedes agregar el código para abrir la URL en un navegador aquí
        },
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Color.fromARGB(162, 119, 91, 188),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  newsItem.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 18.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  newsItem.summary,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 16.0,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Leer más',
                  style: TextStyle(
                    color: Color.fromARGB(255, 60, 6, 237),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



