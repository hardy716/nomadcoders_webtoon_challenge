import 'package:flutter/material.dart';
import 'package:nomadcoder_webtoon_challenge/services/api_service.dart';
import '../models/webtoon_model.dart';
import '../widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  String getWeekday() {
    List<String> weekdayList = [
      "월",
      "화",
      "수",
      "목",
      "금",
      "토",
      "일",
    ];
    DateTime now = DateTime.now();
    int weekday = now.weekday;

    return weekdayList[weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 2.0,
        backgroundColor: Colors.black.withOpacity(0.8),
        foregroundColor: Colors.white,
        shadowColor: Colors.white,
        title: const Text(
          "HardyToons📚",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // 기초적인 리스트뷰 생성 방법
            // return ListView(
            //   children: [
            //     for (var webtoon in snapshot.data!) Text('${webtoon.title}')
            //   ],
            // );

            // 사용자가 볼 수 없는 아이템은 build하지 않는다는 점에서 훨씬 최적화가 됐다고 할 수 있음
            // 한 번에 다 로딩하지 않고 필요할때 아이템을 빌드함
            // return ListView.builder(
            //   scrollDirection: Axis.horizontal,
            //   itemCount: snapshot.data!.length,
            //   itemBuilder: (context, index) {
            //     var webtoon = snapshot.data![index];
            //     return Text(webtoon.title);
            //   },
            // );

            // 아이템 사이에 들어갈 위젯(separator)을 빌드함
            return Column(
              children: [
                const SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${getWeekday()}요웹툰 📖",
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var webtoon = snapshot.data![index];
                      return Webtoon(
                        title: webtoon.title,
                        thumb: webtoon.thumb,
                        id: webtoon.id,
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 40.0),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "실시간 인기 랭킹 ⭐️",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 300.0,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      var webtoon = snapshot.data![index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white.withOpacity(0.1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 20.0,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "${index + 1}.  ${webtoon.title}",
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 40.0),
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
