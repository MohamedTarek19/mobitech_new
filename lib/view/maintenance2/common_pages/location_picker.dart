import 'dart:async';
import 'package:flutter/material.dart';

import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart' as lot;

import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/utils/navigation.dart';

import 'package:mobitech/view/maintenance2/maintenance_helper.dart';
import 'package:mobitech/view/maintenance2/common_pages/photo_picker.dart';
import 'package:mobitech/widgets/cuttom_appbar.dart';
import 'package:mobitech/view/maintance/mhelper.dart';
import 'package:mobitech/widgets/error_message_alert.dart';
import 'package:provider/provider.dart';
//import 'package:yandex_geocoder/yandex_geocoder.dart';

class googleMaps extends StatefulWidget {
  const googleMaps({Key? key}) : super(key: key);

  @override
  State<googleMaps> createState() => _googleMapsState();
}

class _googleMapsState extends State<googleMaps> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer<GoogleMapController>();
  GoogleMapController? newGoogleMapController;
  bool loading1 = true;
  bool loading2 = true;
  bool resetLocation = false;


  List<Placemark>? placemarks;
  List<Placemark>? currentPlace;
  //GeocodeResponse? geocodeFromPoint;
  double bottomPaddingOfMap = 0;
  Position? currentPosition;
  var markedPosition;
  Locale loc = const Locale("ar");
  //final YandexGeocoder geocoder = YandexGeocoder(apiKey: 'AIzaSyD-Swl2LtadkgvPmnOnxliJ_hwvtvKGU5k');
  bool serviceEnabled = false;
  LocationPermission? permission;
  var geolocator = Geolocator();

  _locatePosition() async{
    setState(() {
      resetLocation = true;
    });
    Position p = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPosition = p;
      markedPosition = LatLng(p.latitude,p.longitude);
      // geocoder.getGeocode(GeocodeRequest(
      //   geocode: PointGeocode(latitude: 55.771899, longitude: 37.597576),
      //   lang: Lang.enEn,
      // )).then((value){
      //   setState(() {
      //     geocodeFromPoint = value;
      //
      //   });
      //   print(geocodeFromPoint?.firstFullAddress.formattedAddress.toString());
      // });
      placemarkFromCoordinates(p.latitude,p.longitude,localeIdentifier: loc.languageCode).then((value) {
        setState(() {
          resetLocation = false;
          loading1 = false;
          loading2 = false;
          currentPlace = value;
          placemarks = value;
          FormHelper.Location = '${(((placemarks?[0].street.toString()??'إضغط مطولا على المحدد')+', '+(placemarks?[0].locality.toString()??'')+', '+(placemarks?[0].country.toString()??'')))??''}';
        });
      });
    });
    LatLng latlngposition = LatLng(currentPosition!.latitude,currentPosition!.longitude);
    CameraPosition cam = new CameraPosition(target: latlngposition,zoom: 14);
    newGoogleMapController!.animateCamera(CameraUpdate.newCameraPosition(cam));
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body:Stack(
          children: [
            GoogleMap(
              padding: EdgeInsets.only(bottom: bottomPaddingOfMap,top: 0,right: 0,left: 0),
              mapType: MapType.normal,
              myLocationEnabled: true,
              myLocationButtonEnabled:true,
              initialCameraPosition: _kGooglePlex,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              onTap: (val){
                print("#########################################################3");
              },
              onMapCreated: (GoogleMapController controller) async {
                _controllerGoogleMap.complete(controller);
                newGoogleMapController = controller;
                setState(() {
                  bottomPaddingOfMap = 300.0;
                });
                serviceEnabled = await Geolocator.isLocationServiceEnabled();
                if (!serviceEnabled) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: Duration(seconds: 5),
                    backgroundColor: Colors.red,
                    content: Text('Location services are disabled.'),
                  ));
                }
                permission = await Geolocator.checkPermission();
                if (permission == LocationPermission.denied) {
                  permission = await Geolocator.requestPermission();
                  if (permission == LocationPermission.denied) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 5),
                      backgroundColor: Colors.red,
                      content: Text('Location permissions are denied'),
                    ));
                  }
                }
                setState(() {
                  _locatePosition();
                });
              },
              markers: {
                Marker(
                  markerId: const MarkerId("marker1"),
                  position: LatLng(currentPosition?.latitude?? 0, currentPosition?.longitude?? 0),
                  draggable: true,
                  onDragStart:(value){
                    setState(() {
                      loading2 = true;
                    });

                  },
                  onDragEnd: (value) {
                    setState((){
                      print(value);
                      if(value ==null){
                        MHelper.location = LatLng(currentPosition?.latitude?? 0, currentPosition?.longitude?? 0);
                        markedPosition = MHelper.location;
                        placemarkFromCoordinates(currentPosition?.latitude??0,currentPosition?.longitude??0,localeIdentifier: loc.languageCode).then((value)
                        {
                          setState(() {
                            FormHelper.coordinates = (currentPosition?.latitude??0).toString() + ", "+(currentPosition?.longitude??0).toString();
                            placemarks  = value;
                            loading2 = false;
                          });

                        });
                      }
                      FormHelper.coordinates = value.latitude.toString() + ', ' + value.longitude.toString();
                      placemarkFromCoordinates(value.latitude,value.longitude,localeIdentifier: loc.languageCode).then((value)
                      {
                        setState(() {

                          placemarks  = value;
                          loading2 = false;
                        });
                      });
                      markedPosition = value;
                      FormHelper.Location = '${(((placemarks?[0].street.toString()??'إضغط مطولا على المحدد')+', '+(placemarks?[0].locality.toString()??'')+', '+(placemarks?[0].country.toString()??'')))??''}';
                      print("################[marked position]################\n${MHelper.location}");
                      print("################[marked position]################\n${markedPosition}");

                    });
                  },
                  icon: markerIcon,
                ),
              },
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: Container(
                height: MediaQuery.of(context).size.height*0.33,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft : Radius.circular(10),topRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(color: Colors.black,blurRadius: 14.0,spreadRadius: 0.5,offset: Offset(0.7, 0.7))
                  ],

                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height:  6,),
                      Row(
                        children: [
                          Row(
                            children: [
                              loading1 == true ? lot.Lottie.asset("assets/loading.json",):
                              Icon(Icons.home,color: Colors.yellow[700]),
                              const SizedBox(width: 12,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("موقعك الحالي: ",style: TextStyle(color: Colors.white),),
                                  Container(height: MediaQuery.of(context).size.height*0.04,width: MediaQuery.of(context).size.width*0.5,
                                    child: SingleChildScrollView(scrollDirection:Axis.horizontal,
                                        child: Text('${(((currentPlace?[0].street.toString()??'')+', '+(currentPlace?[0].locality.toString()??'')+', '+(currentPlace?[0].country.toString()??'')))?? 'open you location services'}',
                                          style: TextStyle(color: Colors.grey[200],fontSize: 15.0),)),
                                  ),
                                ],
                              )
                            ],
                          ),
                          // SizedBox(width: 100,),
                          Expanded(child: Container()),
                          Align(
                              alignment: Alignment.topRight,
                              child: ElevatedButton(onPressed: (){setState(() {_locatePosition();});
                              },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                  maximumSize: const Size(60, 40),
                                  minimumSize: const Size(60, 40),
                                ),
                                ///////////////////////////////////////////////////////////
                                child: resetLocation == false ?const Icon(Icons.refresh): const Padding(
                                  padding: EdgeInsets.only(top: 10.0,bottom: 10.0,left:5,right: 5),
                                  child: CircularProgressIndicator(color: Colors.white,),
                                ),
                              )
                          )
                        ],
                      ),
                      const SizedBox(height: 5,),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.fromLTRB(120, 10, 0, 10),
                          width: 200,
                          height: 2,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          loading2 == true ? lot.Lottie.asset("assets/loading.json",):const Icon(Icons.location_on,color: Colors.red),
                          const SizedBox(width: 12,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("موقع المحدد الخاص بك: ",style: TextStyle(color: Colors.white),),
                              const SizedBox(height: 4,),
                              Container(
                                height: MediaQuery.of(context).size.height*0.04,
                                width:  MediaQuery.of(context).size.width*0.7,
                                child: SingleChildScrollView(scrollDirection:Axis.horizontal,
                                    child: Text('${(((placemarks?[0].street.toString()??'إضغط مطولا على المحدد')+', '+(placemarks?[0].locality.toString()??'')+', '+(placemarks?[0].country.toString()??'')))??''}',style: TextStyle(color: Colors.grey[200],fontSize: 15.0),)),
                              ),


                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height*0.07),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            if(markedPosition ==null){
                              alert('موقعك',context);
                            }else{
                              Navigation.puchNav(PhotoPicker(), context);
                            }
                                // [
                                //   {'location': '${(((placemarks?[1].street.toString()??'')+', '+(placemarks?[1].locality.toString()??'')+', '+(placemarks?[1].country.toString()??'')))??''}'},
                                //   {'coordinates':  markedPosition},
                                //
                                //
                                // ]


                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("التالي",style: TextStyle(color: Color(0xff50B04F),fontSize: 20),),
                              const Icon(Icons.arrow_circle_left_outlined,color: Color(0xff50B04F),size: 30,)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ) ,

      ),
    );
  }
}




