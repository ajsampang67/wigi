import 'dart:developer';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wigi/src/location.dart';
import 'src/snap_carousel.dart';

void main() {
  runApp(Wigi());
}

class Wigi extends StatefulWidget {
  const Wigi({super.key});

  @override
  State<Wigi> createState() => _WigiState();
}

class _WigiState extends State<Wigi> {
  List<WigiLocation> _wigiLocations = [];

  @override
  void initState() {
    super.initState();
    parseWigiLocationCSV();
  }

  // [
  //   WigiLocation(
  //     "The BRIX on the Fox",
  //     1,
  //     6,
  //     "__YOU ARE HERE__ \n\nThe BRIX on the Fox was the second venue we visited, and as soon as we left, Alyssa and I knew this was the one. We got in the car and talked about how this was the only place we could truly visualize ourselves getting married. The owners, Rob and Tone, were very thoughtful and purposeful when designing the space. The acoustics, ceremony placement, and ease-of-dance played a large part in our decision.",
  //     42.10512303768408,
  //     -88.28441944549861,
  //     [],
  //   ),
  //   WigiLocation(
  //     "Uptown La Grange Apartments",
  //     2,
  //     0,
  //     "",
  //     41.81855079921119,
  //     -87.86796435280937,
  //     [],
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green[700],
      ),
      home: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: SnapCarousel(wigiLocations: _wigiLocations),
      ),
    );
  }

  void parseWigiLocationCSV() async {
    final wigiLocationsCSV = await rootBundle.loadString(
      "assets/wigiLocations.csv",
    );
    List<List<String>> wigiLocationsList =
        const CsvToListConverter(shouldParseNumbers: false)
            .convert(wigiLocationsCSV, eol: "\n");

    log(wigiLocationsList.toString());

    List<WigiLocation> wigiLocations = [];

    for (int i = 0; i < wigiLocationsList.length; i++) {
      List rawWigiLocation = wigiLocationsList[i];
      List dates = rawWigiLocation.sublist(6);
      wigiLocations.add(
        WigiLocation(
          rawWigiLocation[0],
          int.parse(rawWigiLocation[1]),
          int.parse(rawWigiLocation[2]),
          rawWigiLocation[3],
          double.parse(rawWigiLocation[4]),
          double.parse(rawWigiLocation[5]),
          dates,
        ),
      );
    }
    setState(() {
      _wigiLocations = wigiLocations;
    });
  }
}
