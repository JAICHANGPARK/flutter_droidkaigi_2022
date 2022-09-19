// Copyright 2021 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_droidkaigi_2022/src/screen/theme/nav_bars.dart';
import 'package:widget_with_codeview/widget_with_codeview.dart';

const _rowDivider = SizedBox(width: 10);
const _colDivider = SizedBox(height: 10);
const double _cardWidth = 115;
const double _maxWidthConstraint = 500;

class ComponentScreen extends StatelessWidget {
  const ComponentScreen({super.key, required this.showNavBottomBar});

  final bool showNavBottomBar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: _maxWidthConstraint,
          child: ListView(
            shrinkWrap: true,
            children: [
              _colDivider,
              _colDivider,
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Buttons"),
              ),
              const Buttons(),
              _colDivider,
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("FloatingActionButtons"),
              ),
              const FloatingActionButtons(),
              _colDivider,
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Cards"),
              ),
              const Cards(),
              _colDivider,
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Chips"),
              ),
              const Chips(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Switchs"),
              ),
              const Switchs(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Sliders"),
              ),
              const Sliders(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Dialogs"),
              ),
              const Dialogs(),
              _colDivider,
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("NavigationBars"),
              ),
              showNavBottomBar
                  ? const NavigationBars(
                      selectedIndex: 0,
                      isExampleBar: true,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class IconButtons extends StatefulWidget {
  const IconButtons({Key? key}) : super(key: key);

  @override
  State<IconButtons> createState() => _IconButtonsState();
}

class _IconButtonsState extends State<IconButtons> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
       
      ],
    );
  }
}

void Function()? handlePressed(
  BuildContext context,
  bool isDisabled,
  String buttonName,
) {
  return isDisabled
      ? null
      : () {
          // showDialog(
          //   context: context,
          //   builder: (context) => AlertDialog(
          //     content: SizedBox(
          //       width: MediaQuery.of(context).size.width - 200,
          //       child: WidgetWithCodeView(
          //         child: Container(),
          //         sourceFilePath: 'lib/main.dart',
          //         codeLinkPrefix: 'https://google.com?q=',
          //         iconBackgroundColor: Colors.white,
          //         iconForegroundColor: Colors.pink,
          //         labelBackgroundColor: Theme.of(context).canvasColor,
          //         labelTextStyle: const TextStyle(color: Colors.black),
          //         showLabelText: true,
          //         syntaxHighlighterStyle: SyntaxHighlighterStyle.darkThemeStyle().copyWith(
          //           commentStyle: const TextStyle(color: Colors.yellow),
          //           keywordStyle: const TextStyle(color: Colors.lightGreen),
          //           classStyle: const TextStyle(color: Colors.amber),
          //           numberStyle: const TextStyle(color: Colors.orange),
          //           baseStyle: const TextStyle(color: Colors.black),
          //           constantStyle: const TextStyle(color: Colors.black),
          //           punctuationStyle: const TextStyle(color: Colors.black),
          //           stringStyle: const TextStyle(color: Colors.black),
          //         ),
          //       ),
          //     ),
          //   ),
          // );
          // final snackBar = SnackBar(
          //   content: Text(
          //     'Yay! $buttonName is clicked!',
          //     style: TextStyle(color: Theme.of(context).colorScheme.surface),
          //   ),
          //   action: SnackBarAction(
          //     textColor: Theme.of(context).colorScheme.surface,
          //     label: 'Close',
          //     onPressed: () {},
          //   ),
          // );
          //
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        };
}

class Buttons extends StatefulWidget {
  const Buttons({super.key});

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      children: const <Widget>[
        ButtonsWithoutIcon(isDisabled: false),
        _rowDivider,
        ButtonsWithIcon(),
        _rowDivider,
        ButtonsWithoutIcon(isDisabled: true),
      ],
    );
  }
}

class ButtonsWithoutIcon extends StatelessWidget {
  final bool isDisabled;

  const ButtonsWithoutIcon({super.key, required this.isDisabled});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ElevatedButton(
            onPressed: handlePressed(context, isDisabled, "ElevatedButton"),
            child: const Text("Elevated"),
          ),
          _colDivider,
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              // Foreground color
              // ignore: deprecated_member_use
              onPrimary: Theme.of(context).colorScheme.onPrimary,
              // Background color
              // ignore: deprecated_member_use
              primary: Theme.of(context).colorScheme.primary,
            ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
            onPressed: handlePressed(context, isDisabled, "FilledButton"),
            child: const Text('Filled'),
          ),
          _colDivider,
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              // Foreground color
              // ignore: deprecated_member_use
              onPrimary: Theme.of(context).colorScheme.onSecondaryContainer,
              // Background color
              // ignore: deprecated_member_use
              primary: Theme.of(context).colorScheme.secondaryContainer,
            ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
            onPressed: handlePressed(context, isDisabled, "FilledTonalButton"),
            child: const Text('Filled Tonal'),
          ),
          _colDivider,
          OutlinedButton(
            onPressed: handlePressed(context, isDisabled, "OutlinedButton"),
            child: const Text("Outlined"),
          ),
          _colDivider,
          TextButton(
            onPressed: handlePressed(context, isDisabled, "TextButton"),
            child: const Text("Text"),
          ),
        ],
      ),
    );
  }
}

