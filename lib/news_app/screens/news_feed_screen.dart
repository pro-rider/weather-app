import 'package:flutter/material.dart';
import 'package:faker/faker.dart' as faker; // Use alias for faker
import 'package:simple_page/news_app/models/news.dart';
import 'package:simple_page/news_app/widgets/news_card.dart';

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({super.key});

  @override
  _NewsFeedScreenState createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final faker.Faker fakerInstance = faker.Faker(); // Use the alias

  late List<News> _featuredNews;

  @override
  void initState() {
    super.initState();
    _featuredNews = List.generate(5, (index) => News(
          id: 'featured_$index',
          title: fakerInstance.lorem.sentence(),
          description: fakerInstance.lorem.sentences(2).join(' '),
          imageUrl: 'assets/placeholders/news${index + 1}.jpg',
          timestamp: DateTime.now().toString(),
        ));
    _pageController.addListener(() {
      int nextPage = _pageController.page!.round();
      if (_currentPage != nextPage) {
        setState(() {
          _currentPage = nextPage;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newsList = List.generate(10, (index) => News(
          id: 'news_$index',
          title: fakerInstance.lorem.sentence(),
          description: fakerInstance.lorem.sentences(2).join(' '),
          imageUrl: 'assets/placeholders/news${(index % 5) + 1}.jpg',
          timestamp: DateTime.now().toString(),
        ));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Latest News'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Category Bar
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ['All News', 'Business', 'Politics', 'Tech'].map((tab) {
                  return GestureDetector(
                    onTap: () {},
                    child: Text(
                      tab,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            // Featured News Section
            SizedBox(
              height: 250,
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _featuredNews.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/news_detail', arguments: _featuredNews[index]),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                _featuredNews[index].imageUrl,
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
                            ),
                            Positioned(
                              bottom: 20,
                              left: 20,
                              right: 20,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _featuredNews[index].title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _featuredNews[index].description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_featuredNews.length, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        height: 8.0,
                        width: _currentPage == index ? 12.0 : 8.0,
                        decoration: BoxDecoration(
                          color: _currentPage == index ? Colors.blue : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            // News Feed List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: newsList.length,
              itemBuilder: (context, index) => NewsCard(
                news: newsList[index],
                onTap: () => Navigator.pushNamed(context, '/news_detail', arguments: newsList[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}