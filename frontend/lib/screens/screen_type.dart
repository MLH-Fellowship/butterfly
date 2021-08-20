/// Determines the following: 
/// - which screen to render 
/// - which icon to highlight in the bottom nav
/// - which query or mutation to make
/// 
/// **Order matters**. 
/// This is the order that the bottom nav bar will display them in
/// 
/// Used by pretty much every class
enum ScreenType{
  /// Nav bar items
  Browse,
  Create,
  Hosting,
  Attending,
  Logout,
  /// End of nav bar items. Can append additional pages below
  EventPage,
  Butterfly, 
  CreateAccount,
  CreateEventForm,
  EventRegister,
  EventConfirmation,
}