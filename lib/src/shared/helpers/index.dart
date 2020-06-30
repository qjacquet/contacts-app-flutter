String getAgeFromDateTime(DateTime date) {
  return (DateTime.now().year - date.year).toString();
}