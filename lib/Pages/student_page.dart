import 'package:flutter/material.dart';
import 'package:fmms_mobile_app/Pages/AddRequest.dart';

class StudentPage extends StatefulWidget {
  final String id;

  StudentPage({Key? key, required this.id}) : super(key: key);

  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  String activeTab = 'maintenanceRequests'; // Default active tab

  void setActiveTab(String tab) {
    setState(() {
      activeTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text(
          'Student Dashboard',
          style: TextStyle(
            fontSize: 24,
            color: Color.fromARGB(255, 9, 3, 117),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Colors.blueGrey,
        elevation: 4.0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 30,
        ),
       ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                // Implement navigation logic
              },
            ),
            ListTile(
              title: Text('Calendar'),
              onTap: () {
                // Implement navigation logic
              },
            ),
            ListTile(
              title: Text('Contact'),
              onTap: () {
                // Implement navigation logic
              },
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildTab('Maintenance Requests', 'maintenanceRequests'),
                        buildTab('Ongoing Maintenance', 'ongoingMaintenance'),
                        buildTab('Notifications', 'notifications'),
                      ],
                    ),
                    SizedBox(height: 16),
                    IndexedStack(
                      index: activeTab == 'maintenanceRequests' ? 0 : activeTab == 'ongoingMaintenance' ? 1 : 2,
                      children: [
                        Container(
                          color: Color.fromARGB(255, 126, 126, 239),
                          child: Center(
                            child: Text('Maintenance Requests Content',style:TextStyle(color:Colors.black,fontSize: 17,fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Container(
                          color: Color.fromARGB(255, 126, 126, 239),
                          child: Center(
                            child: Text('Ongoing Maintenance Content',style:TextStyle(color:Colors.black,fontSize: 17,fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Container(
                          color: Color.fromARGB(255, 126, 126, 239),
                          child: Center(
                            child: Text('Notifications Content',style:TextStyle(color:Colors.black,fontSize: 17,fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: ElevatedButton(
                
                onPressed: () {
                  ScrollController _scrollController = ScrollController();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RequestPage(userId: widget.id,controller: _scrollController)),
                  );
                },
                child: Text('Add Request',style:TextStyle(color:Colors.black,fontSize: 15,fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Color.fromARGB(255, 241, 234, 212),
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Colors.black),
                                ),
                )
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTab(String title, String tab) {
    return InkWell(
      onTap: () => setActiveTab(tab),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        decoration: BoxDecoration(
          color: activeTab == tab ? const Color.fromARGB(255, 56, 62, 66) : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: activeTab == tab ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
