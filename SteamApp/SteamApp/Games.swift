//
//  Games.swift
//  MidtermApp
//
//  Created by JPL-ST-SPRING2021 on 5/3/22.
//

import Foundation

//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

// MARK: - Welcome
struct Welcome: Codable {
    let specials, comingSoon, topSellers, newReleases: ComingSoon
    let status: Int

    enum CodingKeys: String, CodingKey {
        case specials
        case comingSoon = "coming_soon"
        case topSellers = "top_sellers"
        case newReleases = "new_releases"
        case status
    }
}

// MARK: - ComingSoon
struct ComingSoon: Codable {
    let id, name: String
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let id, type: Int
    let name: String
    let discounted: Bool
    let discountPercent: Int
    let originalPrice: Int?
    let finalPrice: Int
    let currency: Currency
    let largeCapsuleImage, smallCapsuleImage: String
    let windowsAvailable, macAvailable, linuxAvailable, streamingvideoAvailable: Bool
    let headerImage: String
    let controllerSupport: ControllerSupport?
    let discountExpiration: Int?
    let headline: String?

    enum CodingKeys: String, CodingKey {
        case id, type, name, discounted
        case discountPercent = "discount_percent"
        case originalPrice = "original_price"
        case finalPrice = "final_price"
        case currency
        case largeCapsuleImage = "large_capsule_image"
        case smallCapsuleImage = "small_capsule_image"
        case windowsAvailable = "windows_available"
        case macAvailable = "mac_available"
        case linuxAvailable = "linux_available"
        case streamingvideoAvailable = "streamingvideo_available"
        case headerImage = "header_image"
        case controllerSupport = "controller_support"
        case discountExpiration = "discount_expiration"
        case headline
    }
}

enum ControllerSupport: String, Codable {
    case full = "full"
}

enum Currency: String, Codable {
    case usd = "USD"
}
