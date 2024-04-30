import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? dataMap =
        (data as Map<dynamic, dynamic>?)?.map((key, value) {
      return MapEntry(key.toString(), value);
    });
    if (dataMap?.isNotEmpty ?? false) {
      data;
    }

    // set background
    Color? bgColor =
        (data)['bgImage'] == 'day.png' ? Colors.blue : Colors.indigo[700];

    return Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
            child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/${(data)['bgImage']}'),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'bgImage': result['bgImage'],
                        'flag': result['flag']
                      };
                    });
                  },
                  style: const ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(Colors.black)),
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[300],
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(color: Colors.grey[300])
                        .copyWith(color: Colors.grey[300]),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      (data)['location'] ?? '-',
                      style: const TextStyle(
                          fontSize: 28, letterSpacing: 2, color: Colors.white),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  (data)['time'] ?? '-',
                  style: const TextStyle(fontSize: 66, color: Colors.white),
                )
              ],
            ),
          ),
        )));
  }
}
