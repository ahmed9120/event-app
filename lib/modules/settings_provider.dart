import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../core/services/local_storage_keys.dart';
import '../core/services/local_storage_services.dart';
import 'package:location/location.dart';


class SettingsProvider extends ChangeNotifier{

  String currentLanguage = "en";
  ThemeMode currentThemeMode = ThemeMode.light;
  late String? userFullName;
  late String? userEmailAddress;
  late String? userUid;
  /////////////////////////////////
  var location= Location();
  String locationMessage="";
  late GoogleMapController mapController;
  CameraPosition cameraPosition=CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Set<Marker> markers={
    Marker(markerId: MarkerId("1"),
        position: LatLng(37.42796133580664, -122.085749655962)
    )
  };
  LatLng? eventLocation;
  String textAddressLocation="Choose Location";
  /////////////////////////////////

  Future<void> loadSettings() async {
    currentLanguage = LocalStorageServices.getString(LocalStorageKeys.Applanguage) ?? "en";
    currentThemeMode =
    LocalStorageServices.getString(LocalStorageKeys.AppTheme) == "Dark"
        ? ThemeMode.dark
        : ThemeMode.light;
    notifyListeners();
  }
  void changeLanguage(String newLanguage)async{
    if(currentLanguage== newLanguage)return;
    currentLanguage= newLanguage;
    await LocalStorageServices.setString(LocalStorageKeys.Applanguage, currentLanguage);
    notifyListeners();
  }
  void changeTheme(ThemeMode newTheme)async{
    if(currentThemeMode== newTheme)return;
    currentThemeMode=newTheme;
    await LocalStorageServices.setString(LocalStorageKeys.AppTheme, currentThemeMode == ThemeMode.dark?"Dark":"Light");
    notifyListeners();
  }
  bool isDark(){
    return currentThemeMode==ThemeMode.dark;
  }
  void setUserNameAndEmailAndUid({required String name, required String email, required String uid}){
    userFullName= name;
    userEmailAddress= email;
    userUid=uid;
    notifyListeners();
  }
  void resetUserNameAndEmailAndUid(){
    userFullName= null;
    userEmailAddress= null;
    userUid=null;
    notifyListeners();
  }
/////////////////////////////////
  Future<void> getTheLocation()async{
    bool locationPermetedGranted= await _getLocationPermission();
    if(!locationPermetedGranted){
      locationMessage="Location permission denied";
      notifyListeners();
      return;
    }
    bool locationServiceEnabled= await _locationServiceEnable();
    if(!locationServiceEnabled){
      locationMessage="Locaction service disabled";
      notifyListeners();
    }
    LocationData locationData=await  location.getLocation();
    changeLocationOnMap(locationData);
    notifyListeners();
  }
  Future<bool> _getLocationPermission()async{
    var permissionStatus= await location.hasPermission();
    if(permissionStatus== PermissionStatus.denied){
      permissionStatus= await location.requestPermission();
    }
    return permissionStatus ==PermissionStatus.granted;
  }
  Future<bool> _locationServiceEnable()async{
    bool locationServiceEnable= await location.serviceEnabled();
    if(!locationServiceEnable){
      locationServiceEnable= await location.requestService();
    }
    return locationServiceEnable;
  }

  void changeLocationOnMap(LocationData locationData){
    CameraPosition cameraPosition=CameraPosition(
      target: LatLng(locationData.latitude??0, locationData.longitude??0),
      zoom: 15,
    );
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    markers={
      Marker(markerId: MarkerId("2"),position: LatLng(locationData.latitude??0, locationData.longitude??0), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),)

    };
    notifyListeners();
  }
  void setLocationListener(){
    location.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 1000
    );
    location.onLocationChanged.listen((locationData){
      changeLocationOnMap(locationData);
    });
  }

  Future<void> setEventLocation(LatLng newEventLocation)async{
    eventLocation= newEventLocation;
    textAddressLocation= await getAddressFromLatLng(eventLocation!.latitude, eventLocation!.longitude)?? "";
    notifyListeners();
  }

  Future<String?> getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return "${place.locality}\n${place.country}";
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}