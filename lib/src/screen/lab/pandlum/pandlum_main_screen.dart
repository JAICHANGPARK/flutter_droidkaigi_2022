import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

class PendulumInfo {
  double length;
  double mass;
  double angle;

  ///Angular Velocity
  double angularVel;

  /// acceleration
  double acc;

  // Canvas related
  Color paintColor = Color(Random().nextInt(0xffffffff));
  Offset origin;
  List<Offset> trailPoints = [];

  PendulumInfo(
      {required this.length,
      required this.mass,
      required this.angle,
      required this.origin,
      this.angularVel = 1,
      this.acc = 1});

  Offset get endPoint => Offset((length * sin(angle)), (length * cos(angle))) + origin;

  @override
  toString() => 'Pendulum has end point at $endPoint';
}

typedef Callback = void Function(double newValue);

class SliderWithLabel extends StatefulWidget {
  final String widgetLabel;
  final int division;
  final double min;
  final double max;
  final Callback callBack;
  final int showNDecimal;
  final double initialValue;

  const SliderWithLabel({
    super.key,
    required this.widgetLabel,
    required this.division,
    required this.min,
    required this.max,
    required this.callBack,
    required this.initialValue,
    this.showNDecimal = 1,
  });

  @override
  _SliderWithLabelState createState() => _SliderWithLabelState();
}

class _SliderWithLabelState extends State<SliderWithLabel> {
  double value = 0.0;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(widget.widgetLabel + value.toStringAsFixed(widget.showNDecimal)),
          Slider(
              divisions: widget.division,
              value: value,
              min: widget.min,
              max: widget.max,
              onChanged: (newValue) {
                setState(() {
                  value = newValue;
                  widget.callBack(newValue);
                });
              }),
        ],
      ),
    );
  }
}

class DoublePendulum extends StatefulWidget {
  final Duration animationDuration;

  DoublePendulum({required this.animationDuration});

  @override
  _DoublePendulumState createState() => _DoublePendulumState();
}

