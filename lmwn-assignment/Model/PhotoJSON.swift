//
//  PhotoJSON.swift
//  lmwn-assignment
//
//  Created by ggolfz on 14/10/2564 BE.
//

import Foundation

struct PhotoJSON: Codable {
    let currentPage, totalPages, totalItems: Int
    let feature: Feature
    let filters: Filters
    let photos: [Photo]

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case totalPages = "total_pages"
        case totalItems = "total_items"
        case feature, filters, photos
    }
}

enum Feature: String, Codable {
    case popular = "popular"
}

// MARK: - Filters
struct Filters: Codable {
}

// MARK: - Photo
struct Photo: Codable {
    let id: Int
    let createdAt: String
    let privacy, profile: Bool
    let url: String
    let userID, status, width, height: Int
    let rating, highestRating: Double
    let highestRatingDate: String
    let imageFormat: ImageFormat
    let images: [Image]
    let imageURL: [String]
    let name: String
    let photoDescription: String
    let category: Int
    let takenAt: String?
    let shutterSpeed, focalLength, aperture, camera: String
    let lens, iso: String
    let location: String?
    let latitude, longitude: Double?
    let nsfw: Bool
    let privacyLevel: Int
    let watermark, hasNsfwTags: Bool
    let liked, voted: JSONNull?
    let commentsCount, votesCount, positiveVotesCount, timesViewed: Int
    let user: User
    let editorsChoice: Bool
    let editorsChoiceDate: String?
    let editoredBy: JSONNull?
    let feature: Feature
    let featureDate: String
    let fillSwitch: [String: Bool?]

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case privacy, profile, url
        case userID = "user_id"
        case status, width, height, rating
        case highestRating = "highest_rating"
        case highestRatingDate = "highest_rating_date"
        case imageFormat = "image_format"
        case images
        case imageURL = "image_url"
        case name
        case photoDescription = "description"
        case category
        case takenAt = "taken_at"
        case shutterSpeed = "shutter_speed"
        case focalLength = "focal_length"
        case aperture, camera, lens, iso, location, latitude, longitude, nsfw
        case privacyLevel = "privacy_level"
        case watermark
        case hasNsfwTags = "has_nsfw_tags"
        case liked, voted
        case commentsCount = "comments_count"
        case votesCount = "votes_count"
        case positiveVotesCount = "positive_votes_count"
        case timesViewed = "times_viewed"
        case user
        case editorsChoice = "editors_choice"
        case editorsChoiceDate = "editors_choice_date"
        case editoredBy = "editored_by"
        case feature
        case featureDate = "feature_date"
        case fillSwitch = "fill_switch"
    }
}

enum ImageFormat: String, Codable {
    case jpg = "jpg"
}

// MARK: - Image
struct Image: Codable {
    let format: Format
    let size: Int
    let url, httpsURL: String

    enum CodingKeys: String, CodingKey {
        case format, size, url
        case httpsURL = "https_url"
    }
}

enum Format: String, Codable {
    case jpeg = "jpeg"
}

// MARK: - User
struct User: Codable {
    let id: Int
    let username, fullname: String
    let avatarVersion: Int
    let registrationDate: String
    let avatars: Avatars
    let userpicURL, userpicHTTPSURL: String
    let usertype, active: Int
    let firstname: String
    let lastname: String?
    let about: String
    let city: String
    let state: String?
    let country: String
    let coverURL: String
    let upgradeStatus, affection, followersCount: Int
    let following: Bool

    enum CodingKeys: String, CodingKey {
        case id, username, fullname
        case avatarVersion = "avatar_version"
        case registrationDate = "registration_date"
        case avatars
        case userpicURL = "userpic_url"
        case userpicHTTPSURL = "userpic_https_url"
        case usertype, active, firstname, lastname, about, city, state, country
        case coverURL = "cover_url"
        case upgradeStatus = "upgrade_status"
        case affection
        case followersCount = "followers_count"
        case following
    }
}

// MARK: - Avatars
struct Avatars: Codable {
    let tiny, small, large, cover: Cover
    let avatarsDefault: Cover

    enum CodingKeys: String, CodingKey {
        case tiny, small, large, cover
        case avatarsDefault = "default"
    }
}

// MARK: - Cover
struct Cover: Codable {
    let https: String
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
