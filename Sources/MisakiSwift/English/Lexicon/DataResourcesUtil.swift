import Foundation

final class DataResourcesUtil {
    private init() {}

    /// Locate a JSON resource shipped with the module. Tries the
    /// `Resources/` subdirectory first (original package layout) then
    /// falls back to bundle root, so consumers that flatten the bundle
    /// to satisfy iOS codesign still resolve correctly.
    private static func bundledJSONURL(named filename: String) -> URL? {
        if let url = Bundle.module.url(forResource: filename, withExtension: "json", subdirectory: "Resources") {
            return url
        }
        return Bundle.module.url(forResource: filename, withExtension: "json")
    }

    static func loadGold(british: Bool) -> [String: Any] {
        let filename = british ? "gb_gold" : "us_gold"

        guard let url = bundledJSONURL(named: filename),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return [:]
        }

        return json
    }

    static func loadSilver(british: Bool) -> [String: Any] {
        let filename = british ? "gb_silver" : "us_silver"

        guard let url = bundledJSONURL(named: filename),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return [:]
        }

        return json
    }
}
