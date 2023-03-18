// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:


import Foundation
import Alamofire

// MARK: - VKNewsGet
class VKNewsGet: Codable {
    var response: VKNews?

    init(response: VKNews?) {
        self.response = response
    }
}

// MARK: - Response
class VKNews: Codable {
    var items: [VkNewsItem]?
    var profiles: [VkNewsProfile]?
    var groups: [VkNewsGroup]?
    var nextFrom: String?

    enum CodingKeys: String, CodingKey {
        case items, profiles, groups
        case nextFrom = "next_from"
    }

    init(items: [VkNewsItem]?, profiles: [VkNewsProfile]?, groups: [VkNewsGroup]?, nextFrom: String?) {
        self.items = items
        self.profiles = profiles
        self.groups = groups
        self.nextFrom = nextFrom
    }
}

// MARK: - Group
class VkNewsGroup: Codable {
    var id: Int?
    var name, screenName: String?
    var isClosed: Int?
    var type: VkNewsGroupType?
    var isAdmin, isMember, isAdvertiser: Int?
    var photo50, photo100, photo200: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case isAdmin = "is_admin"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }

    init(id: Int?, name: String?, screenName: String?, isClosed: Int?, type: VkNewsGroupType?, isAdmin: Int?, isMember: Int?, isAdvertiser: Int?, photo50: String?, photo100: String?, photo200: String?) {
        self.id = id
        self.name = name
        self.screenName = screenName
        self.isClosed = isClosed
        self.type = type
        self.isAdmin = isAdmin
        self.isMember = isMember
        self.isAdvertiser = isAdvertiser
        self.photo50 = photo50
        self.photo100 = photo100
        self.photo200 = photo200
    }
}

enum VkNewsGroupType: String, Codable {
    case group = "group"
    case page = "page"
}

// MARK: - Item
class VkNewsItem: Codable {
    var type: PostTypeEnum?
    var sourceID, date: Int?
    var shortTextRate: Double?
    var donut: Donut?
    var comments: Comments?
    var markedAsAds: Int?
    var canSetCategory, canDoubtCategory: Bool?
    var attachments: [ItemAttachment]?
    var id: Int?
    var isFavorite: Bool?
    var likes: Likes?
    var ownerID, postID: Int?
    var postSource: PostSource?
    var postType: PostTypeEnum?
    var reposts: Reposts?
    var text: String?
    var views: Views?
    var carouselOffset: Int?
    var copyHistory: [CopyHistory]?
    var zoomText: Bool?
    var topicID, signerID, edited: Int?

    
    enum CodingKeys: String, CodingKey {
        case type
        case sourceID = "source_id"
        case date
        case shortTextRate = "short_text_rate"
        case donut, comments
        case markedAsAds = "marked_as_ads"
        case canSetCategory = "can_set_category"
        case canDoubtCategory = "can_doubt_category"
        case attachments, id
        case isFavorite = "is_favorite"
        case likes
        case ownerID = "owner_id"
        case postID = "post_id"
        case postSource = "post_source"
        case postType = "post_type"
        case reposts, text, views
        case carouselOffset = "carousel_offset"
        case copyHistory = "copy_history"
        case zoomText = "zoom_text"
        case topicID = "topic_id"
        case signerID = "signer_id"
        case edited
    }

    init(type: PostTypeEnum?, sourceID: Int?, date: Int?, shortTextRate: Double?, donut: Donut?, comments: Comments?, markedAsAds: Int?, canSetCategory: Bool?, canDoubtCategory: Bool?, attachments: [ItemAttachment]?, id: Int?, isFavorite: Bool?, likes: Likes?, ownerID: Int?, postID: Int?, postSource: PostSource?, postType: PostTypeEnum?, reposts: Reposts?, text: String?, views: Views?, carouselOffset: Int?, copyHistory: [CopyHistory]?, zoomText: Bool?, topicID: Int?, signerID: Int?, edited: Int?) {
        self.type = type
        self.sourceID = sourceID
        self.date = date
        self.shortTextRate = shortTextRate
        self.donut = donut
        self.comments = comments
        self.markedAsAds = markedAsAds
        self.canSetCategory = canSetCategory
        self.canDoubtCategory = canDoubtCategory
        self.attachments = attachments
        self.id = id
        self.isFavorite = isFavorite
        self.likes = likes
        self.ownerID = ownerID
        self.postID = postID
        self.postSource = postSource
        self.postType = postType
        self.reposts = reposts
        self.text = text
        self.views = views
        self.carouselOffset = carouselOffset
        self.copyHistory = copyHistory
        self.zoomText = zoomText
        self.topicID = topicID
        self.signerID = signerID
        self.edited = edited
        
    }
}

