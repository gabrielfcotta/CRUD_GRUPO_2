import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/powers_provider.dart';

class HeroPowerCard extends StatelessWidget {
  const HeroPowerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var power = Provider.of<Power>(context);
    return Center(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Colors.black,
                style: BorderStyle.solid,
              ),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFF22052D), Color(0xFFCCB3D1)]),
              borderRadius: BorderRadius.circular(50),
              color: Colors.lightGreenAccent,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Text(
                  power.name,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
