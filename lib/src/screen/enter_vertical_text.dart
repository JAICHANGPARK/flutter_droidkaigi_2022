import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EnterVerticalTextPage extends StatefulWidget {
  const EnterVerticalTextPage({Key? key}) : super(key: key);

  @override
  State<EnterVerticalTextPage> createState() => _EnterVerticalTextPageState();
}

class _EnterVerticalTextPageState extends State<EnterVerticalTextPage> {
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // changeOpacity();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        opacity = 1;
      });
    });
  }

  changeOpacity() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        opacity = opacity == 0.0 ? 1.0 : 0.0;
        changeOpacity();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: AnimatedOpacity(
              duration: const Duration(seconds: 2),
              curve: Curves.easeIn,
              opacity: opacity,
              child: Column(
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Center(child: MyVerticalText("よろしくお願いします。")),
                        SizedBox(
                          width: 32,
                        ),
                        Center(child: MyVerticalText("作りました。")),
                        Center(child: MyVerticalText("セッションを一緒に楽しむために")),
                        Center(child: MyVerticalText("このアプリは公式アプリではなく")),
                        Center(child: MyVerticalText("ありがとうございます。")),
                        Center(child: MyVerticalText("セッションに参加していただき")),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  FloatingActionButton(
                    heroTag: "enter",
                    onPressed: () {
                      GoRouter.of(context).go("/home");
                    },
                    child: Icon(Icons.door_front_door_outlined),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Create a custom widget like this
class MyVerticalText extends StatelessWidget {
  final String text;

  const MyVerticalText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Wrap(
        runSpacing: 30,
        direction: Axis.vertical,
        alignment: WrapAlignment.center,
        children: text.split("").map((string) => Text(string, style: const TextStyle(fontSize: 22))).toList(),
      ),
    );
  }
}
