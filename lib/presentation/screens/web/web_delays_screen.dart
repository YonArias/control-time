import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_control_app/presentation/providers/grafic_provider.dart';

class WebDelaysScreen extends StatefulWidget {
  const WebDelaysScreen({super.key});

  final Color barBackgroundColor = Colors.red;
  final Color barColor = Colors.red;

  @override
  State<WebDelaysScreen> createState() => _WebDelaysScreenState();
}

class _WebDelaysScreenState extends State<WebDelaysScreen> {

  int touchedIndex = -1;

  final colores = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.pink,
    Colors.amber,
    Colors.indigoAccent,
    Colors.purple,
    Colors.cyan,
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return StreamBuilder(
          stream: ref.watch(getDelayTimeProvider).getDelayTime(null),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No Users available.');
            } else {
              List<Map<String, dynamic>> getDelays = snapshot.data!;

              return Row(
                children: [
                  SizedBox(
                    width: 350,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20)),
                          height: 100,
                          child: const Center(
                              child: Text(
                            'Controladores',
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Card(
                            child: ListView.builder(
                              itemCount: getDelays.length,
                              itemBuilder: (context, index) => Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: ListTile(
                                      title: Text(getDelays[index]['name'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                      trailing: Text(
                                          '${getDelays[index]['duration'] ~/ 3600}:${(getDelays[index]['duration'] ~/ 60) % 60}:${getDelays[index]['duration'] % 60}',
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                        ), 
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Row(
                    children: [
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 50, 50, 10),
                            child: Center(
                                child: BarChart(
                              BarChartData(
                                barTouchData: BarTouchData(
                                  enabled: true,
                                ),
                                titlesData: FlTitlesData(
                                  show: true,
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget:
                                          (double value, TitleMeta meta) {
                                        const style = TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        );

                                        Widget text = Text(
                                          getDelays[value.toInt()]['name'],
                                          //operarios[value.toInt()],
                                          style: style,
                                        );

                                        return SideTitleWidget(
                                          axisSide: meta.axisSide,
                                          space: 16,
                                          child: text,
                                        );
                                      },
                                      reservedSize: 50,
                                    ),
                                  ),
                                  leftTitles: const AxisTitles(
                                    sideTitles: SideTitles(
                                      reservedSize: 50,
                                      showTitles: true,
                                    ),
                                  ),
                                  topTitles: const AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: false,
                                    ),
                                  ),
                                  rightTitles: const AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: false,
                                    ),
                                  ),
                                ),
                                borderData: FlBorderData(
                                  show: true,
                                ),
                                barGroups: List.generate(
                                  getDelays.length,
                                  //operarios.length, // Cantidad de operadores
                                  (i) => makeGroupData(
                                      i,
                                      getDelays[i.toInt()]['duration'] ??
                                          0.0 // times[i.toInt()], // Tiempo total de operadores
                                      ),
                                ),
                                gridData: const FlGridData(show: true),
                              ),
                            )),
                          ),
                        ),
                      ),
                      // GRAFICO PASTEL
                      Expanded(
                        child: Card(
                          child: Center(
                            child: PieChart(PieChartData(
                              borderData: FlBorderData(
                                show: true,
                              ),
                              sectionsSpace: 0,
                              centerSpaceRadius: 40,
                              sections: List.generate(
                                getDelays.length,
                                (index) => PieChartSectionData(
                                  color: colores[index],
                                  value: getDelays[index]['duration'],
                                  title: '${getDelays[index]['name']}',
                                ),
                              ),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ))
                ],
              );
            }
          },
        );
      },
    );
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: widget.barColor,
          borderRadius: BorderRadius.zero,
          borderDashArray: x >= 4 ? [4, 4] : null,
          width: 30,
          borderSide: BorderSide(color: widget.barColor, width: 2.0),
        ),
      ],
    );
  }
}