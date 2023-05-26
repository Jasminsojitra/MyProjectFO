class AppUrl {
  static const String baseUrl = "https://devapi.festumevento.com";
  static const String imageUrl = "https://festumeventos3.s3.ap-south-1.amazonaws.com/";

  static const String registerUrl = "$baseUrl/organizer/register";
  static const String loginUrl = "$baseUrl/organizer/login";
  static const String verifyMobileUrl = "$baseUrl/organizer/register/verifyotp";
  static const String forgotPasswordUrl = "$baseUrl/organizer/register/forgotpassword";
  static const String chnagePasswordUrl = "$baseUrl/organizer/register/changepassword";
  static const String eventCategoriesList = "$baseUrl/organizer/categories/list";
  static const String eventCreateList = "$baseUrl/organizer/events/save";
  static const String listAllEvent = "$baseUrl/organizer/events/list";
  static const String eventTimeEvent = "$baseUrl/organizer/events/about";
  static const String eventArrangementItemEvent = "$baseUrl/organizer/item/list";
  static const String getArrangementItemList = "$baseUrl/organizer/events/arrangement?eventid=";
  static const String eventArrangementEvent = "$baseUrl/organizer/events/arrangement";
  static const String postEventLocation = "$baseUrl/organizer/events/location";
  static const String getEventLocation = "$baseUrl/organizer/events/location?eventid=";
  static const String postBannerImage = "$baseUrl/organizer/events/banner";
  static const String postPermissionMedia = "$baseUrl/organizer/events/document";
  static const String postImage = "$baseUrl/organizer/events/image";
  static const String postVideo = "$baseUrl/organizer/events/video";
  static const String postMedia = "$baseUrl/organizer/events/media";
  static const String getMedia = "$baseUrl/organizer/events/media?eventid=";
  static const String getPermissionLatter = "$baseUrl/organizer/events/permission?eventid=";
  static const String postPermissionLatter = "$baseUrl/organizer/events/permission";
  //Get
  static const String getEventCreateList = "$baseUrl/organizer/events/";

  //Update
  static const String editEventCreate = "$baseUrl/organizer/events/save";
}
