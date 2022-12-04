import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:traveler/model/models.dart';

class DetailsScreen extends StatefulWidget {
  final Country country;

  const DetailsScreen({required this.country, Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final _mainController = PageController();
  final _textController = PageController();
  final _contentController = PageController();
  final _reviewController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _mainController.dispose();
    _textController.dispose();
    _contentController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  bool isDetailsExpanded = false;
  bool isReviewsExpanded = false;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.pop(context),
          ),
          title: SmoothPageIndicator(
            controller: _mainController,
            count: widget.country.locations.length,
            effect: const JumpingDotEffect(
                activeDotColor: Colors.white,
                dotColor: Colors.black,
                dotHeight: 5),
          ),
          centerTitle: true,
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            //image widget
            AnimatedPositioned(
                top: 0,
                height: isDetailsExpanded || isReviewsExpanded
                    ? h * 0.35
                    : h * 0.75,
                width: w,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
                child: _imageWidget()),
            //about widget
            AnimatedPositioned(
                top: isDetailsExpanded || isReviewsExpanded
                    ? h * 0.32
                    : h * 0.718,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isReviewsExpanded) {
                          isReviewsExpanded = false;
                        }
                        isDetailsExpanded = !isDetailsExpanded;
                      });
                    },
                    child: _aboutWidget(widget.country.locations[0], w, h))),
            //reviews widget
            AnimatedPositioned(
                top: isReviewsExpanded ? h * 0.4 : h * 0.8,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isDetailsExpanded) {
                          isDetailsExpanded = false;
                        }
                        isReviewsExpanded = !isReviewsExpanded;
                      });
                    },
                    child: _reviewsWidget(w, h))),
            //location name on bottom
            _locationNameWidget()
          ],
        ));
  }

  Widget _imageWidget() {
    return PageView.builder(
      controller: _mainController,
      itemCount: widget.country.locations.length,
      onPageChanged: onPageChanged,
      itemBuilder: (context, index) {
        return Image(
          image: AssetImage(widget.country.locations[index].image),
          fit: BoxFit.fill,
        );
      },
    );
  }

  Widget _aboutWidget(Location location, w, h) {
    return Container(
      width: w,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topRight: Radius.circular(30)),
          color: Colors.brown.shade400,
          boxShadow: const [
            BoxShadow(color: Colors.black45, blurRadius: 0.5, spreadRadius: 0.5)
          ]),
      child: Column(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 500),
            alignment: isDetailsExpanded ? Alignment.topLeft : Alignment.center,
            child: const Text(
              'About',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: h * 0.5,
            width: w,
            child: PageView.builder(
              controller: _contentController,
              itemCount: widget.country.locations.length,
              onPageChanged: onPageChanged,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.country.locations[index].address,
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade300),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.country.locations[index].description,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _reviewsWidget(w, h) {
    return Container(
      width: w,
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(30)),
        color: Colors.brown,
        boxShadow: [
          BoxShadow(color: Colors.black45, blurRadius: 0.5, spreadRadius: 0.5)
        ],
      ),
      child: Column(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 500),
            alignment: isReviewsExpanded ? Alignment.topLeft : Alignment.center,
            child: const Text(
              'Reviews',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
            width: w,
            height: h * 0.5,
            child: PageView.builder(
              controller: _reviewController,
              itemCount: widget.country.locations.length,
              onPageChanged: onPageChanged,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Text('rate',
                            style: TextStyle(color: Colors.grey.shade300)),
                        const SizedBox(width: 5),
                        RatingBarIndicator(
                            itemCount: 5,
                            rating: widget.country.locations[index].starRating,
                            itemSize: 15,
                            itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.amberAccent,
                                ))
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.grey.shade600,
                            radius: 15,
                            child: Image(
                                image: AssetImage(widget.country
                                    .locations[index].review.userImage))),
                        const SizedBox(width: 10),
                        Text(widget.country.locations[index].review.username,
                            style: const TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold)),
                        const Spacer(),
                        Text(widget.country.locations[index].review.date,
                            style: const TextStyle(color: Colors.white70))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0, top: 10),
                      child: Text(
                          widget.country.locations[index].review.comment,
                          style: const TextStyle(color: Colors.white54)),
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _locationNameWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
            color: Colors.grey.shade300,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black45, blurRadius: 0.5, spreadRadius: 0.5)
            ]),
        child: PageView.builder(
            controller: _textController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.country.locations.length,
            itemBuilder: (context, index) {
              return Center(
                child: Text(
                  widget.country.locations[index].name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24),
                ),
              );
            }),
      ),
    );
  }

  void onPageChanged(int page) {
    _mainController.animateToPage(page,
        duration: const Duration(milliseconds: 150), curve: Curves.easeIn);
    _textController.animateToPage(page,
        duration: const Duration(milliseconds: 150), curve: Curves.easeIn);
    _contentController.animateToPage(page,
        duration: const Duration(milliseconds: 150), curve: Curves.easeIn);
    _reviewController.animateToPage(page,
        duration: const Duration(milliseconds: 150), curve: Curves.easeIn);
  }
}
