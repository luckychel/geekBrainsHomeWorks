// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let vKNewsGet = try? JSONDecoder().decode(VKNewsGet.self, from: jsonData)

import Foundation
import RealmSwift

// MARK: - VKNewsGet
class VKNewsGet: Decodable {
    let response: VKNews
}

// MARK: - Response
class VKNews: Decodable {
    let items: [VKNewsItem]
}

// MARK: - Item
class VKNewsItem: Object, Decodable {
    @Persisted var id: Int = 0
    @Persisted var type: String = ""
    @Persisted var sourceID: Int = 0
    @Persisted var date: Int = 0
    @Persisted var comments: Comments? = Comments()
    @Persisted var likes: Likes? = Likes()
    @Persisted var text: String = ""
    //@Persisted var attachments: [ItemAttachment]?

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case sourceID = "source_id"
        case date
        case comments
        case likes
        case text
        case attachments
    }

    convenience required init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type =  try container.decode(String.self, forKey: .type)
        self.sourceID =  try container.decode(Int.self, forKey: .sourceID)
        self.date =  try container.decode(Int.self, forKey: .date)
        self.comments =  try container.decode(Comments.self, forKey: .comments)
        self.likes =  try container.decode(Likes.self, forKey: .likes)
        self.text =  try container.decode(String.self, forKey: .text)
        //self.attachments =  try container.decode(ItemAttachment.self, forKey: .attachments)
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

// MARK: - Comments
class Comments: Object, Decodable {
    
    @Persisted var canPost: Int?
    @Persisted var count: Int?
    @Persisted var groupsCanPost: Bool?

    enum CodingKeys: String, CodingKey {
        case canPost = "can_post"
        case count
        case groupsCanPost = "groups_can_post"
    }

    convenience required init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.canPost = try container.decodeIfPresent(Int.self, forKey: .canPost)
        self.count = try container.decodeIfPresent(Int.self, forKey: .count)
        self.groupsCanPost = try container.decodeIfPresent(Bool.self, forKey: .groupsCanPost)
    }
}

// MARK: - Likes
class Likes: Object, Decodable {
    
    @Persisted var canLike: Int?
    @Persisted var count: Int?
    @Persisted var userLikes: Int?
    @Persisted var canPublish: Int?
    @Persisted var repostDisabled: Bool?

    enum CodingKeys: String, CodingKey {
        case canLike = "can_like"
        case count
        case userLikes = "user_likes"
        case canPublish = "can_publish"
        case repostDisabled = "repost_disabled"
    }

    convenience required init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.canLike = try container.decodeIfPresent(Int.self, forKey: .canLike)
        self.count = try container.decodeIfPresent(Int.self, forKey: .count)
        self.userLikes = try container.decodeIfPresent(Int.self, forKey: .userLikes)
        self.canPublish = try container.decodeIfPresent(Int.self, forKey: .canPublish)
        self.repostDisabled = try container.decodeIfPresent(Bool.self, forKey: .repostDisabled)

    }

}

// MARK: - ItemAttachment
class ItemAttachment: Codable {
    var type: AttachmentType?
    var link: Link?
    var photo: Photo?
    var video: Video?

    init(type: AttachmentType?, link: Link?, photo: Photo?, video: Video?) {
        self.type = type
        self.link = link
        self.photo = photo
        self.video = video
    }
}

// MARK: - Link
class Link: Codable {
    var url: String?
    var caption, description: String?
    var photo: Photo?
    var title, ref: String?
    var isFavorite: Bool?
    var target: String?

    enum CodingKeys: String, CodingKey {
        case url, caption, description, photo, title, ref
        case isFavorite = "is_favorite"
        case target
    }

    init(url: String?, caption: String?, description: String?, photo: Photo?, title: String?, ref: String?, isFavorite: Bool?, target: String?) {
        self.url = url
        self.caption = caption
        self.description = description
        self.photo = photo
        self.title = title
        self.ref = ref
        self.isFavorite = isFavorite
        self.target = target
    }
}

// MARK: - Photo
class Photo: Codable {
    var albumID, date, id, ownerID: Int?
    var sizes: [Size]?
    var text: String?
    var userID: Int?
    var hasTags: Bool?
    var accessKey: String?
    var postID: Int?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case sizes, text
        case userID = "user_id"
        case hasTags = "has_tags"
        case accessKey = "access_key"
        case postID = "post_id"
    }

    init(albumID: Int?, date: Int?, id: Int?, ownerID: Int?, sizes: [Size]?, text: String?, userID: Int?, hasTags: Bool?, accessKey: String?, postID: Int?) {
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
    }
}

// MARK: - Size
class Size: Codable {
    var height: Int?
    var type: SizeType?
    var width: Int?
    var url: String?
    var withPadding: Int?

    enum CodingKeys: String, CodingKey {
        case height, type, width, url
        case withPadding = "with_padding"
    }

