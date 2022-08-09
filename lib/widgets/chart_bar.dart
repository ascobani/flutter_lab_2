import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentageOfTotal;

  const ChartBar(
    this.label,
    this.spendingAmount,
    this.spendingPercentageOfTotal, {super.key}
  );

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
    return Column(
      children: <Widget>[
        SizedBox(
          height: 23,
          child: FittedBox(
            child: Text('₺${spendingAmount.toStringAsFixed(0)}'),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        SizedBox(
          height: 60,
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
        const SizedBox(
          height: 4,
        ),
        Text(label),
      ],
    );
  }
}
