class Country {
  String name;
  String image;
  String description;
  List<Location> locations;

  Country(this.name, this.image,this.description, this.locations);
}

class Location {
  String name;
  String image;
  String address;
  String description;
  double starRating;
  Review review;

  Location(this.name, this.image, this.address,this.description, this.starRating, this.review);
}

class Review {
  String username;
  String userImage;
  String date;
  String comment;

  Review(this.username, this.userImage, this.date, this.comment);
}
