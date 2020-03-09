import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:merlinativ/gridPage.dart';
import 'package:merlinativ/servAgenda.dart';
import 'package:merlinativ/servAtividades.dart';
import 'package:merlinativ/tile.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'helperAgenda.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POCs Merlin',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(title: 'POCs Merlin'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      //body: _body(),
      //body: _bodyCalendar(),
      body: _bodyChart(),
    );
  }

  //Apresentar
  //https://help.syncfusion.com/flutter/calendar/month-view
  //https://alligator.io/flutter/bar-charts/
  
  _body() {

    final ats = ServAtividades().atividades;

    List<Widget> _items = List.generate(ats.length, (i) => TileAtiv(ats[i]));
    _items.insert(1, SizedBox(height: 50,));

    List<StaggeredTile> _tilesDyn = _items.map((i){
        var alt = 170.0;
        if (i is SizedBox) { alt = 50.0; }
        if (i is TileAtiv) { alt = i.altura; }

        return StaggeredTile.extent(1, alt);
    }).toList();

      
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: StaggeredGridViewPage.count(crossAxisCount: 2, tiles: _tilesDyn, items: _items,),
    );
    
  }
  
  _bodyCalendar(){

    final altura = MediaQuery.of(context).size.height * 0.55;

    List<Meeting> mettings =  ServAgenda().agenda.map((e){
      final cor = e.de.day == 1 ? Colors.red : Colors.green;
      return Meeting(e.descrAtividade, e.de, e.ate, cor, false,e.idAtividade);
    }).toList();


    return Column(
      children: <Widget>[
                  SizedBox(height: 10,),
                   Text('Seus Eventos'),
                  Expanded(
                      child: 
                                _calendarV1(mettings, altura),
                  )

      ],
    );
  }

  SfCalendar _calendarV1(List<Meeting> mettings, double altura) {
    return SfCalendar(
                                todayHighlightColor: Colors.grey,
                                viewHeaderStyle: ViewHeaderStyle(backgroundColor: Colors.brown, dayTextStyle: TextStyle(color: Colors.white), ),
                                headerStyle: CalendarHeaderStyle(backgroundColor: Colors.brown ,textStyle: TextStyle(color: Colors.white) ),
                                appointmentTextStyle: TextStyle(backgroundColor: Colors.brown),
                                view: CalendarView.month,
                                backgroundColor: Colors.white,
                                cellBorderColor: Colors.brown,
                                initialSelectedDate: DateTime.now(),
                                dataSource: MeetingDataSource(mettings),
                                
                                onTap: (d){
                                  if(d.targetElement == CalendarElement.agenda){
                                    //final idLocacao = d.appointments[0].idLocacao;
                                    //Navigator.of(context).pushNamed(LocacaoScreen.routeName, arguments: idLocacao);
                                  }
                                },

                                monthViewSettings: MonthViewSettings(appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,agendaViewHeight: altura,
                                                                      showAgenda: true, 
                                                                      numberOfWeeksInView: 1, 
                                                                      monthCellStyle: MonthCellStyle(textStyle: TextStyle(color: Colors.black)),
                                                                      agendaStyle: AgendaStyle(dayTextStyle: TextStyle(color: Colors.black), dateTextStyle: TextStyle(color: Colors.black))  
                                                                    ),
                              );
  }



  SfCalendar _calendarV2(List<Meeting> mettings, double altura) {
    return SfCalendar(
                                todayHighlightColor: Colors.grey,
                                viewHeaderStyle: ViewHeaderStyle(backgroundColor: Colors.brown, dayTextStyle: TextStyle(color: Colors.white), ),
                                headerStyle: CalendarHeaderStyle(backgroundColor: Colors.brown ,textStyle: TextStyle(color: Colors.white) ),
                                appointmentTextStyle: TextStyle( color: Colors.white),
                                timeSlotViewSettings: TimeSlotViewSettings(timeIntervalHeight: 60),
                                view: CalendarView.week,
                                backgroundColor: Colors.white,
                                cellBorderColor: Colors.brown,
                                initialSelectedDate: DateTime.now(),
                                dataSource: MeetingDataSource(mettings),

                                // monthViewSettings: MonthViewSettings(appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                                //                                       agendaViewHeight: altura,
                                //                                       //showAgenda: true, 
                                //                                       numberOfWeeksInView: 1, 
                                //                                       monthCellStyle: MonthCellStyle(textStyle: TextStyle(color: Colors.black)),
                                //                                       agendaStyle: AgendaStyle(dayTextStyle: TextStyle(color: Colors.black), dateTextStyle: TextStyle(color: Colors.black))  
                                //                                     ),
                              );
  }



  _bodyChart(){
    return charts.LineChart(_createSampleData(), animate: true);
    //return charts.BarChart(_createSampleData(), animate: true);
  }


  static List<charts.Series<LinearSales, int>> _createSampleData() {
      final data = [
        new LinearSales(1, 5),
        new LinearSales(3, 5),
        new LinearSales(5, 4),
        new LinearSales(7, 2),
        new LinearSales(9, 3),
        new LinearSales(11, 4),
        new LinearSales(13, 5),
        new LinearSales(15, 5),
        new LinearSales(17, 5),
        new LinearSales(19, 4),
        new LinearSales(21, 4),
        new LinearSales(23, 3),
        new LinearSales(25, 4),
        new LinearSales(27, 5),
        new LinearSales(29, 5),
        new LinearSales(31, 5),

      ];

      final dataAlegria = [
        new LinearSales(1, 1),
        new LinearSales(3, 1),
        new LinearSales(5, 2),
        new LinearSales(7, 2),
        new LinearSales(9, 1),
        new LinearSales(11, 2),
        new LinearSales(13, 2),
        new LinearSales(15, 3),
        new LinearSales(17, 3),
        new LinearSales(19, 4),
        new LinearSales(21, 4),
        new LinearSales(23, 3),
        new LinearSales(25, 4),
        new LinearSales(27, 4),
        new LinearSales(29, 3),
        new LinearSales(31, 2),

      ];

      return [
        new charts.Series<LinearSales, int>(
          id: 'Medo',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.sales,
          data: data,
        ),
        new charts.Series<LinearSales, int>(
          id: 'Alegria',
          colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.sales,
          data: dataAlegria,
        ),

      ];
    }



}


class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
