

class Band{
  String? id;
  String? name;
  int? vote;

  Band({
    this.id,
    this.name,
    this.vote
  });

  factory Band.fromMap( Map<String,dynamic> obj ) 
  => Band(
    id: obj.containsKey('id')? obj['id']: 'no-id',
    name: obj.containsKey('name')? obj['name']: 'no-name',
    vote:obj.containsKey('vote') ? obj['vote']: 'no-vote'
  );
}