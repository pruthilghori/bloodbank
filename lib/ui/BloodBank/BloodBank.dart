import 'package:blood_Bank/ui/BloodBank/dataModel.dart';
import 'package:blood_Bank/ui/widgets/myText.dart';
import 'package:blood_Bank/utils/Screen.dart';
import 'package:flutter/material.dart';

class UiDemoBloodBank extends StatefulWidget {
  @override
  _UiDemoBloodBankState createState() => _UiDemoBloodBankState();
}

class _UiDemoBloodBankState extends State<UiDemoBloodBank> {
  String? selectedCity;
  List<String> city = [
    "Surat",
    "Baroda",
    "Ahmedabad",
    "Vapi",
    "Rajkot",
    "Bhavanagar",
  ];
  List<BloodBankData> Surat = [
    BloodBankData(
      surat1: 'LOK SAMARPAN BLOOD BANK',
      surat2: 'Ashwini Kumar ,Meera Nagar,Mini bazaar,varachha,Surat',
      surat3: '0261 2541414',
    ),
    BloodBankData(
      surat1: 'SAVIOR VOLUNTARY BLOOD BANK & RESERACH CENTER',
      surat2:
          'Shubh Square first floor,Gotala Vadi,patel vadi, Near lal darwaja,Surat',
      surat3: '07487995555',
    ),
    BloodBankData(
        surat1: 'SAMIMER HOSPITAL BLOOD BANK',
        surat2: 'Ummerwada,Surat',
        surat3: '0261 2368040'),
    BloodBankData(
        surat1: 'SARDAR VALLABHBHAI PATEL BLOOD BANK',
        surat2:
            'Shreenathji App,Rangavdhut soc-3,Ramnagar Rander Road,Rangavdhut soc-3,Rander,Surat',
        surat3: '9712675773'),
    BloodBankData(
        surat1: 'RED CROSS BLOOD BANK',
        surat2: '107,LP Savani Rd,Adajan,Surat',
        surat3: '08000368195'),
    BloodBankData(
        surat1: 'NEW CIVIL HOSPITAL BLOOD BANK',
        surat2: 'Majura Gate,Surat',
        surat3: '0261 2230909'),
    BloodBankData(
        surat1: 'SHREE MAHAVIR HEALTH AND MEDICAL RELIEF SOCIETY BLOOD BANK',
        surat2: 'Ring Rd,Maan Darwaja,Athawa gate,Surat',
        surat3: '0261 2462116'),
    BloodBankData(
        surat1: 'SURAT RAKTDAN KENDRA,GOPIPURA',
        surat2: '10 1586 b h,Gopipura Main Rd,Rudrapura,Surat',
        surat3: '0261 2597754'),
    BloodBankData(
        surat1: 'SURAT RAKTADAN KENDRA & RESEARCH CENTER',
        surat2:
            '1St Health Center,Udhana-Magadalla Rd,Laxmi Nagar,Khatodrawadi,Surat',
        surat3: '0261 2630114'),
    BloodBankData(
        surat1: 'SURAT CLINICAL LABORATORY ',
        surat2:
            'Shop No-7,Hanuman Char Rasta,Gopipura,Main Rd,Gopi Center,Gopipura,Surat',
        surat3: '0261 2591335'),
    BloodBankData(
        surat1: 'THYROCARE COLLECTION CENTER SURAT',
        surat2: '109,Sarthana Jakatnaka ,Vishal Nagar,Varachha,Surat',
        surat3: '08200919270'),
    BloodBankData(
        surat1: 'UNIQUE PATHOLOGY LABORATORY',
        surat2:
            'Laboratory,211,2nd Floor Gopal Complex ,B/H Puna Jakatnaka,Umarwada,Surat',
        surat3: '0261 2347404'),
    BloodBankData(
        surat1: 'SANKALP SPECIALITY LABORATORY',
        surat2:
            'B-685 Jalaram Nagar,Althan Rd,Near PIYUSH Point,Pandesara,Surat',
        surat3: '09998698119'),
  ];
  List<BloodBankData> Baroda = [
    BloodBankData(
      baroda1: 'S. S. G. Hospital Vadodara,Vadodara',
      baroda2:
          'Blood Bank, The Government Medical College and S.S.G. Hospital,VADODARA,Gujarat',
      baroda3: '0265 2424848,	9824275361',
    ),
    BloodBankData(
      baroda1: 'Jamnabai Blood Bank,Vadodara',
      baroda2: '	Blood Bank, Jamnabai General Hospital,VADODARA,Gujarat',
      baroda3: '0265 2517400,8238012038',
    ),
    BloodBankData(
      baroda1: 'Medical Care Centre Trust, Shri Jalaram Blood Bank,Vadodara',
      baroda2:
          ' Kashiben Gordhandas Patel Children Hospital, Jalaram Marg, Karelibaug,VADODARA,Gujarat',
      baroda3: '0265 2464130,9825335065',
    ),
    BloodBankData(
      baroda1: 'Suraktam Blood Bank Vadodara,Vadodara',
      baroda2:
          'G-7, Blue Chip Building, Near Stock Exchange, Sayajiganj,VADODARA,Gujarat',
      baroda3: '0265 2363660, 0265 2225903,09825044906, 09409279666',
    ),
    BloodBankData(
      baroda1: 'Kailash Cancer Hospital & Research Centre Blood Bank.,Vadodara',
      baroda2: 'Muni seva ashram, Goraj, Waghodiya,VADODARA,Gujarat',
      baroda3: '0265 3961300, 0265 3961357,9825132377',
    ),
    BloodBankData(
      baroda1: 'GMERS Medical College and General Hospital Blood Bank,Vadodara',
      baroda2:
          'Blood Bank, GMERS General Hospital and Medical College, Gotri,VADODARA,Gujarat',
      baroda3:
          '0265 2398008, 0265 6541395,09825436699, 09327212564, 08128395667',
    ),
    BloodBankData(
      baroda1: 'Indu Blood Bank Vadodara,Vadodara',
      baroda2:
          'Indu Blood Bank, III Floor, Vinraj Plaza, Opposite to Government Press, Khoti, VADODARA,Gujarat',
      baroda3: '0265 2437676, 0265 2411477,09825017334, 09925627186',
    ),
    BloodBankData(
      baroda1: ' Dhiraj General Blood Bank Vadodara,Vadodara',
      baroda2:
          'Dhiraj General Blood Bank, Mu. Post:-Waghodiya, Pipariya,VADODARA,Gujarat',
      baroda3:
          '02668 225264, 02668 245265, 02668 245266,09601151034, 09979304421',
    ),
    BloodBankData(
      baroda1: ' Bhailal Amin General Hospital Blood Bank,Vadodara',
      baroda2:
          'Blood Bank, Bhailal Amin General Hospital Blood Bank, Alembic Road,VADODARA,Gujarat',
      baroda3: '0265 2307038, 0265 2307039, 0265 2286666,9879977700',
    ),
  ];
  List<BloodBankData> Ahmedabad = [
    BloodBankData(
      ahmad1: 'V. S. Hospital Blood Bank,Ahmadabad',
      ahmad2:
          'C/o. Sheth, Vadilal Sarabhai (V.S.) Hospital, Ellisbridge, AHMEDABAD,Gujarat',
      ahmad3: '079 26577621 ,09925144720, 09925144720',
    ),
    BloodBankData(
      ahmad1: 'Smt. Shardaben Hospital Blood Bank,Ahmedabad',
      ahmad2:
          ' C/o. The Superintendent, Smt. Shardaben Chimanlal Municipal General Hospital, Saraspur,AHMEDABAD,Gujarat',
      ahmad3: '079 22164261, 079 22924264,9662359429',
    ),
    BloodBankData(
      ahmad1: ' L. G. Hospital Blood Bank,Ahmadabad',
      ahmad2:
          'Sheth L.G. General Hospital and Blood Bank, Maninagar,AHMEDABAD,Gujarat',
      ahmad3: '079 25461380 / 81 / 82 / 83 / 84,9825445414',
    ),
    BloodBankData(
      ahmad1: 'Civil Hospital Blood Bank,Ahmadabad',
      ahmad2:
          'Blood Bank, Department of IHBT, C/o.The Civil Hospital, Asarwa,AHMADABAD,Gujarat',
      ahmad3: '079 22683949/50/51/52/53/54/55, 07922683721-31 ,9426516595',
    ),
    BloodBankData(
      ahmad1: ' General Hospital Blood Bank Sola,Ahmedabad',
      ahmad2:
          'Blood Bank, Civil Hospital, Sarkhej Highway, Near Gujarat High Court, Sola ,AHMEDABAD,Gujarat',
      ahmad3: '079 27664349, 079 27432584, 079 27474359 ,9925594684',
    ),
    BloodBankData(
      ahmad1: 'Indian Red Cross Society Blood Bank,Ahmedabad',
      ahmad2:
          ' J. L. Thakore Red Cross Bhavan, 18-Gujarat Brahmkshatriya Society, Behind Suvidha Market, Paldi,AHMEDABAD,Gujarat',
      ahmad3: '079 26651833, 079 26650855,9824040597',
    ),
    BloodBankData(
      ahmad1: ' The Gujarat Cancer & Research Institute Blood Bank,Ahmedaba',
      ahmad2:
          ' M.P. Shah Cancer Hospital, Civil Hospital Campus, Asarwa,AHMEDABAD,Gujarat',
      ahmad3:
          '079 22681451, 079 22688061, 079 22688062, 079 2268 8000,9429617258',
    ),
    BloodBankData(
      ahmad1: 'Institute of Kidney Disease and Research Centre ,Ahmedabad',
      ahmad2: 'Blood Bank, Civil Hospital Compound, Asarwa ,AHMEDABAD,Gujarat',
      ahmad3:
          '079 22687164, 079 22687165, 079 22687000, 079 22685609,09427326164, 09662539914',
    ),
    BloodBankData(
      ahmad1: 'Help Voluntary Blood Bank ,Ahmedabad',
      ahmad2:
          '	 Kotyark Complex, Opposite to L.G. Hospital, Maninagar, AHMEDABAD,Gujarat',
      ahmad3: '079 65136744,098244 78775',
    ),
    BloodBankData(
      ahmad1: ' GUJARAT CANCER MEDICAL COLLEGE,Ahmedabad',
      ahmad2:
          ' Opp. D.R.M. office, Swadesi Mill compound, Near Chamunda Bridge,AHMEDABAD,Gujarat',
      ahmad3: '079 6648138,079 66048000,9824365588',
    ),
    BloodBankData(
      ahmad1: 'General Hospital Blood Bank ,Ahmedabad',
      ahmad2:
          'Model Hospital Blood Bank, (ESIS), Blood Bank, Bapunagar, AHMEDABAD,Gujarat',
      ahmad3: '079 22745770, 079 22743935',
    ),
    BloodBankData(
      ahmad1: 'Military Hospital Blood Bank,Ahmedabad',
      ahmad2:
          '	Military Hospital Blood Bank, 24, M. H. Complex ,AHMEDABAD,Gujarat',
      ahmad3: '7567980891',
    ),
    BloodBankData(
      ahmad1: 'Dr. Jivraj Mehta Smarak Health Foundation Blood Bank,Ahmedabad',
      ahmad2: '	Arogya Dham, Dr. Jivraj Mehta Marg,AHMEDABAD,Gujarat',
      ahmad3: '079 22687164, 079 22687143,09428600668, 09428600668',
    ),
    BloodBankData(
      ahmad1: 'Prathama Blood Centre,Ahmedabad',
      ahmad2:
          ' B/H Jivraj Mehta Hospital, Near Lavanya Society, Dr. C.V. Raman Marg, Vasna, AHMEDABAD,Gujarat',
      ahmad3: '079 26600101',
    ),
    BloodBankData(
      ahmad1: 'White Cross Blood Bank ,Ahmedabad',
      ahmad2:
          ' 2nd Floor, Kandhari Building, Opposite to S.T. Workshop, Naroda Road Patia, Naroda ,AHMEDABAD,Gujarat',
      ahmad3: '079 22815227,098254 53617',
    ),
    BloodBankData(
      ahmad1: ' Adarsh Pathology Laboratory and Blood Bank,Ahmedabad',
      ahmad2: '	1st Floor, Samjuba Hospital, Bapunagar ,AHMEDABAD,Gujarat',
      ahmad3: '079 22749146, 079 22746672,9825089741',
    ),
    BloodBankData(
      ahmad1: 'Gujarat Blood Bank Paldi,Ahmedabad',
      ahmad2:
          ' Pathology Laboratory, 101, Span Trade Centre, Opp. Kochrab Ashram, Near Paldi Char Rasta, Paldi, AHMEDABAD,Gujarat',
      ahmad3: '079 27413719,098245 22310',
    ),
    BloodBankData(
      ahmad1: 'Karnavati Blood Bank and Pathology Lab,Ahmedabad',
      ahmad2:
          'Karnavati Blood Bank and Pathology Lab, 36, Subhlaxmi Complex, Naranpura,AHMEDABAD,Gujarat',
      ahmad3: '079 27415150,9426088254',
    ),
    BloodBankData(
      ahmad1: 'Cross World Voluntary Blood Bank ,Ahmedabad',
      ahmad2:
          ' Chandraprabhu Complex, Sardar Patel Cross Road, AHMEDABAD,Gujarat',
      ahmad3: '079 26568004, 079 26401959,09327015909, 09376118500',
    ),
    BloodBankData(
      ahmad1: 'Maha Gujarat Blood Bank,Ahmedabad',
      ahmad2:
          '21, Parth Comp., Near Maninagar Fire Station, Maninagar, AHMEDABAD,Gujarat',
      ahmad3: '079 25451331, 079 25461641,09825306725, 09712906725',
    ),
    BloodBankData(
      ahmad1: ' Supratech Voluntary Blood Bank,Ahmedabad',
      ahmad2: ' 1st Floor, Near Drive-in Cinema, Thaltej ,AHMEDABAD,Gujarat',
      ahmad3: '079 40058958, 079 40054400, 079 40057317,9825023700',
    ),
    BloodBankData(
      ahmad1: 'Sterling Hospital,Ahmedabad',
      ahmad2:
          'Blood Bank, Sterling Hospitals, Drive in Road, Near Gurukul, Memnagar Road,AHMEDABAD,Gujarat',
      ahmad3: '7940011620,7940011918',
    ),
    BloodBankData(
      ahmad1: 'Ami Pathology Laboratory and Blood Bank,Ahmedabad',
      ahmad2:
          '14-15 Baronet Tower (Complex), Tollnaka, Highway , Ramnagar, Sabarmati,AHMEDABAD,Gujarat',
      ahmad3: '079 27501202,9825698298',
    ),
    BloodBankData(
      ahmad1: 'Gujarat Blood Bank Naranpura,Ahmedabad',
      ahmad2: ' 1-2, Subhlaxmi Complex, Naranpura,AHMEDABAD,Gujarat',
      ahmad3: '079 27413719,9978532743',
    ),
  ];
  List<BloodBankData> Vapi = [
    BloodBankData(
      vapi1: 'Nukem Blood Bank',
      vapi2: 'GIDC,Morarji circle,Vapi',
      vapi3: '260 2430206,2602400053,260 654258',
    ),
    BloodBankData(
      vapi1: 'Smt Puriben Popatbhai Lakha Blood Bank',
      vapi2: 'Near Lions Club Of Vapi Udyognagar Charitable Trust',
      vapi3: '+91 0260 2434600,+91 0260 2434601',
    ),
    BloodBankData(
      vapi1: 'Pardi Blood Bank',
      vapi2: 'Nh8, Swati Colony, Killa, Pardi, Valsad - 396125',
      vapi3: '+91 9173807473,+91 9173807123',
    ),
    BloodBankData(
      vapi1: 'Indian Red Cross Society',
      vapi2:
          '1st Floor, RNC Free Eye Hospital Compound, Kacheri Road, Tithal, Valsad - 396001, Behind Mamlatdar Office ',
      vapi3: '+91 02632 242944,+91 02632 253650',
    ),
    BloodBankData(
      vapi1: 'Sunsai Ambulance Service',
      vapi2:
          'Shop No 67 Roopam Complex, Valsad HO, Valsad - 396001, Behind City Police Line',
      vapi3: '+91 9879000447,+91 9825575594',
    ),
  ];
  List<BloodBankData> Rajkot = [
    BloodBankData(
      rajkot1: 'Astha Voluntary Blood Bank Gondal,Gondal',
      rajkot2:
          ' Jetpur Road, Opposite to Hava Mahel, Near G.F.D.C. Gate, Gondal,Rajkot,Gujarat',
      rajkot3: '02825 220828,9879531616',
    ),
    BloodBankData(
      rajkot1: 'P.D.U. Medical College Blood Bank,Rajkot',
      rajkot2:
          ' P.D.U. Medical College and General Hospital, R.Nc.102, Jamnagar Road ,RAJKOT,Gujarat',
      rajkot3:
          '0281 2450385, 0281 2458337, 0281 2458338, 0281 2458339,09825389050, 09825416609',
    ),
    BloodBankData(
      rajkot1: 'Rajkot Voluntary Blood Bank and Research center ,Rajkot',
      rajkot2:
          'Rajkot Voluntary Blood Bank and Research Centre, Pitroda House, Malaviya Road, RAJKOT,Gujarat',
      rajkot3: '0281 2234242,09898700101, 08460781366',
    ),
    BloodBankData(
      rajkot1: 'Red Cross Blood Bank Rajkot,Rajkot',
      rajkot2:
          'Red Cross Building, 1st Floor, Suchak Road, Near Kundaliya College, RAJKOT,Gujarat',
      rajkot3: '0281 2466260, 08866871717,9426953839',
    ),
    BloodBankData(
      rajkot1: 'Saurastra Voluntary Blood Bank Rajkot,Rajkot',
      rajkot2:
          ' Shashikunj commercial complex, 621, Mangal Park, Nirmalaconvent Road, Near Madhi Chowk,RAJKOT,Gujarat',
      rajkot3: '0281 2450301,9825082454',
    ),
    BloodBankData(
      rajkot1: 'General Hospital Blood Bank Morbi,Rajkot',
      rajkot2: 'Blood Bank, General Hospital, Morbi,RAJKOT,Gujarat',
      rajkot3: '02822 230538, 02822 230203,	9998476158',
    ),
    BloodBankData(
      rajkot1: 'Nationality Development Foundation Blood Bank Rajkot,Rajkot',
      rajkot2:
          'Blood Bank, Nationality Development Foundation, Smt. S.C.Patel , Medicare, 3rd Floor, Vidyanagar Main Road,RAJKOT,Gujarat',
      rajkot3: '0281 2480043, 0281 2481717,9825547459',
    ),
    BloodBankData(
      rajkot1: 'Nathani Voluntary Blood Bank, Rajkot ,Rajkot',
      rajkot2: ' 11, Tejash Building,20/22, New Janpath Plot ,RAJKOT,Gujarat',
      rajkot3: '0281 2480659, 0281 6522111,09227600111, 09825912518',
    ),
    BloodBankData(
      rajkot1: 'Shiv Voluntary Blood Bank Morbi,Rajkot',
      rajkot2:
          'Shiv Voluntary Blood Bank, 2nd Floor, Pawan Complex, Sanala Road, Near Sagar Hospital, Morbi,RAJKOT,Gujarat',
      rajkot3: '02822 292577,09998959859, 09925052852',
    ),
    BloodBankData(
      rajkot1: 'Jetpur Medical Foundation Trust Blood Bank Jetpur,Rajkot',
      rajkot2:
          'Blood Bank, Jetpur Medical Foundation Trust, 2nd Floor, opp. Union Bank of India, Kanakiya Plot, Jetpur,RAJKOT,Gujarat',
      rajkot3: '02827 226123,9426480401',
    ),
    BloodBankData(
      rajkot1: 'Jagruti Charitable Trust Blood Bank Dhoraji,Rajkot',
      rajkot2:
          'Jagruti Charitable Trust Blood Bank, Azad Chowk, Three Gate, Dhoraji ,RAJKOT,Gujarat',
      rajkot3: '02824 222485,9925873351',
    ),
  ];

