class Report {

  String id;
  List img = [];
  String title;
  String paragraphOne;
  String paragraphTwo;
  String paragraphThree;
  String paragraphFour;


  Report({this.id,
    this.img,
    this.title,
    this.paragraphOne,
    this.paragraphTwo,
    this.paragraphThree,
    this.paragraphFour});

  @override
  String toString() {
    return 'Report{id: $id, img: $img, title: $title, paragraphOne: $paragraphOne, paragraphTwo: $paragraphTwo, paragraphThree: $paragraphThree, paragraphFour: $paragraphFour}';
  }

}