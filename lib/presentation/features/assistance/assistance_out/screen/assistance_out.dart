import 'package:BTechApp_Final_Project/core/utils/theme/app_decoration.dart';
import 'package:BTechApp_Final_Project/data/models/division_model.dart';
import 'package:BTechApp_Final_Project/data/models/estate_model.dart';
import 'package:BTechApp_Final_Project/data/models/kemandoran_model.dart';
import 'package:BTechApp_Final_Project/data/repositories/division_repository.dart';
import 'package:BTechApp_Final_Project/data/repositories/estate_repository.dart';
import 'package:BTechApp_Final_Project/data/repositories/kemandoran_repository.dart';
import 'package:BTechApp_Final_Project/presentation/widgets/custom_appbar.dart';
import 'package:BTechApp_Final_Project/presentation/widgets/custom_searchbar.dart';
import 'package:BTechApp_Final_Project/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class AssistanceOut extends StatefulWidget {
  const AssistanceOut({Key? key}) : super(key: key);

  @override
  State<AssistanceOut> createState() => _AssistanceOutState();
}

class _AssistanceOutState extends State<AssistanceOut> {
  final EstateRepository estateRepository = EstateRepository();
  final DivisionRepository divisionRepository = DivisionRepository();
  final KemandoranRepository kemandoranRepository = KemandoranRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Asistensi Keluar'),
      body: Padding(
          padding: BgaPaddingSize.getPaddingBody(),
        child: Column(
          children: <Widget>[
            FutureBuilder<List<Estate>>(
              future: estateRepository.getAllEstates(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final List<Estate> estates = snapshot.data!;
                  return BgaCustomTextFieldAndBottomSheet(

                    title: 'Tujuan Estate',
                    description: 'Pilih Tujuan Estate',
                    icon: Icons.arrow_forward,
                    itemList: estates.map((estate) => estate.id + '  ' + estate.estate).toList(),
                  );
                } else {
                  return Text('No Data', style: BgaTextStyle.titleBoldText,);
                }
              },
            ),

            FutureBuilder<List<Division>>(
              future: divisionRepository.getAllDivisions(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final List<Division> divisions = snapshot.data!;
                  return BgaCustomTextFieldAndBottomSheet(

                    title: 'Tujuan Divisi',
                    description: 'Pilih Tujuan Divisi',
                    icon: Icons.arrow_forward,
                    itemList: divisions.map((divisions) => divisions.id +'  ' + divisions.division).toList(),
                  );
                } else {
                  return Text('No Data', style: BgaTextStyle.titleBoldText,);
                }
              },
            ),

            FutureBuilder<List<Kemandoran>>(
              future: kemandoranRepository.getAllKemandorans(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final List<Kemandoran> kemandorans = snapshot.data!;
                  return BgaCustomTextFieldAndBottomSheet(

                    title: 'Tujuan Kemandoran',
                    description: 'Pilih Tujuan Kemandoran',
                    icon: Icons.arrow_forward,
                    itemList: kemandorans.map((kemandorans) => kemandorans.id + ' ' + kemandorans.kemandoran).toList(),
                  );
                } else {
                  return Text('No Data', style: BgaTextStyle.titleBoldText,);
                }
              },
            ),
          ],
        ),

      ),

    );
  }
}
