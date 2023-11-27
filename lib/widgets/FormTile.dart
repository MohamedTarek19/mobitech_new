import 'package:flutter/material.dart';

class FormTile extends StatelessWidget {
  String tileName;
  var ontap;
  String? data;
  FormTile({
    super.key,
    required this.tileName,
    required this.ontap,
    this.data
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(tileName,style: const TextStyle(color: Colors.white,fontSize: 18),),
          InkWell(
            onTap: ontap,
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(data ?? tileName,style: const TextStyle(color: Colors.grey,fontSize: 15),),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}