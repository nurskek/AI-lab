import "package:cloud_firestore/cloud_firestore.dart";
import "package:d_chart/d_chart.dart";
import "package:flutter/material.dart";

class LiveChartPage extends StatelessWidget {
  LiveChartPage({Key? key}) : super(key: key);
  final streamChart = FirebaseFirestore.instance
      .collection('restaurants')
      .snapshots(includeMetadataChanges: true);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        child: ListView(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          children: [
            StreamBuilder(
                stream: streamChart,
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  List listChart = snapshot.data!.docs.map((e) {
                    return {
                      'domain': e.data()['name'],
                      'measure': e.data()['selectedTimes']
                    };
                  }).toList();
                  return AspectRatio(
                    aspectRatio: 16 / 9,
                    child: DChartBar(
                      data: [
                        {
                          'id': 'RestoStat',
                          'data': listChart,
                        }
                      ],
                      axisLineColor: Colors.green,
                      barColor: (barData, index, id) => Colors.green,
                      showBarValue: true,
                    ),
                  );
                })
          ],
        ));
  }
}
