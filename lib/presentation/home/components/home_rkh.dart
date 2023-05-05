
import 'package:BTechApp_Final_Project/core/utils/theme/app_decoration.dart';
import 'package:BTechApp_Final_Project/widgets/custom_card.dart';
import 'package:flutter/cupertino.dart';

class HomeRkh extends StatelessWidget {
  const HomeRkh({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: BgaPaddingSize.getPaddingGpsCard(),
      child: CustomCardRkh(
         title: 'Rencana Kerja Harian (RKH)',
         subtitle: ['PNN', 'TBM', 'TSM', 'OHA'],
         counter: [1,3,3,4],
         //icon: Icons.ac_unit,
       ),
    );
  }
}
