import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/form_info.dart';
import 'package:mobitech/view/maintance/maintain_form/photo_data.dart';
import 'package:mobitech/widgets/cuttom_appbar.dart';
import 'package:mobitech/view/maintance/mhelper.dart';

class googleMaps extends StatefulWidget {
  const googleMaps({Key? key}) : super(key: key);

  @override
  State<googleMaps> createState() => _googleMapsState();
}

class _googleMapsState extends State<googleMaps> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer<GoogleMapController>();
  GoogleMapController? newGoogleMapController;

  double bottomPaddingOfMap = 0;
  Position? currentPosition;
  var markedPosition;

  bool serviceEnabled = false;
  LocationPermission? permission;
  var geolocator = Geolocator();

  _locatePosition() async{
    Position p = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPosition = p;
      markedPosition = LatLng(p.latitude,p.longitude);
    });
    LatLng latlngposition = LatLng(currentPosition!.latitude,currentPosition!.longitude);
    CameraPosition cam = new CameraPosition(target: latlngposition,zoom: 14);
    newGoogleMapController!.animateCamera(CameraUpdate.newCameraPosition(cam));
  }
  alert(String field){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        icon: Icon(Icons.dangerous,size: 55,),
        iconColor: Colors.red,
        title: Text('الرجاء إدخال ${field}',style: TextStyle(color: Colors.black,fontSize: 17),textDirection: TextDirection.rtl,),
        actions: [
          ElevatedButton(onPressed: (){Navigator.of(context).pop();}, child: Text('حسنا'))
        ],
      );
    });
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
        appBar: AppBar(elevation: 0, title: Text(
          "الرجاء تحديد موقعك",
          style: Theme.of(context).textTheme.headline2,
        ),
        centerTitle: true,
      ),
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
                  onDragEnd: (value) {
                    setState(() {
                      print(value);
                      if(value ==null){
                        MHelper.location = LatLng(currentPosition?.latitude?? 0, currentPosition?.longitude?? 0);
                        markedPosition = MHelper.location;
                      }
                      markedPosition = value;
                      MHelper.location = value;
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
                height: 250,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft : Radius.circular(10),topRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(color: Colors.black,blurRadius: 16.0,spreadRadius: 0.5,offset: Offset(0.7, 0.7))
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
                              Icon(Icons.home,color: Colors.grey),
                              SizedBox(width: 12,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("موقعك الحالي: ",style: TextStyle(color: Colors.white),),
                                  SizedBox(height: 4,),
                                  Text('(${currentPosition?.latitude?? 'open you location services'}, ${currentPosition?.longitude?? ''})',style: TextStyle(color: Colors.grey[200],fontSize: 12.0),),
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
                                child: Icon(Icons.refresh),style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                              )
                          )
                        ],
                      ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(5.0),
                      //     boxShadow: const [
                      //       BoxShadow(color: Colors.black45,blurRadius: 6.0,spreadRadius: 0.5,offset: Offset(0.7, 0.7))
                      //     ],
                      //   ),
                      //   child: Row(
                      //     children: const [
                      //       Icon(Icons.search,color: Colors.yellow,),
                      //       SizedBox(width: 10,),
                      //       Text("search drop of Location",),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(height: 5,),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(120, 10, 0, 10),
                          width: 200,
                          height: 2,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on,color: Colors.grey),
                          SizedBox(width: 12,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("موقع المحدد الخاص بك: ",style: TextStyle(color: Colors.white),),
                              SizedBox(height: 4,),
                              Text('(${markedPosition?.latitude?? 'إضغط مطولا على المحدد'}, ${markedPosition?.longitude?? ''})',style: TextStyle(color: Colors.grey[200],fontSize: 12.0),),
                            ],
                          )
                        ],
                      ),
                      Expanded(child: Container()),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ListTile(
                            onTap: (){
                              FormInfo.location = markedPosition;
                              Map<String,bool> locationvalid = FormInfo.locationPageValidate()??{};
                              if(locationvalid.entries.first.value == false){
                                alert(locationvalid.entries.first.key);
                                return;
                              }
                              Navigation.puchNav(PhotoDoc(), context);
                            },
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("إختار المكان", style: TextStyle(color: Colors.black, fontSize: 13),),
                                Icon(Icons.arrow_circle_left_sharp),
                              ],
                            ),
                            tileColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
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




