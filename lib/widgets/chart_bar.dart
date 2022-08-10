import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentageOfTotal;

  const ChartBar(
      this.label, this.spendingAmount, this.spendingPercentageOfTotal,
      {super.key});

  @override
  Widget build(BuildContext context) {
    getChartColor() {
      if (spendingAmount >= 4000) {
        return Colors.redAccent;
      } else if (spendingAmount >= 2000) {
        return Colors.redAccent;
      } else if (spendingAmount >= 1000) {
        return Colors.yellow;
      } else if (spendingAmount >= 500) {
        return Colors.greenAccent;
      } else {
        return Colors.green;
      }
    }

    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: constraints.maxHeight * 0.11,
              child: FittedBox(
                child: Text('₺${spendingAmount.toStringAsFixed(0)}'),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.02,
            ),
            SizedBox(
              height: constraints.maxHeight * 0.7,
              width: 10,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: const Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPercentageOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                          color: getChartColor(),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.02,
            ),
            SizedBox(
              height: constraints.maxHeight * 0.09,
              child: Text(label),
            ),
          ],
        );
      },
    );
  }
}
