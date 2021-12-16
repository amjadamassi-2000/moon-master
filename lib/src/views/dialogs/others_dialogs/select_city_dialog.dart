import 'package:flutter/material.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/interfaces.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';

class SelectCityDialog extends StatefulWidget {
  final OnCitySelectedListener onCitySelectedListener;

  SelectCityDialog({@required this.onCitySelectedListener});

  @override
  _SelectCityDialogState createState() => _SelectCityDialogState();
}

class _SelectCityDialogState extends State<SelectCityDialog> {
  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(12),
                child: Text(
                  AppShared.appLang['SelectACity'],
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: AppShared.settingResponse.settings.cities.length,
                  itemBuilder: (_, index) => ListTile(
                    leading: Icon(
                      Icons.location_city,
                      color: Colors.orange,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      widget.onCitySelectedListener.selectedCity(
                          AppShared.settingResponse.settings.cities[index]);
                    },
                    title: Text(
                        AppShared.settingResponse.settings.cities[index].name),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
