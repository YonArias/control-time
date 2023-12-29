import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_control_app/presentation/providers/grafic_provider.dart';

class WebMainScreen extends StatefulWidget {
  const WebMainScreen({super.key});

  final Color barBackgroundColor = Colors.red;
  final Color barColor = Colors.red;

  @override
  State<WebMainScreen> createState() => _WebMainScreenState();
}

class _WebMainScreenState extends State<WebMainScreen> {
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return StreamBuilder(
          stream: ref.watch(getOperarioTimeProvider).getOperarioTime(null),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No Users available.');
            } else {
              List<Map<String, dynamic>> getOperarios = snapshot.data!;

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
                              itemCount: getOperarios.length,
                              itemBuilder: (context, index) => Card(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  child: ListTile(
                                    title: Text(getOperarios[index]['name']),
                                    trailing: Text('${getOperarios[index]['duration']~/ 3600}:${(getOperarios[index]['duration']~/ 60) % 60}:${getOperarios[index]['duration']%60}')
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
                            padding: const EdgeInsets.fromLTRB(10,50,50,10),
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
                                          getOperarios[value.toInt()]['name'],
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
                                  getOperarios.length,
                                  //operarios.length, // Cantidad de operadores
                                  (i) => makeGroupData(
                                      i,
                                      getOperarios[i
                                          .toInt()]['duration'] ?? 0.0// times[i.toInt()], // Tiempo total de operadores
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
                            child: PieChart(
                              PieChartData(
                                
                                borderData: FlBorderData(
                                  show: true,
                                ),
                                sectionsSpace: 0,
                                centerSpaceRadius: 40,
                                sections: List.generate(
                                  getOperarios.length, 
                                  (index) => PieChartSectionData(
                                    color: Colors.red[((index%10)+1)*100],
                                    value: getOperarios[index]['duration'],
                                    title: '${getOperarios[index]['name']}',
                                    
                                  ),
                                ),
                              )
                            ),
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