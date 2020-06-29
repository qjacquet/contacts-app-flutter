String dbName = 'flutter_contacts.db';
int dbVersion = 1;

List<String> dbCreate = [
  """CREATE TABLE contacts (
    id INTEGER PRIMARY KEY,
    firstName TEXT,
    lastName TEXT,
    gender TEXT,
    age TEXT,
    job TEXT,
    phoneNumber TEXT,
    email TEXT,
    comments TEXT,
    favorite INTEGER,
    photo TEXT,
    created TEXT
  )""",
];