  Widget bloodbank(final1, final2, final3) {
    return Container(
      height: 160,
      width: 200,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
          border: Border.all(color: Colors.black45, width: 2)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              final1,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                fontSize: 18,
              ),
            ),
            Text(
              final2,
              style: TextStyle(color: Color(0xff908c8c)),
            ),
            Text(
              final3,
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Screen.setScreen(context);
    return Scaffold(
        // backgroundColor: Color(0xffece2e2),
        backgroundColor: Colors.pink[400],
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.pink[400],
          title: Text('List of Blood Bank'),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              alignment: Alignment.topLeft,
              height: Screen.deviceHeight,
              width: Screen.deviceWidth,
              color: Colors.pink[400],
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: Screen.deviceHeight / 15.71,
                      width: Screen.deviceWidth / 1.2,
                      decoration: BoxDecoration(
                        color: Colors.pink[50],
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(25)),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Select City :",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.pink[300]),
                            ),
                            Card(
                              elevation: 1,
                              child: DropdownButton(
                                underline: Text(''),
                                elevation: 2,
                                value: selectedCity,
                                items: city.map((value) {
                                  return DropdownMenuItem(
                                    child: myText(string: '  $value'),
                                    value: value,
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedCity = value.toString();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: Screen.deviceHeight / 1.31,
              width: Screen.deviceWidth,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
                  // color: Color(0xffece2e2)
                  color: Colors.grey[300]),
              child: (selectedCity == 'Surat')
                  ? ListView.builder(
                      itemCount: Surat.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 20),
                          child: bloodbank(Surat[index].surat1,
                              Surat[index].surat2, Surat[index].surat3),
                        );
                      })
                  : (selectedCity == 'Baroda')
                      ? ListView.builder(
                          itemCount: Baroda.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 20),
                              child: bloodbank(Baroda[index].baroda1,
                                  Baroda[index].baroda2, Baroda[index].baroda3),
                            );
                          })
                      : (selectedCity == 'Vapi')
                          ? ListView.builder(
                              itemCount: Vapi.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 20),
                                  child: bloodbank(Vapi[index].vapi1,
                                      Vapi[index].vapi2, Vapi[index].vapi3),
                                );
                              })
                          : (selectedCity == 'Ahmedabad')
                              ? ListView.builder(
                                  itemCount: Ahmedabad.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 10, left: 20),
                                      child: bloodbank(
                                          Ahmedabad[index].ahmad1,
                                          Ahmedabad[index].ahmad2,
                                          Ahmedabad[index].ahmad3),
                                    );
                                  })
                              : (selectedCity == 'Rajkot')
                                  ? ListView.builder(
                                      itemCount: Rajkot.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 10, left: 20),
                                          child: bloodbank(
                                              Rajkot[index].rajkot1,
                                              Rajkot[index].rajkot2,
                                              Rajkot[index].rajkot3),
                                        );
                                      })
                                  : Center(
                                      child: Text(
                                        "Please Select City...",
                                        style: TextStyle(
                                            color: Colors.pink[300],
                                            fontSize: 30,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
            )
          ],
        ));
  }
}
