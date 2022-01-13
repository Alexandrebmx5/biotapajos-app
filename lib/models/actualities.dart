class Actualities {

  String id;
  List img = [];
  String title;
  String paragraphOne;
  String paragraphTwo;
  String paragraphThree;
  String paragraphFour;


  Actualities({this.id,
    this.img,
    this.title,
    this.paragraphOne,
    this.paragraphTwo,
    this.paragraphThree,
    this.paragraphFour});

  @override
  String toString() {
    return 'Actualities{id: $id, img: $img, title: $title, paragraphOne: $paragraphOne, paragraphTwo: $paragraphTwo, paragraphThree: $paragraphThree, paragraphFour: $paragraphFour}';
  }

}