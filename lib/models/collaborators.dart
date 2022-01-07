class Collaborators {

  String id;
  List img = [];
  String name;
  String description;

  Collaborators({this.id, this.img, this.name, this.description});

  @override
  String toString() {
    return 'Team{id: $id, img: $img, name: $name, description: $description}';
  }
}