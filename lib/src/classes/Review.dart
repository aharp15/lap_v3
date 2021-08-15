class Review{
  String rid;
  String uid;
  String lawyerId;
  String content;
  String rating;

  Map<String, dynamic> toJSON ()=>{
    "rid": rid,
    "uid": uid,
    "lawyerId":  lawyerId,
    "content": content,
    "rating": rating

  };

  Review({this.rid, this.uid, this.lawyerId, this.content, this.rating});

  }