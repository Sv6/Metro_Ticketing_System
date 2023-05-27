import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:riyadh_metro/Wallet.dart';
import 'package:riyadh_metro/book.dart';
import 'package:riyadh_metro/settings.dart';
import 'crud.dart';
import 'mapPage.dart';

void main() async {
  runApp(ClientPage(
    clientName: "Abdulrahman Zyad",
    balance: 400000.00,
    availableTickets: ["d"],
    walletID: "",
    pass: 0,
    date: [],
    status: [],
    stations: [],
  ));
}

Future<Map<String, dynamic>> getTicket(String id, Crud CRUD) async {
  return await CRUD.getTicketInfo(id);
}

class ClientPage extends StatefulWidget {
  final String clientName;
  double balance;
  List<dynamic> availableTickets;
  List<dynamic> stations;
  List<dynamic> date;
  List<dynamic> status;
  final String walletID;
  double pass;

  ClientPage(
      {required this.clientName,
      required this.balance,
      required this.availableTickets,
      required this.walletID,
      required this.pass,
      required this.stations,
      required this.date,
      required this.status});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  void initState() {
    List tickIds;
    List stations;
    List date;
    List status;
    List<dynamic> availableTickets;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Crud CRUD = Crud();
    return MaterialApp(
      title: 'Home Page',
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          title: Text("Welcome, ${widget.clientName.toTitleCase()}!"),
          backgroundColor: Color.fromARGB(255, 6, 179, 107),
        ),
        body: FutureBuilder(builder: (context, snapshot) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: SafeArea(
                    //Card
                    child: Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      height: 200,
                      width: 340,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 6, 179, 107),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${widget.clientName.toTitleCase()}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SafeArea(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                child: Text(
                                  "${widget.walletID}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "SAR ${widget.balance}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Pass Counter: ${widget.pass.toInt()}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SafeArea(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: FloatingActionButton.small(
                                  backgroundColor: Colors.white,
                                  foregroundColor:
                                      Color.fromARGB(255, 6, 179, 107),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => (walletPage(
                                                  balance: widget.balance,
                                                  clientName: widget.clientName,
                                                  walletID: widget.walletID,
                                                  pass: widget.pass,
                                                ))));
                                  },
                                  child: Icon(Icons.add)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // --------------------Available tickets-----------------------
                // SizedBox(height: 20.0),
                Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color.fromARGB(255, 6, 179, 107),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      List tIds = [];
                      List stationList = [];
                      List statusList = [];
                      List dateList = [];
                      String id = await CRUD.getId();
                      Map<String, dynamic> userData =
                          await CRUD.getUserData(id);
                      tIds = userData["TICKETS"];
                      for (var item in widget.availableTickets) {
                        Map<String, dynamic> info =
                            await CRUD.getTicketInfo(item);
                        // print(info["Start_station"]);
                        stationList.add(info["Start_station"]);
                        statusList.add(info["Status"]);
                        dateList.add(info["Date"]);
                        // print(widget.availableTickets);
                      }
                      setState(() {
                        widget.availableTickets = tIds;
                        widget.stations = stationList;
                        widget.status = statusList;
                        widget.date = dateList;
                        // print(tickIds.length);
                      });
                    },
                    child: Text(
                      "Get Info",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                    height: 380,
                    width: 680,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 6, 179, 107),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                            child: Text(
                              "Available Tickets",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            itemCount: widget.stations
                                .length, // Replace 'tickets.length' with the actual number of tickets
                            itemBuilder: (context, index) {
                              print(widget.status);
                              return ListTile(
                                title: Text("${widget.stations[index]}"),
                                subtitle: Text(widget.date[index]),
                                trailing: Text(widget.status[index].toString()),
                                textColor: Colors.white,
                                onTap: () {
                                  
                                },
                              );
                            },
                            separatorBuilder: (context, index) => Divider(
                              color: Colors.white,
                              height: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        bottomNavigationBar: GNav(
          backgroundColor: Color.fromARGB(255, 6, 179, 107),
          rippleColor: Color.fromARGB(
              255, 6, 179, 107), // tab button ripple color when pressed
          haptic: true, // haptic feedback
          tabBorderRadius: 15,
          tabActiveBorder: Border.all(
              color: Color.fromARGB(255, 6, 179, 107),
              width: 1), // tab button border
          tabBorder: Border.all(
              color: Color.fromARGB(255, 6, 179, 107),
              width: 1), // tab button border
          tabShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 6, 179, 107).withOpacity(0.5),
                blurRadius: 8)
          ], // tab button shadow
          curve: Curves.easeOutExpo, // tab animation curves
          duration: Duration(milliseconds: 900), // tab animation duration
          gap: 8, // the tab button gap between icon and text
          color: Colors.grey[800], // unselected icon color
          activeColor: Colors.white, // selected icon and text color
          iconSize: 24, // tab button icon size
          tabBackgroundColor:
              Colors.white.withOpacity(0.1), // selected tab background color
          padding: EdgeInsets.symmetric(
              horizontal: 20, vertical: 20), // navigation bar padding
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
                icon: Icons.train,
                text: 'Book',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BookPage(
                        clientName: widget.clientName,
                        balance: widget.balance,
                        walletID: widget.walletID,
                        pass: widget.pass,
                        timeCongestion: [],
                        countCongestion: [],
                      ),
                    ),
                  );
                }),
            GButton(
                icon: Icons.map,
                text: 'Map',
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => (mapPage())));
                }),
            GButton(
              icon: Icons.settings,
              text: 'Settings',
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => (SettingsPage())));
              },
            )
          ],
        ),
      ),
    );
  }
}

//huihuinjhinibyhjvh