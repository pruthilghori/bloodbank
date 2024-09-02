import 'package:blood_Bank/utils/Screen.dart';
import 'package:flutter/material.dart';

class UiGuidelines extends StatefulWidget {
  @override
  _UiGuidelinesState createState() => _UiGuidelinesState();
}

class _UiGuidelinesState extends State<UiGuidelines>
    with TickerProviderStateMixin {
  TabController? tabController;

  Widget giveBlood(String text) => Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Icon(
              Icons.circle,
              size: 10,
              color: Colors.black54,
            ),
            Expanded(
              child: Text(
                text,
                overflow: TextOverflow.visible,
                style: TextStyle(color: Colors.black54),
                maxLines: 5,
              ),
            ),
          ],
        ),
      );

  Widget notGiveBlood(String text) => Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Icon(
              Icons.circle,
              size: 10,
              color: Colors.black54,
            ),
            Expanded(
              child: Text(
                text,
                overflow: TextOverflow.visible,
                style: TextStyle(color: Colors.black54),
                maxLines: 5,
              ),
            ),
          ],
        ),
      );

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Screen.setScreen(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Guidelines for Donation",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.pink[400],
              child: TabBar(
                  labelPadding: EdgeInsets.all(8.0),
                  controller: tabController,
                  indicatorColor: Colors.white,
                  indicatorWeight: 5,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  tabs: [
                    Tab(text: "Who Can Give Blood"),
                    Tab(
                      text: "Who Can't Give Blood",
                    )
                  ]),
            ),
            Expanded(
                child: TabBarView(
              controller: tabController,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "General Guidelines For Blood Donation",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        "Who can donate Blood",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.pink[400]),
                      ),
                    ),
                    Divider(
                      thickness: 3,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          height: 500,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Let others benefit from your good health.Do donate \nblood if...",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              giveBlood(
                                  " you are between age group of 18-60 years."),
                              giveBlood(" your weight is 45 kgs or more."),
                              giveBlood(
                                  " your haemoglobin is 12.5 gm% minimum."),
                              giveBlood(
                                  " your last blood donation was 3 months earlier."),
                              giveBlood(
                                  " you are healthy and have not suffered from malaria,typhoid or other transmissible disease in the recent past."),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    "There are many,many people who meet these parameters of health and fitness!"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "General Guidelines For Blood Donation",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        "Who can't donate Blood",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.pink[400]),
                      ),
                    ),
                    Divider(
                      thickness: 3,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          height: 700,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Do not donate blood if you have any of these conditions...",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              notGiveBlood(" cold/fever in the past 1 week."),
                              notGiveBlood(
                                  " under treatment with antibiotics or any other medication."),
                              notGiveBlood(
                                  " cardiac problems,hypertension,epilepsy, diabetes (on insulin therapy),history of cancer, chronic kidney or liver disease, bleeding tendencies, venereal  disease etc."),
                              notGiveBlood(
                                  " major surgery in the last 6 months."),
                              notGiveBlood(
                                  " vaccination in the last 24 hours."),
                              notGiveBlood(
                                  " had a miscarriage in the last 6 months or have been pregnant/lactating in the last one year."),
                              notGiveBlood(
                                  " had fainting attacks during last donation."),
                              notGiveBlood(
                                  " have regularly received treatment with blood products."),
                              notGiveBlood(
                                  " shared a needle to inject drugs/have history of drug addiction."),
                              notGiveBlood(
                                  " been tested positive for antibodies to HIV."),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