    init(height: Int?, type: SizeType?, width: Int?, url: String?, withPadding: Int?) {
        self.height = height
        self.type = type
        self.width = width
        self.url = url
        self.withPadding = withPadding
    }
}

enum SizeType: String, Codable {
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

enum AttachmentType: String, Codable {
    case link = "link"
    case photo = "photo"
    case video = "video"
}

// MARK: - Video
class Video: Codable {
    var accessKey: String?
    var canComment, canLike, canRepost, canSubscribe: Int?
    var canAddToFaves, canAdd, comments, date: Int?
    var description: String?
    var duration: Int?
    var image, firstFrame: [Size]?
    var width, height, id, ownerID: Int?
    var title: String?
    var isFavorite: Bool?
    var trackCode: String?
    var type: VideoType?
    var views, videoRepeat: Int?
    var ovID, liveStatus: String?

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
        case videoRepeat = "repeat"
        case ovID = "ov_id"
        case liveStatus = "live_status"
    }

    init(accessKey: String?, canComment: Int?, canLike: Int?, canRepost: Int?, canSubscribe: Int?, canAddToFaves: Int?, canAdd: Int?, comments: Int?, date: Int?, description: String?, duration: Int?, image: [Size]?, firstFrame: [Size]?, width: Int?, height: Int?, id: Int?, ownerID: Int?, title: String?, isFavorite: Bool?, trackCode: String?, type: VideoType?, views: Int?, videoRepeat: Int?, ovID: String?, liveStatus: String?) {
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
        self.videoRepeat = videoRepeat
        self.ovID = ovID
        self.liveStatus = liveStatus
    }
}

enum VideoType: String, Codable {
    case shortVideo = "short_video"
    case video = "video"
}



// MARK: - CopyHistory
class CopyHistory: Codable {
    var type: PostTypeEnum?
    var attachments: [CopyHistoryAttachment]?
    var date, fromID, id, ownerID: Int?
    var postSource: CopyHistoryPostSource?
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

    init(type: PostTypeEnum?, attachments: [CopyHistoryAttachment]?, date: Int?, fromID: Int?, id: Int?, ownerID: Int?, postSource: CopyHistoryPostSource?, postType: PostTypeEnum?, text: String?) {
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
    var type: AttachmentType?
    var photo: Photo?
    var video: Video?

    init(type: AttachmentType?, photo: Photo?, video: Video?) {
        self.type = type
        self.photo = photo
        self.video = video
    }
}

// MARK: - CopyHistoryPostSource
class CopyHistoryPostSource: Codable {
    var type: PostSourceType?

    init(type: PostSourceType?) {
        self.type = type
    }
}

enum PostSourceType: String, Codable {
    case api = "api"
    case vk = "vk"
}

enum PostTypeEnum: String, Codable {
    case post = "post"
}

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



// MARK: - ItemPostSource
class ItemPostSource: Codable {
    var type: PostSourceType?
    var platform: Platform?

    init(type: PostSourceType?, platform: Platform?) {
        self.type = type
        self.platform = platform
    }
}

enum Platform: String, Codable {
    case adminApp = "admin_app"
    case android = "android"
    case iphone = "iphone"
}

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

// MARK: - Views
class Views: Codable {
    var count: Int?

    init(count: Int?) {
        self.count = count
    }
}

// MARK: - Group
class VKNewsGroup: Codable {
    var id: Int?
    var name, screenName: String?
    var isClosed: Int?
    var type: GroupType?
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

    init(id: Int?, name: String?, screenName: String?, isClosed: Int?, type: GroupType?, isAdmin: Int?, isMember: Int?, isAdvertiser: Int?, photo50: String?, photo100: String?, photo200: String?) {
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

enum GroupType: String, Codable {
    case group = "group"
    case page = "page"
}


// MARK: - Profile
class Profile: Codable {
    var id, sex: Int?
    var screenName: String?
    var photo50, photo100: String?
    var onlineInfo: OnlineInfo?
    var online: Int?
    var firstName, lastName: String?
    var canAccessClosed, isClosed: Bool?

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
    }

    init(id: Int?, sex: Int?, screenName: String?, photo50: String?, photo100: String?, onlineInfo: OnlineInfo?, online: Int?, firstName: String?, lastName: String?, canAccessClosed: Bool?, isClosed: Bool?) {
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
    }
}

// MARK: - OnlineInfo
class OnlineInfo: Codable {
    var visible: Bool?
    var lastSeen: Int?
    var isOnline, isMobile: Bool?
    var appID: Int?

    enum CodingKeys: String, CodingKey {
        case visible
        case lastSeen = "last_seen"
        case isOnline = "is_online"
        case isMobile = "is_mobile"
        case appID = "app_id"
    }

    init(visible: Bool?, lastSeen: Int?, isOnline: Bool?, isMobile: Bool?, appID: Int?) {
        self.visible = visible
        self.lastSeen = lastSeen
        self.isOnline = isOnline
        self.isMobile = isMobile
        self.appID = appID
    }
}
