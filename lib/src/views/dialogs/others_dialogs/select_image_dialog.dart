import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moonapp/src/styles/app_styles.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/interfaces.dart';

class SelectImageDialog extends StatefulWidget {
  final OnImageSelectedListener onGetImageListener;

  SelectImageDialog({@required this.onGetImageListener});

  @override
  _SelectImageDialogState createState() => _SelectImageDialogState();
}

class _SelectImageDialogState extends State<SelectImageDialog> {
  ImagePicker _imagePicker;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imagePicker = ImagePicker();
  }

  void getProfileImage(ImageSource imageSource) async {
    Navigator.pop(context);
    if (imageSource == ImageSource.gallery)
      widget.onGetImageListener.selectedImage(await _imagePicker.getImage(
          source: ImageSource.gallery, imageQuality: 70));
    else
      widget.onGetImageListener.selectedImage(await _imagePicker.getImage(
          source: ImageSource.camera, imageQuality: 70));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppShared.screenUtil.setHeight(550),
      alignment: AlignmentDirectional.centerStart,
      padding: AppStyles.defaultPadding3,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Text(
              AppShared.appLang['ChooseFrom'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            onTap: () {
              getProfileImage(ImageSource.camera);
            },
            title: Text(
              AppShared.appLang['Camera'],
            ),
          ),
          ListTile(
            onTap: () {
              getProfileImage(ImageSource.gallery);
            },
            title: Text(
              AppShared.appLang['Gallery'],
            ),
          ),
        ],
      ),
    );
  }
}
