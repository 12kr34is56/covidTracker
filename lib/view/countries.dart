import 'package:covidtracker/Services/state_services.dart';
import 'package:covidtracker/view/detailScreen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class countries extends StatefulWidget {
  const countries({Key? key}) : super(key: key);

  @override
  State<countries> createState() => _countriesState();
}

class _countriesState extends State<countries> {
  TextEditingController searchController = TextEditingController();
  @override

  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              onChanged: (value){
              setState(() {

              });
              },
              decoration: InputDecoration(
                      hintText: 'Search by Country name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50))),
            ),
            Expanded(
                child: FutureBuilder(
              future: stateServices.getCountryApi(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Container(
                                    height: 10,
                                    width: 80,
                                    color: Colors.white,
                                  ),
                                  subtitle: Container(
                                    height: 10,
                                    width: 80,
                                    color: Colors.white,
                                  ),
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ));
                      });
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];
                        if (name.isEmpty) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>detailScreen
                                    (
                                  image: snapshot.data![index]['countryInfo']['flag'],
                                    name: snapshot.data![index]['country'],
                                    totalCase: snapshot.data![index]['todayCases'],
                                    totalDeath: snapshot.data![index]['todayDeaths'],
                                    todayRecovered: snapshot.data![index]['todayRecovered'],
                                    active: snapshot.data![index]['active'],
                                    critical: snapshot.data![index]['critical'],
                                    totalRecovered: snapshot.data![index]['recovered'],
                                    test: snapshot.data![index]['tests'],

                                  ),
                                  ));

                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(
                                      snapshot.data![index]['cases'].toString()),
                                  leading: Image(
                                      height: MediaQuery.of(context).size.height *
                                          0.05,
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                      fit: BoxFit.cover,
                                      image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag'])),
                                ),
                              ),
                            ],
                          );
                        } else if (name
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                          return Column(
                            children: [
                              InkWell(
                              onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>detailScreen(
                              image: snapshot.data![index]['countryInfo']['flag'],
                              name: snapshot.data![index]['country'],
                              totalCase: snapshot.data![index]['todayCases'],
                              totalDeath: snapshot.data![index]['todayDeaths'],
                              todayRecovered: snapshot.data![index]['todayRecovered'],
                              active: snapshot.data![index]['active'],
                              critical: snapshot.data![index]['critical'],
                              totalRecovered: snapshot.data![index]['recovered'],
                              test: snapshot.data![index]['tests'],
                            )));

                          },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(
                                      snapshot.data![index]['cases'].toString()),
                                  leading: Image(
                                      height: MediaQuery.of(context).size.height *
                                          0.05,
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                      fit: BoxFit.cover,
                                      image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag'])),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      });
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
