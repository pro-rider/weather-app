import 'package:flutter/material.dart';
import 'package:faker/faker.dart' as faker; // Use alias for faker
import 'package:simple_page/news_app/models/news.dart';

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Changed from News to Article
    final news = ModalRoute.of(context)!.settings.arguments as Article;
    final fakerInstance = faker.Faker(); // Use the alias

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.network( // Changed to Image.network for API images
                news.urlToImage ?? 'assets/placeholders/rugby11.jpg', // Changed to urlToImage
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/placeholders/rugby1.jpg',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  );
                },
              ),
              Positioned(
                top: 40,
                left: 10,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  news.title?.toUpperCase() ?? 'NO TITLE', // Null safety
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  news.description ?? 'No Description', // Null safety
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 10),
                Text(
                  news.content ?? fakerInstance.lorem.sentences(10).join(' '), // Use content if available
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/comments');
                  },
                  child: const Text(
                    'View Comments',
                    style: TextStyle(color: Colors.blue, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}