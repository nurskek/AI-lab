# Poll App

This project obtains the data from firestore, transfers it into the radio button list, then based on the clicks draws the bar chart.
Representation of bar chart is realtime.

## References
* https://api.flutter.dev/flutter/material/Radio-class.html -> radio button
* https://firebase.flutter.dev/docs/firestore/usage#realtime-changes -> manipulation
* https://www.youtube.com/watch?v=svChy9a1JCM -> livechart example
* https://pub.dev/packages/d_chart -> bar's package

## Learning:

The format of d_chart package for bars:
```
'domain': e.data()['name'],
'measure': e.data()['selectedTimes']
```
listChart is the list queried entries from Cloud Firestore. The return value and configurations inside:
```
return AspectRatio(
        aspectRatio: 16 / 9,
     child: DChartBar(
     data: [
        {
        'id': 'RestoStat',
        'data': listChart,
        }
    ],
    axisLineColor: Colors.blue,
    barColor: (barData, index, id) => Colors.blue,
    showBarValue: true,
    ),
);
```

## Compatibilty Test

| Android | iPhone (7) | Windows | macOS (12.6) | Linux | Chrome | Firefox | Safari | Edge | Mobile Chrome on Android)
| :---:   |:----------:| :---: |:------------:| :---: |:------:| :---: | :---: | :---: | :---: |
| - |     -      | O |      -       | - |   O   | O | O | - | - |
