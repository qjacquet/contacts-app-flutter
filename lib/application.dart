String dbName = 'flutter_contacts.db';

List<String> migrations = [
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
  """
  alter table contacts add column birthDate TEXT default '';
  """,
  """CREATE TABLE settings (
    id INTEGER PRIMARY KEY,
    appAlreadySet INTEGER default 0,
    appPassword TEXT
  );""",
  """
  INSERT INTO settings (appAlreadySet, appPassword) VALUES (0, '');
  """
];

