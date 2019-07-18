class Contact {
  String fullName;
  String message;
  String documentID;

  Contact({this.fullName, this.message, this.documentID});
}

class ConvMembers {
  String send;
  String dest;
}

List<Contact> kContacts = new List();
ConvMembers convMembers = new ConvMembers();
String conversations_path;
String dest_path;
String authID;
