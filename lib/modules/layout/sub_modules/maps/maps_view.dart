import 'package:event_app/core/theme_manager/color_pallete.dart';
import 'package:event_app/modules/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class MapsView extends StatefulWidget {
  const MapsView({super.key});

  @override
  State<MapsView> createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView> {
  late SettingsProvider provider;

  @override
  void initState() {
    provider = Provider.of(context, listen: false);
    provider.getTheLocation();
    //provider.setLocationListener();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      floatingActionButtonLocation:FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
          onPressed: ()async{
            var location = Location();
            LocationData locationData=await  location.getLocation();
            provider.changeLocationOnMap(locationData);
          },
        backgroundColor: theme.primaryColor,

        child: Icon(Icons.gps_fixed, color: provider.isDark()?ColorPallete.darkBackgroundColor:ColorPallete.white,),
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, provider, child) => GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: provider.cameraPosition,
          onMapCreated: (mapController){
            provider.mapController=mapController;
          },
          markers: provider.markers,
        ),
      ),
    );
  }
}
