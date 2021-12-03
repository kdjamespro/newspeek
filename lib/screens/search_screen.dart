import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_peek/screens/search_results.dart';
import 'categories/category_screen.dart';

import '../model/category.dart';
import '../utilities/fonts.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with SingleTickerProviderStateMixin {
  late TextEditingController _controller;
  late TabController _tabController;
  late ScrollController _scrollController;
  List<Widget> screens = [
    CategoryPage(
      category: 'business',
    ),
    CategoryPage(
      category: 'entertainment',
    ),
    CategoryPage(
      category: 'general',
    ),
    CategoryPage(
      category: 'health',
    ),
    CategoryPage(
      category: 'science',
    ),
    CategoryPage(
      category: 'sports',
    ),
    CategoryPage(
      category: 'technology',
    ),
  ];

  _smoothScrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(0,
          duration: Duration(microseconds: 300), curve: Curves.ease);
    }
  }

  @override
  void initState() {
    _controller = TextEditingController();
    _scrollController = ScrollController();
    _tabController = TabController(length: categories.length, vsync: this);
    _tabController.addListener(_smoothScrollToTop);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _controller.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverToBoxAdapter(
                child: searchCard(),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0),
                        border: Border(
                            bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.8,
                        ))),
                    child: TabBar(
                      labelPadding: EdgeInsets.only(right: 0, left: 0),
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.label,
                      isScrollable: true,
                      indicatorPadding: const EdgeInsets.all(0),
                      indicator: const UnderlineTabIndicator(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                        insets: EdgeInsets.only(left: 0, right: 14, top: 10),
                      ),
                      labelColor: Colors.black,
                      labelStyle: labelCategories,
                      unselectedLabelColor: Colors.black38,
                      unselectedLabelStyle: unselectedLabelCategories,
                      tabs: List.generate(
                          categories.length,
                          (index) => Padding(
                                padding: const EdgeInsets.only(
                                    right: 16.0, bottom: 12.0),
                                child: Text(categories[index].name),
                              )),
                    ),
                  ),
                ),
              )
            ];
          },
          body: Container(
            child: TabBarView(
              controller: _tabController,
              children: screens,
            ),
          ),
        ),
      ),
    );
  }

  Widget searchCard() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Icon(Icons.search),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: _controller.clear,
                      ),
                    ),
                    onSubmitted: (String entered) async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SearchResults(keyword: entered);
                          },
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
