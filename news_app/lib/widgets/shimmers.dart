import 'package:flutter/material.dart';

class NewsListShimmer extends StatefulWidget {
  const NewsListShimmer({super.key});

  @override
  _NewsListShimmerState createState() => _NewsListShimmerState();
}

class _NewsListShimmerState extends State<NewsListShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Container(
        width: 100.0,
        height: 100.0,
        color: Colors.grey[300],
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: 0.2 + (_controller.value * 0.6),
              child: Container(
                color: Colors.white,
              ),
            );
          },
        ),
      ),
      title: Container(
        height: 20.0,
        width: MediaQuery
            .of(context)
            .size
            .width * 0.6,
        color: Colors.grey[300],
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: 0.2 + (_controller.value * 0.6),
              child: Container(
                color: Colors.white,
              ),
            );
          },
        ),
      ),
      subtitle: Container(
        height: 16.0,
        width: MediaQuery
            .of(context)
            .size
            .width * 0.4,
        color: Colors.grey[300],
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: 0.2 + (_controller.value * 0.6),
              child: Container(
                color: Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}
