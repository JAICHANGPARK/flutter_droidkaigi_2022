import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RoboticsPage extends StatefulWidget {
  const RoboticsPage({Key? key}) : super(key: key);

  @override
  State<RoboticsPage> createState() => _RoboticsPageState();
}

class _RoboticsPageState extends State<RoboticsPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(

        children: [
          Text(
            "Service",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              Image.asset(
                "assets/google_x.png",
                height: 100,
              ),
              Image.network(
                "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Logo_of_X_%28company%29.svg/200px-Logo_of_X_%28company%29.svg.png",
                height: 100,
              ),
            ],
          ),
          const Center(
            child: Text(
              "source: https://namu.wiki/w/X%20%EB%94%94%EB%B2%A8%EB%A1%AD%EB%A8%BC%ED%8A%B8",
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              launchUrl(Uri.parse("https://everydayrobots.com/"));
            },
            child: Image.network(
              "https://images.ctfassets.net/1ejv5e8uweut/42rLSWDLFGsCNqtzWBRINw/29172ef0cf5003704c48bfc165ac6db1/EDR-intro-video.png",
              height: 200,
            ),
          ),
          const Center(
            child: Text(
              "source: https://everydayrobots.com/",
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Image.network(
            "data:image/png;base64,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",
            height: 200,
          ),
          Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Aldebaran_Robotics_Logo.svg/1200px-Aldebaran_Robotics_Logo.svg.png",
            height: 100,
          ),
          const SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: () {
              launchUrl(Uri.parse("http://wiki.ros.org/pepper"));
            },
            child: Image.network(
              "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a1/SoftBank_pepper.JPG/800px-SoftBank_pepper.JPG",
              height: 200,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Wearable",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Image.network(
            "https://www.ft.com/__origami/service/image/v2/images/raw/http%3A%2F%2Fcom.ft.imagepublish.upp-prod-eu.s3.amazonaws.com%2F943af5da-850f-11de-9a64-00144feabdc0?fit=scale-down&source=next&width=470",
            height: 200,
          ),
          const Center(
            child: Text(
              "source:https://www.ft.com/content/67702488-8502-11de-9a64-00144feabdc0",
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Industry",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Image.network(
            "https://upload.wikimedia.org/wikipedia/en/thumb/4/43/Boston_Dynamics_logo.svg/1280px-Boston_Dynamics_logo.svg.png",
            height: 100,
          ),
          GestureDetector(
            onTap: () {
              launchUrl(Uri.parse("https://github.com/clearpathrobotics/spot_ros"));
            },
            child: Image.network(
              "https://raw.githubusercontent.com/clearpathrobotics/spot_ros/master/cp_spot.jpg",
              height: 200,
            ),
          ),
          Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/KUKA_Logo_800x260.png/1280px-KUKA_Logo_800x260.png",
            height: 72,
          ),
          GestureDetector(
            onTap: () {
              launchUrl(Uri.parse("https://github.com/ros-industrial/fanuc"));
            },
            child: Image.network(
              "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bb/Fanuc_logo.svg/200px-Fanuc_logo.svg.png",
              height: 100,
            ),
          ),
          Image.network(
            "https://i0.wp.com/rayhaber.com/wp-content/uploads/2022/04/FANUC-Robotlari-Gucunu-Kisa-Onarim-Suresiyle-Koruyor.jpg?resize=678%2C381&ssl=1",
            height: 200,
          ),
          const Center(
            child: Text(
              "source: https://ko.rayhaber.com/2022/04/Fanuc-%EB%A1%9C%EB%B4%87%EC%9D%80-%EC%A7%A7%EC%9D%80-%EC%88%98%EB%A6%AC-%EC%8B%9C%EA%B0%84%EC%9C%BC%EB%A1%9C-%EC%84%B1%EB%8A%A5%EC%9D%84-%EC%9C%A0%EC%A7%80%ED%95%A9%EB%8B%88%EB%8B%A4./",
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ),

          Image.network(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRC0Idsb6ebWxpbQuxWf6ShETWzTvuJScfKSdbbZKV3&s",
            height: 200,
          ),
          const Center(
            child: Text(
              "source: https://www.motoman.com/en-us/about/blog/ros-2-and-what-it-means-for-your-yaskawa-robotic-a",
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Space Industry",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          GestureDetector(
            onTap: () {
              launchUrl(Uri.parse("https://github.com/nasa-jpl"));
            },
            child: Image.network(
              "https://avatars.githubusercontent.com/u/10360932?s=200&v=4",
              height: 200,
              fit: BoxFit.fitHeight,
            ),
          ),
          Image.network(
            "https://aws1.discourse-cdn.com/business7/uploads/ros/original/2X/9/96ea784db4e74bed501cc09d49a11e3328d80c30.gif",
            height: 200,
          ),
          const Center(
            child: Text(
              "source: https://discourse.ros.org/t/ros-news-for-the-week-of-2-8-2021/18929",
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Delivery",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Image.network(
            "https://www3.nhk.or.jp/nhkworld/en/news/backstories/1443/images/RNLP95nRbbLxJsG7EwCvrehhAYRTwjjrmHZF25ng.jpeg",
            height: 200,
          ),
          const Center(
            child: Text(
              "source: https://www3.nhk.or.jp/nhkworld/en/news/backstories/1443/",
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ),
          Image.network(
            "https://ichef.bbci.co.uk/news/976/cpsprodpb/2983/production/_124772601_dsc_9312.jpg",
            height: 200,
          ),
          const Center(
            child: Text(
              "source: https://www.bbc.com/news/uk-england-cambridgeshire-61471989",
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
