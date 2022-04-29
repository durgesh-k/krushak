import 'package:flutter/material.dart';
import 'package:krushak/cards/product.dart';
import 'package:krushak/data/data.dart';
import 'package:krushak/globals.dart';
import 'package:krushak/market/equipments.dart';
import 'package:krushak/market/fertilizers.dart';
import 'package:krushak/market/machinery.dart';
import 'package:krushak/market/others.dart';
import 'package:krushak/market/seeds.dart';

class Market extends StatefulWidget {
  final String? langCode;
  const Market({Key? key, this.langCode}) : super(key: key);

  @override
  State<Market> createState() => _MarketState();
}

class _MarketState extends State<Market> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController? searchValue = TextEditingController();
  double? closeOpacity = 0.0;

  @override
  initState() {
    _tabController = TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            width: getWidth(context),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.grey.shade100),
            child: TextField(
              controller: searchValue,
              style: TextStyle(fontFamily: 'Regular', color: secondary),
              onChanged: (value) async {
                if (value.length != 0) {
                  setState(() {
                    closeOpacity = 1.0;
                  });
                } else {
                  setState(() {
                    closeOpacity = 0.0;
                  });
                }
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(0),
                  suffixIcon: InkWell(
                    onTap: () => searchValue!.clear(),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: AnimatedOpacity(
                          opacity: closeOpacity!,
                          duration: Duration(milliseconds: 400),
                          child: Icon(Icons.close)),
                    ),
                  ),
                  prefixIcon: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(Icons.search)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none),
                  hintStyle: TextStyle(
                      fontFamily: 'Medium',
                      fontSize: 18,
                      color: Colors.grey.shade400),
                  hintText: "Search"),
            ),
          ),
          SizedBox(
            height: 0,
          ),
          Expanded(
            child: DefaultTabController(
              length: 5,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  toolbarHeight: 10,
                  bottom: TabBar(
                    labelStyle: TextStyle(fontFamily: 'Medium', fontSize: 16),
                    unselectedLabelStyle: TextStyle(fontFamily: 'Medium'),
                    labelColor: secondary,
                    unselectedLabelColor: Colors.black.withOpacity(0.2),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 4.0, color: primary!),
                        insets: EdgeInsets.symmetric(horizontal: 16.0)),
                    indicatorColor: primary,
                    isScrollable: true,
                    controller: _tabController,
                    tabs: [
                      Tab(
                        text: 'Fertilizers',
                      ),
                      Tab(
                        text: 'Seeds',
                      ),
                      Tab(
                        text: 'Equipments',
                      ),
                      Tab(
                        text: 'Machinery',
                      ),
                      Tab(text: 'Others')
                    ],
                  ),
                ),
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    Fertilizers(),
                    Seeds(),
                    Equipments(),
                    Machinery(),
                    Others()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