// MARK: - ItemAttachment
class ItemAttachment: Codable {
    var type: AttachmentType?
    var photo: LinkPhoto?
    var video: AttachmentVideo?
    var doc: Doc?
    var link: Link?

    init(type: AttachmentType?, photo: LinkPhoto?, video: AttachmentVideo?, doc: Doc?, link: Link?) {
        self.type = type
        self.photo = photo
        self.video = video
        self.doc = doc
        self.link = link
    }
}

// MARK: - Doc
class Doc: Codable {
    var id, ownerID: Int?
    var title: String?
    var size: Int?
    var ext: String?
    var date, type: Int?
    var url: String?
    var preview: Preview?
    var isUnsafe: Int?
    var accessKey: String?

    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case title, size, ext, date, type, url, preview
        case isUnsafe = "is_unsafe"
        case accessKey = "access_key"
    }

    init(id: Int?, ownerID: Int?, title: String?, size: Int?, ext: String?, date: Int?, type: Int?, url: String?, preview: Preview?, isUnsafe: Int?, accessKey: String?) {
        self.id = id
        self.ownerID = ownerID
        self.title = title
        self.size = size
        self.ext = ext
        self.date = date
        self.type = type
        self.url = url
        self.preview = preview
        self.isUnsafe = isUnsafe
        self.accessKey = accessKey
    }
}

// MARK: - Preview
class Preview: Codable {
    var photo: PreviewPhoto?
    var video: VideoElement?

    init(photo: PreviewPhoto?, video: VideoElement?) {
        self.photo = photo
        self.video = video
    }
}

// MARK: - PreviewPhoto
class PreviewPhoto: Codable {
    var sizes: [VideoElement]?

    init(sizes: [VideoElement]?) {
        self.sizes = sizes
    }
}

// MARK: - VideoElement
class VideoElement: Codable {
    var src: String?
    var width, height: Int?
    var type: SizeType?
    var fileSize: Int?
    var url: String?
    var withPadding: Int?

    enum CodingKeys: String, CodingKey {
        case src, width, height, type
        case fileSize = "file_size"
        case url
        case withPadding = "with_padding"
    }

    init(src: String?, width: Int?, height: Int?, type: SizeType?, fileSize: Int?, url: String?, withPadding: Int?) {
        self.src = src
        self.width = width
        self.height = height
        self.type = type
        self.fileSize = fileSize
        self.url = url
        self.withPadding = withPadding
    }
}

enum SizeType: String, Codable {
    case l = "l"
    case m = "m"
    case o = "o"
    case p = "p"
    case q = "q"
    case r = "r"
    case s = "s"
    case w = "w"
    case x = "x"
    case y = "y"
    case z = "z"
}

// MARK: - Link
class Link: Codable {
    var url: String?
    var description: String?
    var isFavorite: Bool?
    var photo: LinkPhoto?
    var title, target, caption: String?

    enum CodingKeys: String, CodingKey {
        case url, description
        case isFavorite = "is_favorite"
        case photo, title, target, caption
    }

    init(url: String?, description: String?, isFavorite: Bool?, photo: LinkPhoto?, title: String?, target: String?, caption: String?) {
        self.url = url
        self.description = description
        self.isFavorite = isFavorite
        self.photo = photo
        self.title = title
        self.target = target
        self.caption = caption
    }
}

// MARK: - LinkPhoto
class LinkPhoto: Codable {
    var albumID, date, id, ownerID: Int?
    var sizes: [VideoElement]?
    var text: String?
    var userID: Int?
    var hasTags: Bool?
    var accessKey: String?
    var postID: Int?
    var squareCrop: String?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case sizes, text
        case userID = "user_id"
        case hasTags = "has_tags"
        case accessKey = "access_key"
        case postID = "post_id"
        case squareCrop = "square_crop"
    }

    init(albumID: Int?, date: Int?, id: Int?, ownerID: Int?, sizes: [VideoElement]?, text: String?, userID: Int?, hasTags: Bool?, accessKey: String?, postID: Int?, squareCrop: String?) {
        self.albumID = albumID
        self.date = date
        self.id = id
        self.ownerID = ownerID
        self.sizes = sizes
        self.text = text
        self.userID = userID
        self.hasTags = hasTags
        self.accessKey = accessKey
        self.postID = postID
        self.squareCrop = squareCrop
    }
}

enum AttachmentType: String, Codable {
    case doc = "doc"
    case link = "link"
    case photo = "photo"
    case video = "video"
}


// MARK: - AttachmentVideo
class AttachmentVideo: Codable {
    var accessKey: String?
    var canComment, canLike, canRepost, canSubscribe: Int?
    var canAddToFaves, canAdd, comments, date: Int?
    var description: String?
    var duration: Int?
    var image, firstFrame: [VideoElement]?
    var width, height, id, ownerID: Int?
    var title: String?
    var isFavorite: Bool?
    var trackCode: String?
    var type: PurpleType?
    var views, canDislike, videoRepeat: Int?

