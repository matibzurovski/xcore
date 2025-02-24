// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Localized {
  /// Cancel
  internal static let cancel = Localized.tr("Localizable", "cancel")
  /// Contact Support
  internal static let contactSupport = Localized.tr("Localizable", "contact_support")
  /// Continue
  internal static let `continue` = Localized.tr("Localizable", "continue")
  /// Done
  internal static let done = Localized.tr("Localizable", "done")
  /// Enable
  internal static let enable = Localized.tr("Localizable", "enable")
  /// Get Started
  internal static let getStarted = Localized.tr("Localizable", "get_started")
  /// Help
  internal static let help = Localized.tr("Localizable", "help")
  /// Hide
  internal static let hide = Localized.tr("Localizable", "hide")
  /// Learn More
  internal static let learnMore = Localized.tr("Localizable", "learn_more")
  /// Next
  internal static let next = Localized.tr("Localizable", "next")
  /// No
  internal static let no = Localized.tr("Localizable", "no")
  /// OK
  internal static let ok = Localized.tr("Localizable", "ok")
  /// Open App Settings
  internal static let openAppSettings = Localized.tr("Localizable", "open_app_settings")
  /// Open Mail App
  internal static let openMailApp = Localized.tr("Localizable", "open_mail_app")
  /// Read More
  internal static let readMore = Localized.tr("Localizable", "read_more")
  /// Remove
  internal static let remove = Localized.tr("Localizable", "remove")
  /// Resend
  internal static let resend = Localized.tr("Localizable", "resend")
  /// Plural format key: "You can resend in %1$#@seconds@"
  internal static func resendAfter(_ p1: Int) -> String {
    return Localized.tr("Localizable", "resend_after", p1)
  }
  /// Retry
  internal static let retry = Localized.tr("Localizable", "retry")
  /// See All
  internal static let seeAll = Localized.tr("Localizable", "see_all")
  /// See More
  internal static let seeMore = Localized.tr("Localizable", "see_more")
  /// Share
  internal static let share = Localized.tr("Localizable", "share")
  /// Log In
  internal static let signin = Localized.tr("Localizable", "signin")
  /// Sign Up
  internal static let signup = Localized.tr("Localizable", "signup")
  /// Start
  internal static let start = Localized.tr("Localizable", "start")
  /// Submit
  internal static let submit = Localized.tr("Localizable", "submit")
  /// See All
  internal static let toggleSeeAll = Localized.tr("Localizable", "toggle_see_all")
  /// See Less
  internal static let toggleSeeLess = Localized.tr("Localizable", "toggle_see_less")
  /// See More
  internal static let toggleSeeMore = Localized.tr("Localizable", "toggle_see_more")
  /// Track
  internal static let track = Localized.tr("Localizable", "track")
  /// Unlink
  internal static let unlink = Localized.tr("Localizable", "unlink")
  /// Unlock
  internal static let unlock = Localized.tr("Localizable", "unlock")
  /// Yes
  internal static let yes = Localized.tr("Localizable", "yes")

  internal enum Error {
    /// From your device settings, enable camera access.
    internal static let cameraPermissionDeniedMessage = Localized.tr("Localizable", "error.camera_permission_denied_message")
    /// Camera Permission Denied
    internal static let cameraPermissionDeniedTitle = Localized.tr("Localizable", "error.camera_permission_denied_title")
    /// Seems there is an issue with your device camera.
    internal static let cameraUnavailableMessage = Localized.tr("Localizable", "error.camera_unavailable_message")
    /// Camera Unavailable
    internal static let cameraUnavailableTitle = Localized.tr("Localizable", "error.camera_unavailable_title")
    /// We’ll get this fixed as soon as we can. Please contact support for more information.
    internal static let databaseErrorMessage = Localized.tr("Localizable", "error.database_error_message")
    /// We can’t process this at the moment. Please try again later.
    internal static let generalErrorMessage = Localized.tr("Localizable", "error.general_error_message")
    /// Something Went Wrong
    internal static let generalErrorTitle = Localized.tr("Localizable", "error.general_error_title")
    /// Please complete all information before continuing.
    internal static let generalMissingFieldsMessage = Localized.tr("Localizable", "error.general_missing_fields_message")
    /// Missing Information
    internal static let generalMissingFieldsTitle = Localized.tr("Localizable", "error.general_missing_fields_title")
    /// Please check your internet connection and try again.
    internal static let noInternetMessage = Localized.tr("Localizable", "error.no_internet_message")
    /// No Internet Connection
    internal static let noInternetTitle = Localized.tr("Localizable", "error.no_internet_title")
    /// We can’t process this at the moment. Please try again later.
    internal static let routeUnavailableMessage = Localized.tr("Localizable", "error.route_unavailable_message")
    /// Your session has expired. Please log in again.
    internal static let sessionExpiredMessage = Localized.tr("Localizable", "error.session_expired_message")
    /// Session Expired
    internal static let sessionExpiredTitle = Localized.tr("Localizable", "error.session_expired_title")
  }

  internal enum MailApp {
    /// Choose Your Mail App
    internal static let `open` = Localized.tr("Localizable", "mail_app.open")
  }

  internal enum PostalAddress {
    /// Please make sure the address is valid and includes a street name and number.
    internal static let invalid = Localized.tr("Localizable", "postal_address.invalid")
    internal enum InvalidPoBox {
      /// Please enter an address that doesn’t correspond to a P.O. Box.
      internal static let message = Localized.tr("Localizable", "postal_address.invalid_po_box.message")
      /// Residential Address
      internal static let title = Localized.tr("Localizable", "postal_address.invalid_po_box.title")
    }
    internal enum InvalidRegion {
      /// %@ is currently available to only %@ residents. To continue, please enter your residential address in one of the supported regions.
      internal static func messageFew(_ p1: Any, _ p2: Any) -> String {
        return Localized.tr("Localizable", "postal_address.invalid_region.message_few", String(describing: p1), String(describing: p2))
      }
      /// %@ is currently not available in your region.
      internal static func messageMany(_ p1: Any) -> String {
        return Localized.tr("Localizable", "postal_address.invalid_region.message_many", String(describing: p1))
      }
      /// %@ is currently available to %@ residents. To continue, please enter your %@ residential address.
      internal static func messageOne(_ p1: Any, _ p2: Any, _ p3: Any) -> String {
        return Localized.tr("Localizable", "postal_address.invalid_region.message_one", String(describing: p1), String(describing: p2), String(describing: p3))
      }
      /// %@ Addresses
      internal static func titleOne(_ p1: Any) -> String {
        return Localized.tr("Localizable", "postal_address.invalid_region.title_one", String(describing: p1))
      }
      /// Unsupported Region
      internal static let titleOther = Localized.tr("Localizable", "postal_address.invalid_region.title_other")
    }
  }

  internal enum PushNotifications {
    internal enum OpenSystemSettings {
      /// Open Settings
      internal static let buttonOpenSettings = Localized.tr("Localizable", "push_notifications.open_system_settings.button_open_settings")
      /// In Settings, tap Notifications and switch on Allow Notifications.
      internal static let message = Localized.tr("Localizable", "push_notifications.open_system_settings.message")
      /// Open Settings
      internal static let title = Localized.tr("Localizable", "push_notifications.open_system_settings.title")
    }
  }

  internal enum Signout {
    /// Log Out
    internal static let title = Localized.tr("Localizable", "signout.title")
    internal enum ConfirmPopup {
      /// Are you sure you would like to log out?
      internal static let message = Localized.tr("Localizable", "signout.confirm_popup.message")
      /// Log Out
      internal static let title = Localized.tr("Localizable", "signout.confirm_popup.title")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Localized {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
