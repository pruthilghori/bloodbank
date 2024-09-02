class SliderData {
  String assetImgPath;
  String title;
  String desc;

  SliderData(
      {required this.assetImgPath, required this.title, required this.desc});
}

List<SliderData> getSlider = [
  SliderData(
    assetImgPath: 'assets/images/onBording/vector1_4.png',
    title: 'Find Donors',
    desc: 'Find Donors easily  according to requirement ',
  ),
  SliderData(
    assetImgPath: 'assets/images/onBording/vector2_4.png',
    title: 'Get Blood Bank',
    desc: 'Get blood Bank List which is in area of Blood finder',
  ),
  SliderData(
      assetImgPath: 'assets/images/onBording/vector3_4.png',
      title: 'Mapping',
      desc: 'Donors available in Map'),
];
