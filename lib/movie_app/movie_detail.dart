import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:training_newwave/configs/app_constant.dart';
import 'package:training_newwave/model/autogenerated_entity.dart';
import 'package:training_newwave/model/detail_movie_entity.dart';
import 'package:training_newwave/movie_app/networks/api_service.dart';

// ignore: must_be_immutable
class MovieDetail extends StatefulWidget {
  int id;

  MovieDetail({Key key, this.id}) : super(key: key);

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  DetailMovie detailMovie;
  List<Cast> listCast = [];
  int lengthListCastMore = 0;
  bool isBottomSheetShowing = true;

  @override
  void initState() {
    super.initState();
    fetchDetail();
  }

  void showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      barrierColor: Colors.black.withAlpha(1),
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return detailMovie == null
            ? const SizedBox()
            : Container(
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 12),
                        child: SvgPicture.asset(
                          "assets/svg/lane2.svg",
                        ),
                      ),
                      Flexible(
                        child: Text(
                          detailMovie.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        detailMovie.tagline,
                        style: TextStyle(
                          color: const Color(0xffFFFFFF).withOpacity(0.5),
                          fontSize: 18,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 27),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 62,
                              height: 24,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xffA6A1E0).withOpacity(0.3),
                              ),
                              child: const Center(
                                child: Text(
                                  "Action",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              height: 24,
                              margin: const EdgeInsets.only(left: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xffF5C518),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/svg/imdb.svg",
                                    ),
                                    Text(
                                      detailMovie.voteAverage.toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                            SvgPicture.asset(
                              "assets/svg/share.svg",
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: SvgPicture.asset(
                                "assets/svg/Favorite.svg",
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Center(
                          child: Text(
                            detailMovie.overview,
                            maxLines: 3,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: const Color(0xffFFFFFF).withOpacity(0.75),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              "Cast",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Text(
                                "See all",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: SizedBox(
                          height: 122,
                          child: ListView.separated(
                            itemCount: lengthListCastMore < 1 ? listCast.length : 5,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: 1);
                            },
                            itemBuilder: (context, index) {
                              if (index == 4 && lengthListCastMore > 0) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: const Color(0xffFFFFFF).withOpacity(0.2),
                                      child: Center(
                                        child: Text(
                                          "+ $lengthListCastMore",
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return SizedBox(
                                  child: itemCategory(
                                    listCast[index],
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }

  void fetchDetail() async {
    final result = await ApiService.fetchDetail(widget.id);
    final resultCast = await ApiService.fetchAutogenerated(widget.id);
    setState(
      () {
        detailMovie = result;
        listCast = resultCast.cast;
        lengthListCastMore = resultCast.cast.length - 4;
      },
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        setState(() {
          showBottomSheet();
        });
      },
    );

    // await Future.delayed(Duration(seconds: 1));
    // showBottomSheet();
  }

  @override
  Widget build(BuildContext context) {
    return detailMovie == null
        ? const SizedBox()
        : WillPopScope(
            onWillPop: () async {

              debugPrint("isBottomSheetShowing: ${isBottomSheetShowing}");
              setState((){
                isBottomSheetShowing = false;
              });
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.pop(context);
              });

              return true;
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    AppConstant.baseImage + detailMovie.posterPath,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: const SizedBox(// child: BottomSheetExample(),
                  ),
            ),
          );
  }

  Widget itemCategory(Cast cast) {
    return SizedBox(
      width: 58,
      child: listCast.isEmpty
          ? const SizedBox()
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    cast.profilePath != null
                        ? AppConstant.baseImage + cast.profilePath
                        : AppConstant.imageError,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    cast.name,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 2,
                    bottom: 22,
                  ),
                  child: Text(
                    cast.character,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xffFFFFFF).withOpacity(0.5),
                      fontSize: 8,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
