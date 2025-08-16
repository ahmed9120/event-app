import 'package:event_app/modules/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../core/theme_manager/color_pallete.dart';

class PickEventMapScreen extends StatefulWidget {
  const PickEventMapScreen({super.key});

  @override
  State<PickEventMapScreen> createState() => _PickEventMapScreenState();
}

class _PickEventMapScreenState extends State<PickEventMapScreen> {
  late SettingsProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<SettingsProvider>(context, listen: false);
    provider.getTheLocation();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: theme.primaryColor,

        child: Icon(
          Icons.gps_fixed,
          color: provider.isDark()
              ? ColorPallete.darkBackgroundColor
              : ColorPallete.white,
        ),
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, provider, child) => GoogleMap(
          onTap: (location)async{
            await provider.setEventLocation(location);
            Navigator.pop(context);
          },
          mapType: MapType.normal,
          initialCameraPosition: provider.cameraPosition,
          onMapCreated: (mapController) {
            provider.mapController = mapController;
          },
          markers: provider.markers,
        ),
      ),
    );
  }
}
