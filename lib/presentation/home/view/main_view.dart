import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:traveler/data/local_data/local_data.dart';
import 'package:traveler/model/models.dart';
import 'package:traveler/presentation/countryDetails/view/country_details.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final _controller = PageController();

  bool isExpanded = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          _background(),
          _main(),
        ],
      ),
    );
  }

  //back Ground Widgets
  Widget _background() {
    return PageView.builder(
      controller: _controller,
      reverse: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: countries.length,
      itemBuilder: (context, index) {
        return _backgroundWidget(countries[index]);
      },
    );
  }

  Widget _backgroundWidget(Country country) {
    return Stack(
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(country.image, fit: BoxFit.cover),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.15, 0.5],
              colors: [
                Colors.white.withOpacity(0.2),
                Colors.white.withOpacity(0.5),
              ],
            ),
          ),
        )
      ],
    );
  }

  //main Widgets
  Widget _main() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CarouselSlider(
            items: countries
                .map((country) => _countryWidget(context, country))
                .toList(),
            options: CarouselOptions(
              viewportFraction: 1.0,
              height: MediaQuery.of(context).size.height * 0.8,
              enlargeCenterPage: true,
              onPageChanged: onPageChanged,
            ),
          ),
        ],
      ),
    );
  }

  //country Widget
  Widget _countryWidget(context, Country country) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            bottom: isExpanded ? 65 : 100,
            width: size.width * 0.7,
            height: isExpanded ? size.height * 0.65 : size.height * 0.6,
            child: _expandedContentWidget(context, country),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            bottom: isExpanded ? 150 : 100,
            child: GestureDetector(
              onPanUpdate: onPanUpdate,
              onTap: () => onTap(country),
              child: _imageWidget(context, country),
            ),
          )
        ],
      ),
    );
  }

  //expanded Widget
  Widget _expandedContentWidget(context, Country country) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        padding: const EdgeInsets.all(15),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(country.description,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    fontStyle: FontStyle.italic))));
  }

  //Image Container
  Widget _imageWidget(context, Country country) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      height: size.height * 0.6,
      width: size.width * 0.73,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 2, spreadRadius: 1),
        ],
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          _buildImage(country),
          _countryNameWidget(country),
        ],
      ),
    );
  }

  //image widgets
  Widget _buildImage(Country country) {
    return SizedBox.expand(
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Image.asset(country.image, fit: BoxFit.cover),
      ),
    );
  }

  //image name on top of image
  Widget _countryNameWidget(country) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        country.name,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }

  //functions
  void onPageChanged(index, _) {
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  void onTap(Country country) {
    if (!isExpanded) {
      setState(() => isExpanded = true);
    } else {
      opedDetailsPage(country);
    }
  }

  void opedDetailsPage(Country country) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(seconds: 1),
        reverseTransitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (context, animation, secondaryAnimation) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.fastLinearToSlowEaseIn,
            reverseCurve: Curves.fastOutSlowIn,
          );
          return ScaleTransition(
            alignment: Alignment.center,
            scale: curvedAnimation,
            child: DetailsScreen(country: country),
          );
        },
      ),
    );
  }

  void onPanUpdate(DragUpdateDetails details) {
    //if Dragged up ,show expanded widget
    if (details.delta.dy < 0) {
      setState(() => isExpanded = true);
    }
    //if Dragged down ,hide expanded widget
    else if (details.delta.dy > 0) {
      setState(() => isExpanded = false);
    }
  }
}