class _DoublePendulumState extends State<DoublePendulum> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late PendulumSimulationManager pendulumManager;

  double noOfPendulums = 2;
  double gravity = 9.8;
  double pendulum1Length = 100;
  double pendulum2Length = 100;
  double pendulum1Mass = 3;
  double pendulum2Mass = 3;
  double pendulum1Angle = 10;
  double pendulum2Angle = 5;
  bool showMenu = true;
  bool animationStopped = false;

  @override
  void initState() {
    super.initState();

    // Initializing the animation controller with a defined duraion.
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..repeat();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final avlblSize = MediaQuery.of(context).size;

    pendulumManager = PendulumSimulationManager(
      noOfDoublePendulums: noOfPendulums,
      gravity: gravity / 60,
      //Dividing gravity accross frames, assuming 60 FPS.
      pendulum1Length: pendulum1Length,
      pendulum1Mass: pendulum1Mass,
      pendulum2Length: pendulum2Length,
      pendulum2Mass: pendulum2Mass,
      pendulum1Angle: pendulum1Angle * 0.0174533,
      pendulum2Angle: pendulum2Angle * 0.0174533,
    );
    pendulumManager.initializePendulums();

    return Stack(
      children: <Widget>[
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: 0,
          child: SingleChildScrollView(
            controller: ScrollController(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                100,
                (index) => Container(
                  width: 1,
                  margin: const EdgeInsets.only(right: 8),
                  color: Colors.grey[200],
                ),
              ),
            ),
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                children: List.generate(
                  100,
                  (index) => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    height: 1,
                    color: Colors.grey[200],
                  ),
                ),
              ),
            )),
        Center(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, _) {
              pendulumManager.reEstimateAngles();
              return CustomPaint(
                painter: DoublePendulumPainter(
                  pendulumPaintInfos: pendulumManager,
                ),
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Card(
                  child: ExpansionTile(
                    trailing: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    initiallyExpanded: avlblSize.width > 600,
                    children: <Widget>[
                      ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          SliderWithLabel(
                            widgetLabel: 'Pendulums : ',
                            min: 1,
                            max: 50,
                            showNDecimal: 0,
                            callBack: (double value) {
                              setState(() {
                                noOfPendulums = value;
                              });
                            },
                            division: 50,
                            initialValue: noOfPendulums,
                          ),
                          SliderWithLabel(
                            widgetLabel: 'Gravity : ',
                            min: 1,
                            max: 20,
                            callBack: (double value) {
                              setState(() {
                                gravity = value;
                              });
                            },
                            initialValue: gravity,
                            division: 5,
                          ),
                          SliderWithLabel(
                            widgetLabel: 'Pendulum-1 Length : ',
                            min: 1,
                            max: 200,
                            callBack: (double value) {
                              setState(() {
                                pendulum1Length = value;
                              });
                            },
                            initialValue: pendulum1Length,
                            division: 100,
                          ),
                          SliderWithLabel(
                            widgetLabel: 'Pendulum-2 Length : ',
                            min: 1,
                            max: 200,
                            callBack: (double value) {
                              setState(() {
                                pendulum2Length = value;
                              });
                            },
                            initialValue: pendulum2Length,
                            division: 100,
                          ),
                          SliderWithLabel(
                            widgetLabel: 'Pendulum-1 Mass : ',
                            min: 0.01,
                            max: 10,
                            callBack: (double value) {
                              setState(() {
                                pendulum1Mass = value;
                              });
                            },
                            initialValue: pendulum1Mass,
                            division: 10,
                          ),
                          SliderWithLabel(
                            widgetLabel: 'Pendulum-2 Mass : ',
                            min: 0.01,
                            max: 10,
                            callBack: (double value) {
                              setState(() {
                                pendulum2Mass = value;
                              });
                            },
                            initialValue: pendulum2Mass,
                            division: 10,
                          ),
                          SliderWithLabel(
                            widgetLabel: 'Pendulum-1 Angle : ',
                            min: -360,
                            max: 360,
                            callBack: (double value) {
                              setState(() {
                                pendulum1Angle = value;
                              });
                            },
                            initialValue: pendulum1Angle,
                            division: 360,
                          ),
                          SliderWithLabel(
                            widgetLabel: 'Pendulum-2 Angle : ',
                            min: -360,
                            max: 360,
                            callBack: (double value) {
                              setState(() {
                                pendulum2Angle = value;
                              });
                            },
                            initialValue: pendulum2Angle,
                            division: 360,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              if (avlblSize.width > 600) const Spacer(flex: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColorLight,
                  onPressed: () {
                    setState(() {
                      animationStopped = !animationStopped;
                      animationStopped ? _animationController.reset() : _animationController.repeat();
                    });
                  },
                  child: animationStopped ? const Icon(Icons.play_arrow) : const Icon(Icons.stop),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

final originPendulumPaint = Paint()
  ..strokeWidth = 3.0
  ..color = Colors.black;
final pendulumPaint = Paint()..strokeWidth = 3.0;
final pendulum2MassPaint = Paint()
  ..color = Colors.red
  ..style = PaintingStyle.fill;
Paint _trailPaint = Paint()
  ..strokeWidth = 0.7
  ..color = Colors.black;

Paint _trailPaint2 = Paint()
  ..strokeWidth = 0.7
  ..color = Colors.blue;

class DoublePendulumPainter extends CustomPainter {
  final PendulumSimulationManager pendulumPaintInfos;

  DoublePendulumPainter({required this.pendulumPaintInfos});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(pendulumPaintInfos.origin, 6, originPendulumPaint);
    // Trasnslate to the middle of the screen.
    canvas.translate(pendulumPaintInfos.origin.dx, pendulumPaintInfos.origin.dy);

    for (var pendulumPaintInfo in pendulumPaintInfos.allDoublePendulums) {
      // Draws the line for pendulum 1
      canvas.drawLine(pendulumPaintInfo[0].origin, pendulumPaintInfo[0].endPoint,
          pendulumPaint..color = pendulumPaintInfo[0].paintColor);
      // draws the bob for the first pendulum
      canvas.drawCircle(pendulumPaintInfo[0].endPoint, pendulumPaintInfo[0].mass, pendulumPaint);

      // Draws the line for pendulum 2
      canvas.drawLine(pendulumPaintInfo[1].origin, pendulumPaintInfo[1].endPoint,
          pendulumPaint..color = pendulumPaintInfo[1].paintColor);
      // draws the bob for the second pendulum
      canvas.drawCircle(pendulumPaintInfo[1].endPoint, pendulumPaintInfo[1].mass, pendulumPaint..color = Colors.red);

      // draws the trail points.
      canvas.drawPoints(PointMode.lines, pendulumPaintInfo[1].trailPoints, _trailPaint);
      canvas.drawPoints(PointMode.lines, pendulumPaintInfo[0].trailPoints, _trailPaint2);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class PendulumSimulationManager {
  double noOfDoublePendulums;
  double pendulum1Length;
  double pendulum2Length;
  double pendulum1Mass;
  double pendulum2Mass;
  double pendulum1Angle;
  double pendulum2Angle;
  Offset origin;
  double gravity;

  List<List<PendulumInfo>> allDoublePendulums = [];

  PendulumSimulationManager({
    this.origin = Offset.zero,
    required this.noOfDoublePendulums,
    required this.gravity,
    this.pendulum1Length = 200,
    this.pendulum1Mass = 6,
    this.pendulum2Length = 200,
    this.pendulum2Mass = 3,
    this.pendulum1Angle = pi / 2,
    this.pendulum2Angle = pi / 4,
  });

  void initializePendulums() {
    for (int i = 0; i < noOfDoublePendulums; i++) {
      PendulumInfo pendulum1 = PendulumInfo(
        angle: pendulum1Angle + (i * 0.0174533),
        // to account for degrees to radians.
        length: pendulum1Length,
        mass: pendulum1Mass,
        origin: Offset.zero,
        angularVel: 0,
        acc: 0,
      );
      PendulumInfo pendulum2 = PendulumInfo(
        angle: pendulum2Angle,
        length: pendulum2Length,
        mass: pendulum2Mass,
        origin: pendulum1.endPoint,
        angularVel: 0,
        acc: 0,
      );
      allDoublePendulums.add([pendulum1, pendulum2]);
    }
  }

  void reEstimateAngles() {
    for (var pendulums in allDoublePendulums) {
      pendulums[0].angularVel += _simulatedAnglePendulum1(pendulums);
      pendulums[1].angularVel += _simulatedAnglePendulum2(pendulums);
      pendulums[0].angle += pendulums[0].angularVel;
      pendulums[1].angle += pendulums[1].angularVel;
      pendulums[1].origin = pendulums[0].endPoint;
      pendulums[0].trailPoints.add(pendulums[0].endPoint);
      pendulums[1].trailPoints.add(pendulums[1].endPoint);
      if (pendulums[0].trailPoints.length > 200) pendulums[0].trailPoints.removeAt(0);
      if (pendulums[1].trailPoints.length > 200) pendulums[1].trailPoints.removeAt(0);
    }
  }

  double _simulatedAnglePendulum1(List<PendulumInfo> pendulums) {
    PendulumInfo p1 = pendulums[0];
    PendulumInfo p2 = pendulums[1];

    double numerator =
        (-gravity * (2 * p1.mass + p2.mass)) * (sin(p1.angle) - p2.mass * gravity * sin(p1.angle - 2 * p2.angle)) -
            (2 * sin(p1.angle - p2.angle) * p2.mass) *
                (pow(p2.angularVel, 2) * p2.length + pow(p1.angularVel, 2) * p1.length * cos(p1.angle - p2.angle));

    double denominator = p1.length * (2 * p1.mass + p2.mass - p2.mass * cos(2 * p1.angle - 2 * p2.angle));

    return numerator / denominator;
  }

  double _simulatedAnglePendulum2(List<PendulumInfo> pendulums) {
    PendulumInfo p1 = pendulums[0];
    PendulumInfo p2 = pendulums[1];
    double numerator = 2 *
        sin(p1.angle - p2.angle) *
        (p1.angularVel * p1.angularVel * p1.length * (p1.mass + p2.mass) +
            gravity * (p1.mass + p2.mass) * cos(p1.angle) +
            p2.angularVel * p2.angularVel * p2.length * p2.mass * cos(p1.angle - p2.angle));
    double denominator = p2.length * (2 * p1.mass + p2.mass - p2.mass * cos(2 * p1.angle - 2 * p2.angle));

    return numerator / denominator;
  }

  List<List<PendulumInfo>> get allPendudlums => allDoublePendulums;
}
