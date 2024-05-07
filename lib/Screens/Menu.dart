import 'dart:async';
import 'package:doge/utils/bg.dart';
import 'package:doge/utils/defaultWidgets.dart';
import 'package:doge/utils/particles.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:doge/utils/nav.dart';
import 'dart:ui' as ui;

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}


class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  void funcioncita() async{
    FirebaseFirestore.instance
        .collection('Dog-E_Database')
        .doc('control')
        .get()
        .then((value) {
      bool taComiendo = value.get('eating');
      if(taComiendo){
        var snack = SnackBar(content: Text("Su mascota está comiendo."), duration: Duration(seconds: 2), margin: EdgeInsets.all(10), backgroundColor: Colors.deepOrangeAccent, behavior: SnackBarBehavior.floating,);

        ScaffoldMessenger.of(context).showSnackBar(snack);
      } else{
        var snack = SnackBar(content: Text("Su mascota no se encuentra cerca del dispositivo"), duration: Duration(seconds: 2), margin: EdgeInsets.all(10), backgroundColor: Colors.deepOrangeAccent, behavior: SnackBarBehavior.floating,);

        ScaffoldMessenger.of(context).showSnackBar(snack);
      }

      print(taComiendo);

    });
  }
  Timer? timer;
  late AnimationController _controller;
  late PageController _monthController;
  late int _selectedMonth;
  final ZoomPanBehavior _zoomPanBehavior = ZoomPanBehavior(enablePinching: true, enablePanning: true, zoomMode: ZoomMode.x, maximumZoomLevel: .65);
  final TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true, canShowMarker: true, activationMode: ActivationMode.none, duration: 50000);

  List<_ChartData> chartData = <_ChartData>[];

  @override
  void initState() {
    super.initState();
    _monthController = PageController(initialPage: DateTime.now().month-1, viewportFraction: .3);
    _selectedMonth = DateTime.now().month-1;
    getDataFromFireStore().then((results) {
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });

  }


  //Obtenemos la información de la BD en FireStore
  Future<void> getDataFromFireStore() async {
    var snapShotsValue =
    await FirebaseFirestore.instance.collection("Dog-E_Database/data/feedings").where('month', isEqualTo: _selectedMonth+1).orderBy("day").get();
    List<_ChartData> list = snapShotsValue.docs
        .map((e) => _ChartData(x: e.data()['day'], y: e.data()['total']))
        .toList();
    setState(() {
      chartData = list;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override

  Widget build(BuildContext context) {
    getDataFromFireStore();

    return Scaffold(
      body: Stack(

        fit: StackFit.expand,
        children: [

          Column(

            children: <Widget>[

              _selector(),
            ],
          ),


          Padding(

            padding: const EdgeInsets.only(top: 30),
            child: Column(
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.only(top: 50, left: 30, right:30),
                child: SfCartesianChart(
                    tooltipBehavior: _tooltipBehavior,
                    zoomPanBehavior: _zoomPanBehavior,
                    primaryXAxis: NumericAxis(
                      interval: 1,
                      decimalPlaces: 0,
                      zoomFactor: .65,
                      enableAutoIntervalOnZooming: true,
                    ),
                    primaryYAxis: NumericAxis(
                      interval: 50,
                      labelFormat: '{value} g',
                    ),
                    series: <ChartSeries<_ChartData, int?>>[
                      SplineAreaSeries<_ChartData, int?>(
                          enableTooltip: true,

                          dataSource: chartData,
                          xValueMapper: (_ChartData data, _) => data.x,
                          yValueMapper: (_ChartData data, _) => data.y,
                          borderWidth: 4,
                          borderColor: Colors.white24,
                          emptyPointSettings: EmptyPointSettings(
                              mode: EmptyPointMode.average,
                              color: Colors.red,
                              borderColor: Colors.black,
                              borderWidth: 2
                          ),
                          markerSettings: const MarkerSettings(
                              isVisible: true,
                              borderColor: Color.fromRGBO(255, 140, 80, 1),
                          ),
                          onCreateShader: (ShaderDetails details) { return ui.Gradient.linear(details.rect.bottomCenter,
                                details.rect.topCenter, const <Color>[
                                  Color.fromRGBO(255, 180, 80, .2),
                                  Color.fromRGBO(255, 180, 80, .5),
                                ], <double>[
                                0.2,
                                0.6

                                ]);
                           },
                      ),


                    ]),
              )
            ],

        ),


          ),


          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, 300),
                    painter: BottomBGCustomPainter(),

                  ),const Particles(50)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:80),
            child: Row(
              children: [

                Padding(
                  padding: const EdgeInsets.only(top:50, left: 30, right: 20),
                  child: defImgButton(context, () { nav.goToFeeding(context); }, "assets/png/bowl.png", 150, 150),
                ),

                Padding(
                  padding: const EdgeInsets.only(top:50, left: 30, right: 20),
                  child: defImgButton(context, () {funcioncita();}, "assets/png/dogFaceTrans.png", 150, 150),
                )
              ],
            ),
          ),
      ],

      ),
      );

  }
  Widget _pageItem(String name, int pos){
    var _alignment;

    const selected = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.deepOrangeAccent
    );
    final unselected = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.normal,
      color: Colors.deepOrangeAccent.withOpacity(.4)
    );

    if (pos == _selectedMonth){
      _alignment = Alignment.center;
    } else if (pos > _selectedMonth){
      _alignment = Alignment.centerRight;
    } else{
      _alignment = Alignment.centerLeft;
    }
    return Align(
        alignment: _alignment,
        child: Text(name,
          style: pos == _selectedMonth ? selected : unselected,
        ),

    );
  }
  Widget _selector(){
    return SizedBox.fromSize(
      size: const Size.fromHeight(100),

      child: PageView(
        onPageChanged: (newPage){
          setState(() {
            _selectedMonth = newPage;
          });
        },
        controller: _monthController,
        children: <Widget>[
          _pageItem("Enero", 0),
          _pageItem("Febrero", 1),
          _pageItem("Marzo", 2),
          _pageItem("Abril", 3),
          _pageItem("Mayo", 4),
          _pageItem("Junio", 5),
          _pageItem("Julio", 6),
          _pageItem("Agosto", 7),
          _pageItem("Septiembre", 8),
          _pageItem("Octubre", 9),
          _pageItem("Noviembre", 10),
          _pageItem("Diciembre", 11),
        ],
      ),

    );
  }
  Future <bool> confirmExit () async{
    return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: const Text("Cerrar sesión"),
            content: const Text("¿Seguro que quieres cerrar sesión?"),
            actions: [
              ElevatedButton(onPressed: () {
                Navigator.of(context).pop(false);
              }, child: const Text("No")),
              ElevatedButton(onPressed: () {
                Navigator.of(context).pop(true);
              }, child: const Text("Yes"))
            ]
        )
    );
  }
}



class _ChartData {
  _ChartData({this.x, this.y});
  final int? x;
  final int? y;
}

