import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:training_newwave/model/movie_entity.dart';
import 'package:training_newwave/model/movie_type.dart';
import 'package:training_newwave/model/popular_entity.dart';
import 'package:training_newwave/movie_app/networks/api_service.dart';

import 'widget/image_carouseslide.dart';

class MovieHome extends StatefulWidget {
  const MovieHome({Key key}) : super(key: key);

  @override
  State<MovieHome> createState() => _Movie_HomeState();
}

// ignore: camel_case_types
class _Movie_HomeState extends State<MovieHome> {
  int currentPos = 0;

  List<MovieEntity> listMovie = listMovieTop();

  List<MovieType> listImage = [
    MovieType(assetImage: "assets/svg/Vector.svg", title: "Genres"),
    MovieType(assetImage: "assets/svg/tv series icon.svg", title: "TV series"),
    MovieType(assetImage: "assets/svg/Movie Roll.svg", title: "Movies"),
    MovieType(assetImage: "assets/svg/Cinema.svg", title: "In Theatre"),
  ];

  List<Movie> listMovies = [];

  @override
  void initState() {
    super.initState();
    fetchListMovie();
  }

  void fetchListMovie() async {
    final result = await ApiService.fetchPopular();
    setState(() {
      listMovies = result.results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              Color(0xff2B5876),
              Color(0xff4E4376),
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 65,
                    right: 65,
                    top: 24,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: "Hello, "),
                            TextSpan(
                              text: "jane!",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        "assets/svg/notfication_icon.svg",
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 20,
                  left: 50,
                  right: 50,
                ),
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xffFFFFFF).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 14,
                          right: 11,
                          bottom: 16,
                          left: 16,
                        ),
                        child: SvgPicture.asset(
                          "assets/svg/Search_icon.svg",
                          placeholderBuilder: (BuildContext context) =>
                              const CircularProgressIndicator(),
                        ),
                      ),
                    ),
                    hintText: "Search",
                    hintStyle: const TextStyle(
                      color: Colors.white54,
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(
                        top: 14,
                        right: 14,
                        bottom: 14,
                      ),
                      child: SizedBox(
                        width: 34,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 1,
                              child: SvgPicture.asset(
                                "assets/svg/Line 1.svg",
                              ),
                            ),
                            SizedBox(
                              width: 16,
                              height: 24,
                              child: SvgPicture.asset(
                                "assets/svg/voich_icon.svg",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                      borderSide: BorderSide(
                        color: const Color(0xffFFFFFF).withOpacity(0.2),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                      borderSide: BorderSide(
                        color: const Color(0xffFFFFFF).withOpacity(0.2),
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 50,
                  top: 26,
                  bottom: 15,
                ),
                child: Text(
                  "Most Popular",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 150,
                child: slideShowTop(
                  listMovie: listMovies,
                  current: currentPos,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 17,
                  bottom: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: listMovie.map(
                    (url) {
                      int index = listMovie.indexOf(url);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 2.0,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentPos == index
                              ? const Color(0xff64ABDB)
                              : const Color(0xff826EC8),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
              SizedBox(
                height: 110,
                child: Center(
                  child: ListView.separated(
                    itemCount: listImage.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 12);
                    },
                    itemBuilder: (context, index) {
                      return SizedBox(
                        child: itemCategory(
                          listImage[index],
                        ),
                      );
                    },
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 50,
                  top: 26,
                  bottom: 15,
                ),
                child: Text(
                  "Upcoming releases",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                child: slideShowBottom(listMovies, currentPos),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: listMovie.map(
                  (url) {
                    int index = listMovie.indexOf(url);
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 2.0,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            currentPos == index ? const Color(0xff64ABDB) : const Color(0xff826EC8),
                      ),
                    );
                  },
                ).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget slideShowTop({
    List<Movie> listMovie,
    int current,
  }) {
    return listMovie.isEmpty
        ? const SizedBox()
        : CarouselSlider.builder(
            itemCount: listMovie.length,
            options: CarouselOptions(
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  current = index;
                });
              },
            ),
            itemBuilder: (context, index, realIndex) {
              return MyImageView(
                movie: listMovie[index],
                height: 250.0,
                width: 360.0,
                hide: true,
              );
            },
          );
  }

  Widget slideShowBottom(List<Movie> list, int current) {
    return list.isEmpty
        ? const SizedBox()
        : CarouselSlider.builder(
            itemCount: list.length,
            options: CarouselOptions(
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  current = index;
                });
              },
              viewportFraction: 0.5,
            ),
            itemBuilder: (context, index, realIndex) {
              return MyImageView(
                movie: list[index],
                height: 230.0,
                width: 170.0,
                hide: false,
              );
            },
          );
  }

  Widget itemCategory(MovieType movieType) {
    return Container(
      width: 70,
      height: 95,
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF).withOpacity(0.2),
        border: Border.all(
          width: 1,
          color: const Color(0xffFFFFFF).withOpacity(0.2),
        ),
        borderRadius:
            const BorderRadius.all(Radius.circular(15.0) //                 <--- border radius here
                ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            child: SvgPicture.asset(
              movieType.assetImage,
              fit: BoxFit.cover,
              placeholderBuilder: (BuildContext context) => const CircularProgressIndicator(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 15,
            ),
            child: Text(
              movieType.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable

/*
* 1. Sử dụng cachenetworkImage √
* 2. Xem lại các chỗ dùng thẻ Row, column √
* 3. làm custom độ dài list cast √
* 4. Sửa lại các icon Svg lấy chưa đúng √
* 5. Back 1 lần về luôn màn home từ màn detail √
* 6.
* */