    enum CodingKeys: String, CodingKey {
        case accessKey = "access_key"
        case canComment = "can_comment"
        case canLike = "can_like"
        case canRepost = "can_repost"
        case canSubscribe = "can_subscribe"
        case canAddToFaves = "can_add_to_faves"
        case canAdd = "can_add"
        case comments, date, description, duration, image
        case firstFrame = "first_frame"
        case width, height, id
        case ownerID = "owner_id"
        case title
        case isFavorite = "is_favorite"
        case trackCode = "track_code"
        case type, views
        case canDislike = "can_dislike"
        case videoRepeat = "repeat"
    }

    init(accessKey: String?, canComment: Int?, canLike: Int?, canRepost: Int?, canSubscribe: Int?, canAddToFaves: Int?, canAdd: Int?, comments: Int?, date: Int?, description: String?, duration: Int?, image: [VideoElement]?, firstFrame: [VideoElement]?, width: Int?, height: Int?, id: Int?, ownerID: Int?, title: String?, isFavorite: Bool?, trackCode: String?, type: PurpleType?, views: Int?, canDislike: Int?, videoRepeat: Int?) {
        self.accessKey = accessKey
        self.canComment = canComment
        self.canLike = canLike
        self.canRepost = canRepost
        self.canSubscribe = canSubscribe
        self.canAddToFaves = canAddToFaves
        self.canAdd = canAdd
        self.comments = comments
        self.date = date
        self.description = description
        self.duration = duration
        self.image = image
        self.firstFrame = firstFrame
        self.width = width
        self.height = height
        self.id = id
        self.ownerID = ownerID
        self.title = title
        self.isFavorite = isFavorite
        self.trackCode = trackCode
        self.type = type
        self.views = views
        self.canDislike = canDislike
        self.videoRepeat = videoRepeat
    }
}

enum PurpleType: String, Codable {
    case shortVideo = "short_video"
    case video = "video"
}

// MARK: - Comments
class Comments: Codable {
    var canPost, count: Int?
    var groupsCanPost: Bool?

    enum CodingKeys: String, CodingKey {
        case canPost = "can_post"
        case count
        case groupsCanPost = "groups_can_post"
    }

    init(canPost: Int?, count: Int?, groupsCanPost: Bool?) {
        self.canPost = canPost
        self.count = count
        self.groupsCanPost = groupsCanPost
    }
}

// MARK: - CopyHistory
class CopyHistory: Codable {
    var type: PostTypeEnum?
    var attachments: [CopyHistoryAttachment]?
    var date, fromID, id, ownerID: Int?
    var postSource: PostSource?
    var postType: PostTypeEnum?
    var text: String?

    enum CodingKeys: String, CodingKey {
        case type, attachments, date
        case fromID = "from_id"
        case id
        case ownerID = "owner_id"
        case postSource = "post_source"
        case postType = "post_type"
        case text
    }

    init(type: PostTypeEnum?, attachments: [CopyHistoryAttachment]?, date: Int?, fromID: Int?, id: Int?, ownerID: Int?, postSource: PostSource?, postType: PostTypeEnum?, text: String?) {
        self.type = type
        self.attachments = attachments
        self.date = date
        self.fromID = fromID
        self.id = id
        self.ownerID = ownerID
        self.postSource = postSource
        self.postType = postType
        self.text = text
    }
}

// MARK: - CopyHistoryAttachment
class CopyHistoryAttachment: Codable {
    var type: String?
    var marketAlbum: MarketAlbum?
    var link: Link?
    var photo: LinkPhoto?
    var video: AttachmentVideo?

    enum CodingKeys: String, CodingKey {
        case type
        case marketAlbum = "market_album"
        case link, photo, video
    }

