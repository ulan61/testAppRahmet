// swiftlint:disable all
// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// О транзакции
  internal static let aboutTransaction = L10n.tr("Localizable", "about_transaction")
  /// Допик
  internal static let converter = L10n.tr("Localizable", "converter")
  /// Ок
  internal static let okTitle = L10n.tr("Localizable", "ok_title")
  /// Цены
  internal static let prices = L10n.tr("Localizable", "prices")
  /// Транзакции
  internal static let transactions = L10n.tr("Localizable", "transactions")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
