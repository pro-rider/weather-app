import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:simple_page/colors/color_widgets.dart';
import 'package:simple_page/news_app/models/news.dart';
import 'package:simple_page/news_app/nav_screen/profile_details_screen.dart';
import 'package:simple_page/news_app/nav_screen/search_screen.dart';
import 'package:simple_page/news_app/widgets/news_card.dart';
import 'package:simple_page/profile/constants/assets_images.dart';
import 'package:simple_page/profile/widgets/custom_bottom_nav.dart';

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({super.key});

  @override
  _NewsFeedScreenState createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  final ScrollController _verticalScrollController = ScrollController();
  final ScrollController _horizontalScrollController = ScrollController();
  String selectedTab = 'All News';
  String hoveredTab = '';
  int _selectedIndex = 0;
  int _currentPage = 0;

  late Future<News?> _newsFuture; // Store the Future

  @override
  void initState() {
    super.initState();
    _newsFuture = fetchNews(); // Initialize the Future
    _pageController.addListener(_pageChangeListener);
    _verticalScrollController.addListener(_loadMoreNews);
    _horizontalScrollController.addListener(_loadMoreFeaturedNews);
  }

  void _pageChangeListener() {
    if (_pageController.page != null) {
      int nextPage = _pageController.page!.round();
      if (_currentPage != nextPage) {
        setState(() {
          _currentPage = nextPage;
        });
      }
    }
  }

  void _loadMoreNews() {
    if (_verticalScrollController.position.pixels >=
        _verticalScrollController.position.maxScrollExtent - 200) {
      setState(() {
        _newsFuture = fetchNews(); // Refresh for more news
      });
    }
  }

  void _loadMoreFeaturedNews() {
    if (_horizontalScrollController.position.pixels >=
        _horizontalScrollController.position.maxScrollExtent - 200) {
      setState(() {
        _newsFuture = fetchNews(); // Refresh for more featured news
      });
    }
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SearchScreen()));
    } else if (index == 3) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ProfileDetailsScreen()));
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Future<News?> fetchNews() async {
    final dio = Dio();
    try {
      final response = await dio.get(
        "https://saurav.tech/NewsAPI/top-headlines/category/health/in.json",
      );
      if (response.statusCode == 200) {
        return News.fromJson(response.data);
      } else {
        throw Exception("Failed to load news");
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Unable to fetch data. Please check your internet connection.',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
      );
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
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
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: SafeArea(
        child: FutureBuilder<News?>(
          future: _newsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data != null) {
              final news = snapshot.data!;
              final featuredNews = news.articles?.take(5).toList() ?? [];
              final allNews = news.articles ?? [];

              return Column(
                children: [
                  // Category Bar
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: ['All News', 'Business', 'Politics', 'Tech']
                          .map((tab) {
                        bool isSelected = selectedTab == tab;
                        bool isHovered = hoveredTab == tab;
                        return MouseRegion(
                          onEnter: (_) => setState(() => hoveredTab = tab),
                          onExit: (_) => setState(() => hoveredTab = ''),
                          child: GestureDetector(
                            onTap: () => setState(() => selectedTab = tab),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: isSelected || isHovered
                                    ? AppColors.tdYellow
                                    : AppColors.tdBlue1,
                              ),
                              child: Text(
                                tab,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  // Featured News Section
                  SizedBox(
                    height: 280,
                    child: featuredNews.isEmpty
                        ? const Center(child: Text('No featured news available'))
                        : ListView.builder(
                            controller: _horizontalScrollController,
                            scrollDirection: Axis.horizontal,
                            itemCount: featuredNews.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, '/news_detail',
                                    arguments: featuredNews[index]),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          featuredNews[index].urlToImage ??
                                              AssetsImages.placeholder13,
                                          width: double.infinity,
                                          height: 200,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) =>
                                              Image.asset(
                                            AssetsImages.placeholder13,
                                            width: double.infinity,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
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
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                featuredNews[index].title ?? '',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                featuredNews[index]
                                                        .description ??
                                                    '',
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
                          ),
                  ),
                  const Gap(20),

                  // Vertical News Feed
                  Expanded(
                    child: allNews.isEmpty
                        ? const Center(child: Text('No news available'))
                        : ListView.builder(
                            controller: _verticalScrollController,
                            itemCount: allNews.length,
                            itemBuilder: (context, index) {
                              return NewsCard(
                                news: allNews[index],
                                onTap: () => Navigator.pushNamed(
                                    context, '/news_detail',
                                    arguments: allNews[index]),
                              );
                            },
                          ),
                  ),
                ],
              );
            } else {
              return const Center(child: Text('No news available'));
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageChangeListener);
    _pageController.dispose();
    _verticalScrollController.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }
}