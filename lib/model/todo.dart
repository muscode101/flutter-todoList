class Todo {
  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;

  int get id => _id;

  String get date => _date;

  String get title => _title;

  int get priority => _priority;

  String get description => _description;

  set date(String value) {
    _date = value;
  }

  set priority(int value) {
    if (value > 0 && value <= 3) {
      _priority = value;
    }
  }

  set description(String value) {
    if (value.length <= 255) _description = value;
  }

  set title(String value) {
    if (value.length <= 255) _title = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['title'] = _title;
    map['priority'] = _priority;
    map['date'] = _date;
    map['description'] = _description;
    if (id != null) map['id'] = _title;
    return map;
  }

  Todo(this._title, this._description, this._date, this._priority);

  Todo.fromObject(dynamic o) {
    this._id = o['id'];
    this._title = o['title'];
    this._description = o['description'];
    this._priority = o['priority'];
    this._date = o['date'];
  }

  Todo.withId(
      this._id, this._title, this._description, this._date, this._priority);
}
