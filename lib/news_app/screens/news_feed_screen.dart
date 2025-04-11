import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_page/colors/color_widgets.dart';
import 'package:simple_page/news_app/database/sqflte/sqflite_database_manage.dart';
import 'package:simple_page/news_app/models/news.dart';
import 'package:simple_page/news_app/nav_screen/profile_details_screen.dart';
import 'package:simple_page/news_app/nav_screen/search_screen.dart';
import 'package:simple_page/news_app/widgets/news_card.dart';
import 'package:simple_page/profile/widgets/custom_bottom_nav.dart';
import 'dart:async';

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({super.key});

  @override
  _NewsFeedScreenState createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  final ScrollController _verticalScrollController = ScrollController();
  final ScrollController _horizontalScrollController = ScrollController();
  String selectedTab = 'All News';
  String hoveredTab = '';
  int _selectedIndex = 0;
  bool _isLoadingMore = false;
  int _page = 1; // For pagination

  late Future<News?> _newsFuture;
  List<Article> _allArticles = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _newsFuture = fetchNews();
    _verticalScrollController.addListener(_loadMoreNews);
    _horizontalScrollController.addListener(_loadMoreFeaturedNews);
  }

  void _loadMoreNews() {
    if (_verticalScrollController.position.pixels >=
            _verticalScrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore) {
      if (_debounce?.isActive ?? false) return;
      _debounce = Timer(const Duration(milliseconds: 500), () {
        setState(() => _isLoadingMore = true);
        fetchNews(page: _page + 1).then((news) {
          setState(() {
            if (news != null && news.articles != null) {
              _allArticles.addAll(
                  news.articles!.where((newArticle) => !_allArticles.any(
                      (existing) => existing.url == newArticle.url)));
              _page++;
            }
            _isLoadingMore = false;
          });
        }).catchError((e) {
          debugPrint("Load more error: $e");
          setState(() => _isLoadingMore = false);
        });
      });
    }
  }

  void _loadMoreFeaturedNews() {
    if (_horizontalScrollController.position.pixels >=
            _horizontalScrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore) {
      if (_debounce?.isActive ?? false) return;
      _debounce = Timer(const Duration(milliseconds: 500), () {
        setState(() => _isLoadingMore = true);
        fetchNews(page: _page + 1).then((news) {
          setState(() {
            if (news != null && news.articles != null) {
              _allArticles.addAll(
                  news.articles!.where((newArticle) => !_allArticles.any(
                      (existing) => existing.url == newArticle.url)));
              _page++;
            }
            _isLoadingMore = false;
          });
        }).catchError((e) {
          debugPrint("Load more featured error: $e");
          setState(() => _isLoadingMore = false);
        });
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
      setState(() => _selectedIndex = index);
    }
  }

  Future<News?> fetchNews({Dio? dioClient, int page = 1}) async {
    final dio = dioClient ?? Dio();
    String url =
        "https://saurav.tech/NewsAPI/top-headlines/category/health/in.json";
      // "https://saurav.tech/NewsAPI/top-headlines/category/${selectedTab.toLowerCase()}/in.json?page=$page";


    // url = "https://saurav.tech/NewsAPI/top-headlines/category/${selectedTab.toLowerCase()}/in.json?page=$page";
    final prefs = await SharedPreferences.getInstance();

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200 && response.data != null) {
        final news = News.fromJson(response.data);
        await DatabaseHelper.insertNews(news.articles ?? []);
        await prefs.setString('cached_news', jsonEncode(response.data));
        return news;
      } else {
        throw Exception("Unexpected response: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error: $e");
      return await _fetchCachedNews(prefs, e);
    }
  }

  Future<News?> _fetchCachedNews(SharedPreferences prefs, dynamic error) async {
    if (error is DioException) {
      Fluttertoast.showToast(
        msg: 'Network issue: Please check your internet connection.',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Something went wrong. Please try again.',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
      );
    }

    final cachedArticles = await DatabaseHelper.fetchNewsFromDb();
    if (cachedArticles.isNotEmpty) {
      return News(articles: cachedArticles);
    }
    if (prefs.containsKey('cached_news')) {
      final cachedData = jsonDecode(prefs.getString('cached_news')!);
      return News.fromJson(cachedData);
    }
    return null;
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
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${snapshot.error}'),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => setState(() => _newsFuture = fetchNews()),
                    child: const Text('Retry'),
                  ),
                ],
              ));
            } else if (snapshot.hasData && snapshot.data != null) {
              if (_allArticles.isEmpty && snapshot.data!.articles != null) {
                _allArticles = snapshot.data!.articles!;
              }
              final featuredNews = _allArticles.take(5).toList();
              final allNews = selectedTab == 'All News'
                  ? _allArticles
                  : _allArticles
                      .where((article) =>
                          article.source?.name
                              ?.toLowerCase()
                              .contains(selectedTab.toLowerCase()) ??
                          false)
                      .toList(); // Basic filtering (needs API support for accuracy)

              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          'All News',
                          'Business',
                          'Entertainment',
                          'Politics',
                          'Technology',
                          'Health',
                          'Sport'
                        ].map((tab) {
                          bool isSelected = selectedTab == tab;
                          bool isHovered = hoveredTab == tab;
                          return MouseRegion(
                            onEnter: (_) => setState(() => hoveredTab = tab),
                            onExit: (_) => setState(() => hoveredTab = ''),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedTab = tab;
                                  if (tab != 'All News') {
                                    _page = 1;
                                    _allArticles.clear();
                                    _newsFuture = fetchNews();
                                  }
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.symmetric(horizontal: 4),
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
                  ),
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
                                              'assets/placeholders/avatar.jpg',
                                          width: double.infinity,
                                          height: 200,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) => Image.asset(
                                            'assets/placeholders/avatar.jpg',
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
                                                featuredNews[index].description ??
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
                  Expanded(
                    child: allNews.isEmpty
                        ? const Center(child: Text('No news available'))
                        : ListView.builder(
                            controller: _verticalScrollController,
                            itemCount: allNews.length + (_isLoadingMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == allNews.length && _isLoadingMore) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
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
    _verticalScrollController.dispose();
    _horizontalScrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}