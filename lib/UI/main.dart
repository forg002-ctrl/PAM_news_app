import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:pam_news_app/Domain/listing_featured_news.dart';
import 'package:pam_news_app/Domain/listing_news.dart';

import 'package:pam_news_app/Data/list_news.dart';
import 'package:pam_news_app/Data/featured_news.dart';


import 'package:pam_news_app/UI/pages/detailPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController controller = ScrollController();
  var news = List<ListNews>.empty();

  bool _loadingMore = false;
  bool _hasMoreItems = true;
  int _currentPage = 1;
  final int _newsPerPage = 3;

  @override
  void initState() {
    controller.addListener(_scrollListener);
    _getNews();
    super.initState();
  }

  Future _loadMoreNews() async {
    setState(() {
      _loadingMore = true;
    });
    ListingNews().listNews(_currentPage, _newsPerPage).then((response) {
      news += response;
      if (news.length != _currentPage * _newsPerPage) {
        setState(() {
          _hasMoreItems = false;
          _loadingMore = false;
        });
      } else {
        setState(() {
          _currentPage += 1;
          _loadingMore = false;
        });
      }
    });
  }

  _getNews() async {
    ListingNews().listNews(_currentPage, _newsPerPage).then((response) {
      setState(() {
        _currentPage += 1;
        news = response;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: Row(
                children: [
                  const Text(
                    'Featured',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    onPressed: null,
                    child: const Text(
                      'See all',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder<List<FeaturedNews>>(
              future: ListingFeaturedNews().listFeaturedNews(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  if (kDebugMode) {
                    print(snapshot.error);
                  }
                }
                return snapshot.hasData
                    ? CarouselSlider.builder(
                        options: CarouselOptions(
                          height: 250,
                          reverse: true,
                        ),
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index, realIndex) {
                          final urlImage =
                              (snapshot.data?[index] as FeaturedNews).cover;
                          final textImage =
                              (snapshot.data?[index] as FeaturedNews).title;

                          return buildImage(urlImage, textImage, (snapshot.data?[index] as FeaturedNews).id);
                        },
                      )
                    : const CircularProgressIndicator();
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: Row(
                children: [
                  const Text(
                    'News',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    onPressed: null,
                    child: const Text(
                      'See all',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: ListView.builder(
                      controller: controller,
                      padding: EdgeInsets.zero,
                      itemCount: news.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                          id_news: news[index].id.toString(),
                                        )));
                          },
                          child: SizedBox(
                            height: 180,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: const BorderSide(
                                  color: Colors.black12,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 160,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                news[index]
                                                    .cover),
                                            fit: BoxFit.cover),
                                        borderRadius:
                                            const BorderRadius.horizontal(
                                          left: Radius.circular(16),
                                        )),
                                  ),
                                  // const SizedBox(
                                  //     width: 16,
                                  // ),
                                  Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          16, 24, 16, 24),
                                      width: 175,
                                      height: 156,
                                      child: Column(
                                        children: [
                                          Text(
                                            '${news[index]
                                                    .title
                                                    .substring(0, 25)}...',
                                            style: const TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 24,
                                                    height: 24,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            news[index]
                                                                .portalLogo),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                news[index]
                                                    .portalTitle,
                                                style: const TextStyle(
                                                    fontSize: 13.0),
                                              ),
                                              const SizedBox(
                                                width: 10.0,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 65,
                                                    child: Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        side: const BorderSide(
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                      child: Text(
                                                        news[index]
                                                            .category
                                                            .split(' ')[0],
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 13.0),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10.0,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.thumb_up_alt,
                                                      color: Colors.red,
                                                      size: 22,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      '${(news[index].likes / 1000).toStringAsFixed(1)}k',
                                                      style: const TextStyle(
                                                          fontSize: 12.0),
                                                    ),
                                                  ],
                                                )
                                              ]),
                                              Column(children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.comment,
                                                      color: Colors.red,
                                                      size: 22,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      '${(news[index].comments / 1000).toStringAsFixed(1)}k',
                                                      style: const TextStyle(
                                                          fontSize: 12.0),
                                                    ),
                                                  ],
                                                )
                                              ]),
                                              Column(children: const [
                                                Icon(
                                                  Icons.bookmark_border,
                                                  color: Colors.red,
                                                  size: 22,
                                                ),
                                              ])
                                            ],
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),
                        );
                      })),
            )
          ],
        ),
      ),
    );
  }

  void _scrollListener() {
    if (controller.position.extentAfter < 50) {
      if ((_hasMoreItems == true && _loadingMore == false)) {
          _loadMoreNews();
        }
    }
  }

  Widget buildImage(String urlImage, String textImage, int id) => Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(11),
          image: DecorationImage(
            image: NetworkImage(
              urlImage,
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${textImage.substring(0, 30)}...',
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: "Sans-serif",
                  fontSize: 18,
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailPage(
                            id_news: id.toString(),
                          )));
                },
                style: ButtonStyle(
                  backgroundColor:
                      const MaterialStatePropertyAll<Color>(Colors.redAccent),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                child: const Text(
                  'Read now',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Sans-serif",
                    fontSize: 18,
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