class ButtonsWithIcon extends StatelessWidget {
  const ButtonsWithIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ElevatedButton.icon(
            onPressed: handlePressed(context, false, "ElevatedButton with Icon"),
            icon: const Icon(Icons.add),
            label: const Text("Icon"),
          ),
          _colDivider,
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              // Foreground color
              // ignore: deprecated_member_use
              onPrimary: Theme.of(context).colorScheme.onPrimary,
              // Background color
              // ignore: deprecated_member_use
              primary: Theme.of(context).colorScheme.primary,
            ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
            onPressed: handlePressed(context, false, "FilledButton with Icon"),
            label: const Text('Icon'),
            icon: const Icon(Icons.add),
          ),
          _colDivider,
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              // Foreground color
              // ignore: deprecated_member_use
              onPrimary: Theme.of(context).colorScheme.onSecondaryContainer,
              // Background color
              // ignore: deprecated_member_use
              primary: Theme.of(context).colorScheme.secondaryContainer,
            ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
            onPressed: handlePressed(context, false, "FilledTonalButton with Icon"),
            label: const Text('Icon'),
            icon: const Icon(Icons.add),
          ),
          _colDivider,
          OutlinedButton.icon(
            onPressed: handlePressed(context, false, "OutlinedButton with Icon"),
            icon: const Icon(Icons.add),
            label: const Text("Icon"),
          ),
          _colDivider,
          TextButton.icon(
            onPressed: handlePressed(context, false, "TextButton with Icon"),
            icon: const Icon(Icons.add),
            label: const Text("Icon"),
          )
        ],
      ),
    );
  }
}

class FloatingActionButtons extends StatelessWidget {
  const FloatingActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          FloatingActionButton.small(
            heroTag: "00",
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
          _rowDivider,
          FloatingActionButton(
            heroTag: "01",
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
          _rowDivider,
          FloatingActionButton.extended(
            heroTag: "02",
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text("Create"),
          ),
          _rowDivider,
          FloatingActionButton.large(
            heroTag: "03",
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

class Sliders extends StatefulWidget {
  const Sliders({Key? key}) : super(key: key);

  @override
  State<Sliders> createState() => _SlidersState();
}

class _SlidersState extends State<Sliders> {
  double _sliderValule = 0.0;

  @override
  Widget build(BuildContext context) {
    return Slider(
        value: _sliderValule,
        onChanged: (d) {
          setState(() {
            _sliderValule = d;
          });
        });
  }
}

class Switchs extends StatefulWidget {
  const Switchs({super.key});

  @override
  State<Switchs> createState() => _SwitchsState();
}

class _SwitchsState extends State<Switchs> {
  bool _switchState0 = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        children: [
          Switch(
              value: _switchState0,
              onChanged: (b) {
                setState(() {
                  _switchState0 = b;
                });
              })
        ],
      ),
    );
  }
}

class Chips extends StatefulWidget {
  const Chips({Key? key}) : super(key: key);

  @override
  State<Chips> createState() => _ChipsState();
}

class _ChipsState extends State<Chips> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 16,
      runSpacing: 16,
      children: [
        const Chip(label: Text('Normal Chip')),
        const ActionChip(label: Text('Action Chip')),
        FilterChip(
          label: const Text('Filter Chip : True'),
          onSelected: (d) {},
          selected: true,
        ),
        FilterChip(
          label: const Text('Filter Chip: False'),
          onSelected: (d) {},
          selected: false,
        ),
        ChoiceChip(
          label: const Text('Choice Chip : True'),
          onSelected: (d) {},
          selected: true,
        ),
        ChoiceChip(
          label: const Text('Choice Chip : False'),
          onSelected: (d) {},
          selected: false,
        ),
        const InputChip(
          label: Text('Input Chip : True'),
        ),
        const RawChip(
          label: Text('Raw Chip'),
        )
      ],
    );
  }
}

class Cards extends StatelessWidget {
  const Cards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: _cardWidth,
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: const [
                    Align(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.more_vert),
                    ),
                    SizedBox(height: 35),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text("Elevated"),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: _cardWidth,
            child: Card(
              color: Theme.of(context).colorScheme.surfaceVariant,
              elevation: 0,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: const [
                    Align(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.more_vert),
                    ),
                    SizedBox(height: 35),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text("Filled"),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: _cardWidth,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: const [
                    Align(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.more_vert),
                    ),
                    SizedBox(height: 35),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text("Outlined"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Dialogs extends StatefulWidget {
  const Dialogs({super.key});

  @override
  State<Dialogs> createState() => _DialogsState();
}

class _DialogsState extends State<Dialogs> {
  void openDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Basic Dialog Title"),
        content: const Text(
            "A dialog is a type of modal window that appears in front of app content to provide critical information, or prompt for a decision to be made."),
        actions: <Widget>[
          TextButton(
            child: const Text('Dismiss'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Action'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextButton(
        child: const Text(
          "Open Dialog",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: () => openDialog(context),
      ),
    );
  }
}
