class Ucs {

  String id;
  List img = [];
  String title;
  String paragraphOne;
  String paragraphTwo;
  String paragraphThree;
  String paragraphFour;


  Ucs({this.id,
    this.img,
    this.title,
    this.paragraphOne,
    this.paragraphTwo,
    this.paragraphThree,
    this.paragraphFour});

  @override
  String toString() {
    return 'Ucs{id: $id, img: $img, title: $title, paragraphOne: $paragraphOne, paragraphTwo: $paragraphTwo, paragraphThree: $paragraphThree, paragraphFour: $paragraphFour}';
  }
}