import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_droidkaigi_2022/const.dart';
import 'package:flutter_droidkaigi_2022/src/model/face.dart';

import 'package:http/http.dart' as http;

/// https://github.com/adityar224/Random-Face-Generator/blob/master/lib/home.dart
class FakeFaceWidget extends StatefulWidget {
  const FakeFaceWidget({Key? key}) : super(key: key);

  @override
  State<FakeFaceWidget> createState() => _FakeFaceWidgetState();
}

class _FakeFaceWidgetState extends State<FakeFaceWidget> {
  int _minimumAge = 0, _maximumAge = 100, _selectedIndex = 2;
  late String queryUrl, imageUrl;
  late Uint8List imageList;
  bool _loading = true;

  @override
  void initState() {
    queryUrl = kDefaultUrl;
    imageUrl = kInitialUrl;
    if (kIsWeb) imageUrl = kCorsProxyUrl + imageUrl;
    super.initState();
    _fetchImage();
  }

  Future _fetchImage() async {
    _setGenderQuery();
    _setAgeQuery();
    setState(() {
      _loading = true;
    });
    try {
      if (queryUrl == kDefaultUrl) {
        imageUrl = kInitialUrl;
      } else {
        final response = await http.get(Uri.parse(queryUrl));
        imageUrl = Face.fromJson(jsonDecode(response.body)).imageUrl;
      }
      if (kIsWeb) imageUrl = kCorsProxyUrl + imageUrl;
      imageList = await http.readBytes(Uri.parse(imageUrl));
    } catch (e) {
      if (e.runtimeType == SocketException) {
        _displayErrorAlert(
          "Network Error",
          "Unable to connect to the internet. Please check your internet connection and try again.",
        );
      } else if (e.runtimeType == FormatException) {
        _displayErrorAlert(
          "Invalid Range",
          "Unable to generate a face in this age range. Please try again with a different range.",
        );
      } else {
        _displayErrorAlert(
          "Unknown Error Occurred",
          "Please Try again Later.",
        );
      }
      return;
    }
    setState(() {
      _loading = false;
    });
  }

  Widget _imageView() {
    return GestureDetector(
      onTap: () {
        _fetchImage();
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        child: (_loading)
            ? const FittedBox(
                fit: BoxFit.none,
                child: CircularProgressIndicator(),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.memory(
                  imageList,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }

  Future _displayErrorAlert(String title, String content) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _setMale() {
    setState(() {
      _selectedIndex = 0;
    });
  }

  void _setFemale() {
    setState(() {
      _selectedIndex = 1;
    });
  }

  void _setRandom() {
    setState(() {
      _selectedIndex = 2;
    });
  }

  void _setAgeRange(RangeValues range) {
    setState(() {
      _minimumAge = range.start.floor();
      _maximumAge = range.end.floor();
    });
  }

  void _setGenderQuery() {
    switch (_selectedIndex) {
      case 0:
        queryUrl = kDefaultUrl + "?gender=male";
        break;
      case 1:
        queryUrl = kDefaultUrl + "?gender=female";
        break;
      case 2:
        queryUrl = kDefaultUrl;
        break;
    }
  }

  void _setAgeQuery() {
    if (_selectedIndex != 2) {
      if (_minimumAge != 0) {
        queryUrl += "&minimum_age=$_minimumAge";
      }
      if (_maximumAge != 100) {
        queryUrl += "&maximum_age=$_maximumAge";
      }
    } else {
      if (_minimumAge != 0) {
        queryUrl += "?minimum_age=$_minimumAge";
        if (_maximumAge != 100) {
          queryUrl += "&maximum_age=$_maximumAge";
        }
      } else if (_maximumAge != 100) {
        queryUrl += "?maximum_age=$_maximumAge";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_imageView(), const Text("thispersondoesnotexist")],
    );
  }
}
