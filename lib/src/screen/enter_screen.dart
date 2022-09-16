import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui' as ui;

class EnterScreen extends StatefulWidget {
  const EnterScreen({Key? key}) : super(key: key);

  @override
  State<EnterScreen> createState() => _EnterScreenState();
}

class _EnterScreenState extends State<EnterScreen> {
  @override
  Widget build(BuildContext context) {
    Widget title = Text(
      '안녕하세요 こんにちは Hello 你好 xin chào Buongiorno Hola Bonjour ',
      style: GoogleFonts.nanumGothic(
        fontWeight: FontWeight.w900,
        fontSize: 48,
        color: Color(0xFF666870),
        // color: Colors.white.withOpacity(0.6),
        height: 1.3,
        letterSpacing: -1,
      ),
    );
    title = title
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(
          duration: 1200.ms,
          color: Theme.of(context).colorScheme.primary,
          // color: Colors.white.withOpacity(0.6),
          // colors: [
          //   Theme.of(context).colorScheme.primary,
          //   Colors.orange,
          //   Colors.green,
          //   Colors.blue,
          //   Colors.red,
          //   Theme.of(context).colorScheme.primary,
          // ],
        )
        .animate() // this wraps the previous Animate in another Animate
        .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
        .slide();
    return Material(
      child: Column(
        children: [
          Expanded(
            flex: 10,
            child: Stack(
              children: [
                Container(
                  color: Colors.black.withOpacity(0.4),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1.6,
                    ),
                    itemCount: 60,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        "assets/bg_dk_2022.png",
                        fit: BoxFit.fitHeight,
                        color: Colors.black.withOpacity(0.2),
                        colorBlendMode: BlendMode.darken,
                      );
                    },
                  ),
                ),
                Positioned(
                  left: 32,
                  right: 32,
                  top: 32,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(16),
                    child: Center(
                      // child: title,
                      child: Text(
                        '안녕하세요 こんにちは Hello 你好 xin chào Buongiorno Hola Bonjour ',
                        style: GoogleFonts.nanumGothic(
                            fontWeight: FontWeight.w900,
                            fontSize: 48,
                            // color: Color(0xFF666870),
                            // color: Colors.white.withOpacity(0.6),
                            height: 1.3,
                            letterSpacing: -1,
                            foreground: Paint()
                              ..shader = ui.Gradient.linear(
                                const Offset(0, 20),
                                const Offset(450, 20),
                                <Color>[
                                  Colors.red,
                                  Colors.yellow,

                                ],
                              )),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                GoRouter.of(context).go("/home");
              },
              child: Center(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      "タップして入場する",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Stack(
          //   children: [
          //
          //
          //
          //     Positioned(
          //       left: 48,
          //       right: 48,
          //       bottom: 0,
          //       top: 0,
          //       child: GestureDetector(
          //         onTap: () {
          //           GoRouter.of(context).go("/home");
          //         },
          //         child: Center(
          //           child: Container(
          //             height: 160,
          //             decoration: const BoxDecoration(
          //               color: Colors.white,
          //             ),
          //             child: Center(
          //               child: Text(
          //                 "入場",
          //                 style: Theme.of(context).textTheme.headlineLarge,
          //               ),
          //             ),
          //           )
          //               .animate()
          //               .fadeIn(
          //                 duration: 1000.ms,
          //                 begin: 0,
          //                 end: 1,
          //               )
          //               .then()
          //               .scale(
          //                 duration: 3000.ms,
          //                 begin: 0.5,
          //                 end: 1,
          //               ),
          //         ),
          //       ),
          //     ),
          //
          //
          //   ],
          // ),
        ],
      ),
    );
  }
}
