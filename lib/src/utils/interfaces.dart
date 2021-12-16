import 'package:image_picker/image_picker.dart';
import 'package:moonapp/src/models/api_models/sub_models/city.dart';

// ||... File For interfaces inside the app ...||

// interface for select image dialog.
abstract class OnImageSelectedListener {
  void selectedImage(PickedFile image);
}

// interface for choose city dialog.
abstract class OnCitySelectedListener {
  void selectedCity(City city);
}
