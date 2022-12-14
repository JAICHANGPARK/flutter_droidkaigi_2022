import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Basic3DRotatePage extends StatefulWidget {
  const Basic3DRotatePage({Key? key}) : super(key: key);

  @override
  State<Basic3DRotatePage> createState() => _Basic3DRotatePageState();
}

class _Basic3DRotatePageState extends State<Basic3DRotatePage> {
  double _rx = 0.0;
  double _ry = 0.0;
  double _rz = 0.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: kIsWeb
          ? Column(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        child: Container(
                          height: 4,
                          color: Colors.black,
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          width: 4,
                          color: Colors.black,
                        ),
                      ),
                      const Positioned(
                        left: -3,
                        top: -3,
                        child: CircleAvatar(
                          radius: 6,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                GestureDetector(
                  onPanUpdate: (detail) {
                    _rx += detail.delta.dx * 0.01;
                    _ry += detail.delta.dy * 0.01;
                    setState(() {
                      // _offset += detail.delta;
                      _rx %= (pi * 2);
                      _ry %= (pi * 2);
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateX(_rx)
                          ..rotateY(_ry)
                          ..rotateZ(_rz),
                        alignment: Alignment.center,
                        child: Center(
                            child: Stack(
                          children: [
                            Transform(
                              transform: Matrix4.identity()
                                ..translate(
                                  0,
                                  0,
                                  -100,
                                ),
                              child: Container(
                                color: Colors.red,
                                child: const FlutterLogo(
                                  size: 200,
                                ),
                              ),
                            ),
                            Transform(
                              transform: Matrix4.identity()
                                ..translate(100, 0, 0)
                                ..rotateY(-pi / 2),
                              alignment: Alignment.center,
                              child: Container(
                                color: Colors.orange,
                                child: const FlutterLogo(
                                  size: 200,
                                ),
                              ),
                            ),
                            Transform(
                              transform: Matrix4.identity()
                                ..translate(0, 100, 0)
                                ..rotateX(-pi / 2),
                              alignment: Alignment.center,
                              child: Container(
                                color: Colors.blue,
                                child: const FlutterLogo(
                                  size: 200,
                                ),
                              ),
                            )
                          ],
                        )),
                      ),
                      const SizedBox(
                        height: 64,
                      ),
                      Row(
                        children: [
                          const Text("X"),
                          Expanded(
                            child: Slider(
                                // value: _offset.dy,
                                value: _rx,
                                min: pi * -2,
                                max: pi * 2,
                                onChanged: (v) {
                                  setState(() {
                                    // _offset = Offset(0, v);
                                    _rx = v;
                                  });
                                }),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Y"),
                          Expanded(
                            child: Slider(
                                // value: _offset.dy,
                                value: _ry,
                                min: pi * -2,
                                max: pi * 2,
                                onChanged: (v) {
                                  setState(() {
                                    // _offset = Offset(0, v);
                                    _ry = v;
                                  });
                                }),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Z"),
                          Expanded(
                            child: Slider(
                                // value: _offset.dy,
                                value: _rz,
                                min: pi * -2,
                                max: pi * 2,
                                onChanged: (v) {
                                  setState(() {
                                    // _offset = Offset(0, v);
                                    _rz = v;
                                  });
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          : defaultTargetPlatform == TargetPlatform.windows
              ? Column()
              : Column(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            child: Container(
                              height: 4,
                              color: Colors.black,
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            bottom: 0,
                            child: Container(
                              width: 4,
                              color: Colors.black,
                            ),
                          ),
                          const Positioned(
                            left: -3,
                            top: -3,
                            child: CircleAvatar(
                              radius: 6,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    GestureDetector(
                      onPanUpdate: (detail) {
                        _rx += detail.delta.dx * 0.01;
                        _ry += detail.delta.dy * 0.01;
                        setState(() {
                          // _offset += detail.delta;
                          _rx %= (pi * 2);
                          _ry %= (pi * 2);
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform(
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateX(_rx)
                              ..rotateY(_ry)
                              ..rotateZ(_rz),
                            alignment: Alignment.center,
                            child: Center(
                                child: Stack(
                              children: [
                                Transform(
                                  transform: Matrix4.identity()
                                    ..translate(
                                      0,
                                      0,
                                      -100,
                                    ),
                                  child: Container(
                                    color: Colors.red,
                                    child: const FlutterLogo(
                                      size: 200,
                                    ),
                                  ),
                                ),
                                Transform(
                                  transform: Matrix4.identity()
                                    ..translate(100, 0, 0)
                                    ..rotateY(-pi / 2),
                                  alignment: Alignment.center,
                                  child: Container(
                                    color: Colors.orange,
                                    child: const FlutterLogo(
                                      size: 200,
                                    ),
                                  ),
                                ),
                                Transform(
                                  transform: Matrix4.identity()
                                    ..translate(0, 100, 0)
                                    ..rotateX(-pi / 2),
                                  alignment: Alignment.center,
                                  child: Container(
                                    color: Colors.blue,
                                    child: const FlutterLogo(
                                      size: 200,
                                    ),
                                  ),
                                )
                              ],
                            )),
                          ),
                          const SizedBox(
                            height: 64,
                          ),
                          Row(
                            children: [
                              const Text("X"),
                              Expanded(
                                child: Slider(
                                    // value: _offset.dy,
                                    value: _rx,
                                    min: pi * -2,
                                    max: pi * 2,
                                    onChanged: (v) {
                                      setState(() {
                                        // _offset = Offset(0, v);
                                        _rx = v;
                                      });
                                    }),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text("Y"),
                              Expanded(
                                child: Slider(
                                    // value: _offset.dy,
                                    value: _ry,
                                    min: pi * -2,
                                    max: pi * 2,
                                    onChanged: (v) {
                                      setState(() {
                                        // _offset = Offset(0, v);
                                        _ry = v;
                                      });
                                    }),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text("Z"),
                              Expanded(
                                child: Slider(
                                    // value: _offset.dy,
                                    value: _rz,
                                    min: pi * -2,
                                    max: pi * 2,
                                    onChanged: (v) {
                                      setState(() {
                                        // _offset = Offset(0, v);
                                        _rz = v;
                                      });
                                    }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
