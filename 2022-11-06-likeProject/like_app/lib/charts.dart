import "package:cloud_firestore/cloud_firestore.dart";
import "package:d_chart/d_chart.dart";
import "package:flutter/material.dart";

class LiveChartPage extends StatelessWidget {
  LiveChartPage({Key? key}) : super(key: key);
  final streamChart = FirebaseFirestore.instance
      .collection('likeDislike')
      .snapshots(includeMetadataChanges: true);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        // StreamBuilder -> builds itself based on a snapshot from interacting with a Stream.
        stream: streamChart,
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if(snapshot.hasData) {
            List listChart = snapshot.data!.docs.map((e) {
              return {'domain': e.data()['name'], 'measure': e.data()['times']};
            }).toList();
            return AspectRatio(
              aspectRatio: 16 / 9,
              child: DChartBar(
                data: [
                  {
                    'id': 'Likes',
                    'data': listChart,
                  }
                ],
                axisLineColor: Colors.blue,
                barColor: (barData, index, id) => Colors.blue,
                showBarValue: true,
              ),
            );
          } else {
            return Text('No data available right now');
          }

        });
  }
}
