import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/controllers/providerNews.dart';
import 'package:news_app/views/DetailsNews.dart';
import 'package:news_app/widgets/shimmers.dart';
import 'package:provider/provider.dart';

import '../models/news_model.dart';

class ViewAllNews extends StatelessWidget {
  ViewAllNews({super.key});

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("News"),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<NewsPorvider>(context, listen: false)
                    .getallArticles();
              },
              icon: Icon(Icons.refresh_rounded))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, bottom: 0, top: 10),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Search News here",
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                  },
                ),
              ),
              onSubmitted: (value) {
                final newsProvider =
                    Provider.of<NewsPorvider>(context, listen: false);
                newsProvider.getSingleNews(value);
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Consumer<NewsPorvider>(
            builder: (context, newsProvider, child) {
              if (_controller.text.isEmpty) {
                newsProvider.getallArticles();
              } else {}
              if (!newsProvider.isdata) {
                return NewsListShimmer();
              }

              if (newsProvider.listofArticles.isEmpty) {
                return Center(
                  child: Text("No data found."),
                );
              }

              return conatinerlist(newsProvider, sw);
            },
          ),
        ],
      ),
    );
  }

  Widget conatinerlist(newsProvider, sw) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: newsProvider.listofArticles.length,
        itemBuilder: (context, index) {
          Article article = newsProvider.listofArticles[index];
          if (article.title == null) {
            return Container();
          } else {
            return InkWell(
              onTap: () {
                if (article.url != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(
                        title: article.title!,
                        urlContent: article.url!,
                      ),
                    ),
                  );
                } else {
                  const snackBar = SnackBar(
                    content: Text('Data Not Found Sorry!'),
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.red,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(
                  bottom: 20,
                  left: 15,
                  right: 15,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: const Offset(2, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: sw,
                      height: 200,
                      child: CachedNetworkImage(
                        imageUrl: article.urlToImage ?? "images/image1.jpeg",
                        fit: BoxFit.fill,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: Icon(Icons.error),
                        ),
                      ),
                    ),
                    Text(
                      article.title ?? "No Title",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      article.content ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
