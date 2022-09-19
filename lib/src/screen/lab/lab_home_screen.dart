import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_droidkaigi_2022/src/screen/lab/advance/cao_3d_studio.dart';
import 'package:flutter_droidkaigi_2022/src/screen/lab/basic_3d_rotate_page.dart';
import 'package:flutter_droidkaigi_2022/src/screen/lab/game/game.dart';
import 'package:flutter_droidkaigi_2022/src/screen/lab/pandlum/pandlum_main_screen.dart';

class LabHomeScreen extends StatefulWidget {
  const LabHomeScreen({Key? key}) : super(key: key);

  @override
  State<LabHomeScreen> createState() => _LabHomeScreenState();
}

class _LabHomeScreenState extends State<LabHomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("研究/実験室"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: DefaultTabController(
          length: 4,
          child: Column(
            children: [
              TabBar(
                  labelColor: Theme.of(context).colorScheme.primary,
                  indicatorColor: Theme.of(context).colorScheme.primary,
                  isScrollable: true,
                  tabs: const [
                    Tab(
                      text: "Pendlum",
                    ),
                    Tab(
                      text: "Game",
                    ),
                    Tab(
                      text: "General-3D",
                    ),
                    Tab(
                      text: "Advance-3D",
                    ),
                  ]),
              const SizedBox(
                height: 24,
              ),
              Expanded(
                  child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  DoublePendulum(
                    animationDuration: const Duration(seconds: 2),
                  ),
                  Game(),
                  const Basic3DRotatePage(),
                  const Cao3DStudio(),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
