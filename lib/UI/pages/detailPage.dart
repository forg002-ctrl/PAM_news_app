import 'package:flutter/material.dart';

import 'package:pam_news_app/Domain//getting_news.dart';

import 'package:pam_news_app/Data//get_news.dart';

class DetailPage extends StatelessWidget {
  final String id_news;

  const DetailPage({Key? key, required this.id_news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
            child: FutureBuilder(
                future: GettingNews().getNews(id_news),
                builder:
                    (BuildContext context, AsyncSnapshot<GetNews> snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 250,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        (snapshot.data as GetNews).cover),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(16)),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              children: [
                                Text(
                                  (snapshot.data as GetNews).title,
                                  textAlign: TextAlign.start,
                                  style: (const TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w500,
                                  )),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 65,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(16),
                                          side: const BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                        child: Text(
                                          (snapshot.data as GetNews).category,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 13.0),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15.0,
                                    ),
                                    Column(children: [
                                      Row(
                                        children: const [
                                          Icon(
                                            Icons.visibility,
                                            color: Colors.red,
                                            size: 22,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '638.8k',
                                            style: TextStyle(fontSize: 12.0),
                                          ),
                                        ],
                                      )
                                    ]),
                                    const SizedBox(
                                      width: 15.0,
                                    ),
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
                                            '${(snapshot.data as GetNews)
                                                .likes}',
                                            style:
                                            const TextStyle(fontSize: 12.0),
                                          ),
                                        ],
                                      )
                                    ]),
                                    const SizedBox(
                                      width: 15.0,
                                    ),
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
                                            '${(snapshot.data as GetNews)
                                                .comments}',
                                            style:
                                            const TextStyle(fontSize: 12.0),
                                          ),
                                        ],
                                      )
                                    ]),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 36.0,
                                          height: 36.0,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    (snapshot.data as GetNews)
                                                        .portalLogo),
                                                fit: BoxFit.fill),
                                            borderRadius:
                                            BorderRadius.circular(18.0),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8.0,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      (snapshot.data as GetNews).portalTitle,
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  (snapshot.data as GetNews).description,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(fontSize: 15.0),
                                ),

                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.lightBlueAccent,
              icon: const Icon(Icons.arrow_back, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
