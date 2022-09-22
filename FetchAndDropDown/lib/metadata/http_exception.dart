class HttpException with Exception{
  String message;
  HttpException(this.message);
  @override
  String toString() {
    // TODO: implement toString
    return message;
  }
}