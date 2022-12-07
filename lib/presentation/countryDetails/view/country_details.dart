import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:traveler/model/models.dart';
import 'package:traveler/presentation/resources/constants_manager.dart';
import 'package:traveler/presentation/resources/values_manager.dart';

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
            centerTitle: true,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () => Navigator.pop(context)),
            title: SmoothPageIndicator(
                controller: _mainController,
                count: widget.country.locations.length,
                effect: const JumpingDotEffect(
                    activeDotColor: Colors.white,
                    dotColor: Colors.black,
                    dotHeight: 5))),
        body: Stack(alignment: Alignment.bottomCenter, children: [
          //image widget
          AnimatedPositioned(
              top: 0,
              height:
                  isDetailsExpanded || isReviewsExpanded ? h * 0.35 : h * 0.75,
              width: w,
              duration: const Duration(
                  milliseconds: AppConstants.imageWidgetAnimation),
              curve: Curves.easeIn,
              child: _imageWidget()),
          //about widget
          AnimatedPositioned(
              top:
                  isDetailsExpanded || isReviewsExpanded ? h * 0.32 : h * 0.718,
              duration: const Duration(
                  milliseconds: AppConstants.aboutWidgetAnimation),
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
                  onPanUpdate: (details) => onPanUpdate(details, 1),
                  child: _aboutWidget(widget.country.locations[0], w, h))),
          //reviews widget
          AnimatedPositioned(
              top: isReviewsExpanded ? h * 0.4 : h * 0.8,
              duration: const Duration(
                  milliseconds: AppConstants.reviewWidgetAnimation),
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
                  onPanUpdate: (details) => onPanUpdate(details, 2),
                  child: _reviewsWidget(w, h))),
          //location name on bottom
          _locationNameWidget()
        ]));
  }

  Widget _imageWidget() {
    return PageView.builder(
        controller: _mainController,
        itemCount: widget.country.locations.length,
        onPageChanged: onPageChanged,
        itemBuilder: (context, index) {
          return Image(
              image: AssetImage(widget.country.locations[index].image),
              fit: BoxFit.fill);
        });
  }

  //about widget
  Widget _aboutWidget(Location location, w, h) {
    return Container(
        width: w,
        padding: const EdgeInsets.all(AppPadding.p25),
        decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(AppSize.s30)),
            color: Colors.brown.shade400,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black45, blurRadius: 0.5, spreadRadius: 0.5)
            ]),
        child: Column(children: [
          AnimatedAlign(
              duration: const Duration(
                  milliseconds: AppConstants.aboutWidgetAnimation),
              alignment:
                  isDetailsExpanded ? Alignment.topLeft : Alignment.center,
              child: const Text('About',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))),
          const SizedBox(height: AppSize.s15),
          SizedBox(
              height: h * 0.5,
              width: w,
              child: PageView.builder(
                  controller: _contentController,
                  itemCount: widget.country.locations.length,
                  onPageChanged: onPageChanged,
                  itemBuilder: (context, index) {
                    return Column(children: [
                      Row(children: [
                        const Icon(Icons.location_on_outlined,
                            size: AppSize.s15),
                        const SizedBox(width: AppSize.s5),
                        Text(widget.country.locations[index].address,
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey.shade300))
                      ]),
                      const SizedBox(height: AppSize.s20),
                      Text(widget.country.locations[index].description,
                          style: const TextStyle(color: Colors.white))
                    ]);
                  }))
        ]));
  }

  //reviews widget
  Widget _reviewsWidget(w, h) {
    return Container(
        width: w,
        padding: const EdgeInsets.all(AppPadding.p25),
        decoration: const BoxDecoration(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(AppSize.s30)),
            color: Colors.brown,
            boxShadow: [
              BoxShadow(
                  color: Colors.black45, blurRadius: 0.5, spreadRadius: 0.5)
            ]),
        child: Column(children: [
          AnimatedAlign(
              duration: const Duration(
                  milliseconds: AppConstants.reviewWidgetAnimation),
              alignment:
                  isReviewsExpanded ? Alignment.topLeft : Alignment.center,
              child: const Text('Reviews',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))),
          const SizedBox(height: AppSize.s25),
          SizedBox(
              width: w,
              height: h * 0.5,
              child: PageView.builder(
                  controller: _reviewController,
                  itemCount: widget.country.locations.length,
                  onPageChanged: onPageChanged,
                  itemBuilder: (context, index) {
                    return Column(children: [
                      Row(children: [
                        Text('rate',
                            style: TextStyle(color: Colors.grey.shade300)),
                        const SizedBox(width: AppSize.s5),
                        RatingBarIndicator(
                            itemCount: 5,
                            rating: widget.country.locations[index].starRating,
                            itemSize: AppSize.s15,
                            itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.amberAccent,
                                ))
                      ]),
                      const SizedBox(height: AppSize.s25),
                      Row(children: [
                        CircleAvatar(
                            backgroundColor: Colors.grey.shade600,
                            radius: AppSize.s15,
                            child: Image(
                                image: AssetImage(widget.country
                                    .locations[index].review.userImage))),
                        const SizedBox(width: AppSize.s10),
                        Text(widget.country.locations[index].review.username,
                            style: const TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold)),
                        const Spacer(),
                        Text(widget.country.locations[index].review.date,
                            style: const TextStyle(color: Colors.white70))
                      ]),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: AppPadding.p5, top: AppPadding.p10),
                        child: Text(
                            widget.country.locations[index].review.comment,
                            style: const TextStyle(color: Colors.white54)),
                      )
                    ]);
                  }))
        ]));
  }

  //location Name widget
  Widget _locationNameWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: AppSize.s70,
        decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(AppSize.s25)),
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

  //function to scroll widgets with curve
  void onPageChanged(int page) {
    _mainController.animateToPage(page,
        duration: const Duration(milliseconds: AppConstants.scrollAnimation),
        curve: Curves.easeIn);
    _textController.animateToPage(page,
        duration: const Duration(milliseconds: AppConstants.scrollAnimation),
        curve: Curves.easeIn);
    _contentController.animateToPage(page,
        duration: const Duration(milliseconds: AppConstants.scrollAnimation),
        curve: Curves.easeIn);
    _reviewController.animateToPage(page,
        duration: const Duration(milliseconds: AppConstants.scrollAnimation),
        curve: Curves.easeIn);
  }


  void onPanUpdate(DragUpdateDetails details, int num) {
    //if Dragged up ,show expanded widgets
    if (details.delta.dy < 0) {
      setState(() {
        isDetailsExpanded = num == 1;
        isReviewsExpanded = num == 2;
      });
    }
    //if Dragged down ,hide expanded widgets
    else if (details.delta.dy > 0) {
      setState(() {
        isDetailsExpanded = false;
        isReviewsExpanded = false;
      });
    }
  }
}
