class Team {

  String id;
  List img = [];
  String name;
  String description;

  Team({this.id, this.img, this.name, this.description});

  @override
  String toString() {
    return 'Team{id: $id, img: $img, name: $name, description: $description}';
  }
}