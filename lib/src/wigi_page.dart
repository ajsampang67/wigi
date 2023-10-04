import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wigi/src/carousel_with_indicator.dart';
import 'location.dart';

class WigiPage extends StatelessWidget {
  final WigiLocation wigiLocation;
  final int index;

  late GoogleMapController mapController;

  WigiPage({super.key, required this.wigiLocation, required this.index});

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  // Set<Marker> markers = {};
  // markers.addLabelMarker(
  //   LabelMarker(
  //     label: wigiLocation.index.toString(),
  //     markerId: MarkerId(wigiLocation.index.toString()),
  //     position: LatLng(wigiLocation.latitude, wigiLocation.longitude),
  //     backgroundColor: Colors.green,
  //   ),
  // );

  @override
  Widget build(BuildContext context) {
    Widget googleMap = GoogleMap(
      markers: {
        Marker(
          markerId: MarkerId(wigiLocation.name),
          position: LatLng(wigiLocation.latitude, wigiLocation.longitude),
        )
      },
      zoomControlsEnabled: false,
      mapType: MapType.hybrid,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(wigiLocation.latitude, wigiLocation.longitude),
        zoom: 12.5,
      ),
    );

    return buildWigiPage(context, wigiLocation, googleMap);
  }
}

Widget buildWigiPage(
    BuildContext context, WigiLocation wigiLocation, Widget googleMap) {
  double screenHeight = MediaQuery.of(context).size.height;

  Widget titleWidget = Padding(
    padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
    child: Wrap(
      //fit: BoxFit.fitHeight,
      children: <Widget>[
        Text(
          wigiLocation.name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: 'overpass',
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );

  Widget googleMapsWidget = Container(
    margin: const EdgeInsets.all(10.0),
    padding: const EdgeInsets.all(20.0),
    child: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      child: SizedBox(
        height: 250,
        child: googleMap,
      ),
    ),
  );

  Widget imgCarousel = SizedBox(
    height: 250,
    child: CarouselWithIndicator(imgList: getImgList(wigiLocation)),
  );

  Widget description = Container(
    margin: const EdgeInsets.all(10.0),
    child: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      child: SizedBox(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: MarkdownBody(data: wigiLocation.description),
        ),
      ),
    ),
  );

  return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          titleWidget,
          imgCarousel,
          description,
          googleMapsWidget,
        ],
      ),
    ),
  );
}

List<String> getImgList(WigiLocation wigiLocation) {
  List<String> imgList = [];
  String s3BucketRoot = "https://ajsampangdotcom.s3.amazonaws.com/wigi/";
  int index = wigiLocation.index;

  for (var i = 1; i < wigiLocation.numImages + 1; i++) {
    imgList.add('$s3BucketRoot$index/$i.jpg');
  }

  return imgList;
}