    init(type: String?, marketAlbum: MarketAlbum?, link: Link?, photo: LinkPhoto?, video: AttachmentVideo?) {
        self.type = type
        self.marketAlbum = marketAlbum
        self.link = link
        self.photo = photo
        self.video = video
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseMarketAlbum { response in
//     if let marketAlbum = response.result.value {
//       ...
//     }
//   }

// MARK: - MarketAlbum
class MarketAlbum: Codable {
    var id, ownerID: Int?
    var title: String?
    var count, updatedTime: Int?
    var isMain, isHidden: Bool?
    var photo: LinkPhoto?

    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case title, count
        case updatedTime = "updated_time"
        case isMain = "is_main"
        case isHidden = "is_hidden"
        case photo
    }

    init(id: Int?, ownerID: Int?, title: String?, count: Int?, updatedTime: Int?, isMain: Bool?, isHidden: Bool?, photo: LinkPhoto?) {
        self.id = id
        self.ownerID = ownerID
        self.title = title
        self.count = count
        self.updatedTime = updatedTime
        self.isMain = isMain
        self.isHidden = isHidden
        self.photo = photo
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responsePostSource { response in
//     if let postSource = response.result.value {
//       ...
//     }
//   }

// MARK: - PostSource
class PostSource: Codable {
    var type: PostSourceType?
    var platform: Platform?

    init(type: PostSourceType?, platform: Platform?) {
        self.type = type
        self.platform = platform
    }
}

enum Platform: String, Codable {
    case android = "android"
    case iphone = "iphone"
}

enum PostSourceType: String, Codable {
    case api = "api"
    case vk = "vk"
}

enum PostTypeEnum: String, Codable {
    case post = "post"
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseDonut { response in
//     if let donut = response.result.value {
//       ...
//     }
//   }

// MARK: - Donut
class Donut: Codable {
    var isDonut: Bool?

    enum CodingKeys: String, CodingKey {
        case isDonut = "is_donut"
    }

    init(isDonut: Bool?) {
        self.isDonut = isDonut
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseLikes { response in
//     if let likes = response.result.value {
//       ...
//     }
//   }

// MARK: - Likes
class Likes: Codable {
    var canLike, count, userLikes, canPublish: Int?
    var repostDisabled: Bool?

    enum CodingKeys: String, CodingKey {
        case canLike = "can_like"
        case count
        case userLikes = "user_likes"
        case canPublish = "can_publish"
        case repostDisabled = "repost_disabled"
    }

    init(canLike: Int?, count: Int?, userLikes: Int?, canPublish: Int?, repostDisabled: Bool?) {
        self.canLike = canLike
        self.count = count
        self.userLikes = userLikes
        self.canPublish = canPublish
        self.repostDisabled = repostDisabled
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseReposts { response in
//     if let reposts = response.result.value {
//       ...
//     }
//   }

// MARK: - Reposts
class Reposts: Codable {
    var count, userReposted: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }

    init(count: Int?, userReposted: Int?) {
        self.count = count
        self.userReposted = userReposted
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseViews { response in
//     if let views = response.result.value {
//       ...
//     }
//   }

// MARK: - Views
class Views: Codable {
    var count: Int?

    init(count: Int?) {
        self.count = count
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseProfile { response in
//     if let profile = response.result.value {
//       ...
//     }
//   }

// MARK: - Profile
class VkNewsProfile: Codable {
    var id, sex: Int?
    var screenName: String?
    var photo50, photo100: String?
    var onlineInfo: OnlineInfo?
    var online: Int?
    var firstName: String?
    var lastName: String?
    var canAccessClosed, isClosed: Bool?
    var deactivated: String?

    enum CodingKeys: String, CodingKey {
        case id, sex
        case screenName = "screen_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case onlineInfo = "online_info"
        case online
        case firstName = "first_name"
        case lastName = "last_name"
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
        case deactivated
    }

    init(id: Int?, sex: Int?, screenName: String?, photo50: String?, photo100: String?, onlineInfo: OnlineInfo?, online: Int?, firstName: String?, lastName: String?, canAccessClosed: Bool?, isClosed: Bool?, deactivated: String?) {
        self.id = id
        self.sex = sex
        self.screenName = screenName
        self.photo50 = photo50
        self.photo100 = photo100
        self.onlineInfo = onlineInfo
        self.online = online
        self.firstName = firstName
        self.lastName = lastName
        self.canAccessClosed = canAccessClosed
        self.isClosed = isClosed
        self.deactivated = deactivated
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseOnlineInfo { response in
//     if let onlineInfo = response.result.value {
//       ...
//     }
//   }

// MARK: - OnlineInfo
class OnlineInfo: Codable {
    var visible, isOnline, isMobile: Bool?
    var lastSeen, appID: Int?

    enum CodingKeys: String, CodingKey {
        case visible
        case isOnline = "is_online"
        case isMobile = "is_mobile"
        case lastSeen = "last_seen"
        case appID = "app_id"
    }

    init(visible: Bool?, isOnline: Bool?, isMobile: Bool?, lastSeen: Int?, appID: Int?) {
        self.visible = visible
        self.isOnline = isOnline
        self.isMobile = isMobile
        self.lastSeen = lastSeen
        self.appID = appID
    }
}

enum ScreenName: String, Codable {
    case id100 = "id100"
    case id16000336 = "id16000336"
    case id331543234 = "id331543234"
    case marinaBkt = "marina_bkt"
    case zolotinka777 = "zolotinka777"
}

