import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../theme/colors.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f6fa),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Analysis",),
        backgroundColor: kTeal,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            _buildTitle("Donation Summary"),

            const SizedBox(height: 20),

            _buildDonutChart(),

            const SizedBox(height: 30),

            _buildStatsGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87),
      ),
    );
  }

  // ---------------------------
  // DONUT CHART
  // ---------------------------
  Widget _buildDonutChart() {
    return SizedBox(
      height: 260,
      child: PieChart(
        PieChartData(
          sectionsSpace: 3,
          centerSpaceRadius: 65,
          startDegreeOffset: -90,
          sections: [
            PieChartSectionData(
              color: kTeal,
              value: 40,
              title: "",
              radius: 40,
            ),
            PieChartSectionData(
              color: const Color(0xff3e4a89),
              value: 30,
              title: "",
              radius: 40,
            ),
            PieChartSectionData(
              color: const Color(0xff65d6ce),
              value: 18,
              title: "",
              radius: 40,
            ),
            PieChartSectionData(
              color: const Color(0xffa2b1ff),
              value: 12,
              title: "",
              radius: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid() {
    final stats = [
      {"title": "Users", "percent": "35.34%", "color": Color(0xff3e4a89)},
      {"title": "Donations", "percent": "24.12%", "color": kTeal},
      {"title": "Requests", "percent": "13.49%", "color": Color(0xff65d6ce)},
      {"title": "User Requests", "percent": "18.21%", "color": Color(0xffa2b1ff)},
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 2.2,
      children: stats.map((s) {
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                blurRadius: 8,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: (s["color"] as Color),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    s["title"] as String,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  Text(
                    s["percent"] as String,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
