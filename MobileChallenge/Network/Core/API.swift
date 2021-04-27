// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class ArtistsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Artists($search: String!, $first: Int!, $after: String) {
      search {
        __typename
        artists(query: $search, first: $first, after: $after) {
          __typename
          nodes {
            __typename
            ...ArtistBasicFragment
          }
        }
      }
    }
    """

  public let operationName: String = "Artists"

  public var queryDocument: String { return operationDefinition.appending("\n" + ArtistBasicFragment.fragmentDefinition) }

  public var search: String
  public var first: Int
  public var after: String?

  public init(search: String, first: Int, after: String? = nil) {
    self.search = search
    self.first = first
    self.after = after
  }

  public var variables: GraphQLMap? {
    return ["search": search, "first": first, "after": after]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("search", type: .object(Search.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(search: Search? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "search": search.flatMap { (value: Search) -> ResultMap in value.resultMap }])
    }

    /// Search for MusicBrainz entities using Lucene query syntax.
    public var search: Search? {
      get {
        return (resultMap["search"] as? ResultMap).flatMap { Search(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "search")
      }
    }

    public struct Search: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["SearchQuery"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("artists", arguments: ["query": GraphQLVariable("search"), "first": GraphQLVariable("first"), "after": GraphQLVariable("after")], type: .object(Artist.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(artists: Artist? = nil) {
        self.init(unsafeResultMap: ["__typename": "SearchQuery", "artists": artists.flatMap { (value: Artist) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Search for artist entities matching the given query.
      public var artists: Artist? {
        get {
          return (resultMap["artists"] as? ResultMap).flatMap { Artist(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "artists")
        }
      }

      public struct Artist: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["ArtistConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("nodes", type: .list(.object(Node.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(nodes: [Node?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "ArtistConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of nodes in the connection (without going through the
        /// `edges` field).
        public var nodes: [Node?]? {
          get {
            return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Artist"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("name", type: .scalar(String.self)),
              GraphQLField("disambiguation", type: .scalar(String.self)),
              GraphQLField("mediaWikiImages", type: .nonNull(.list(.object(MediaWikiImage.selections)))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, name: String? = nil, disambiguation: String? = nil, mediaWikiImages: [MediaWikiImage?]) {
            self.init(unsafeResultMap: ["__typename": "Artist", "id": id, "name": name, "disambiguation": disambiguation, "mediaWikiImages": mediaWikiImages.map { (value: MediaWikiImage?) -> ResultMap? in value.flatMap { (value: MediaWikiImage) -> ResultMap in value.resultMap } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The ID of an object
          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          /// The official name of the entity.
          public var name: String? {
            get {
              return resultMap["name"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          /// A comment used to help distinguish identically named entitites.
          public var disambiguation: String? {
            get {
              return resultMap["disambiguation"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "disambiguation")
            }
          }

          /// Artist images found at MediaWiki URLs in the artist’s URL relationships.
          /// Defaults to URL relationships with the type “image”.
          /// This field is provided by the MediaWiki extension.
          public var mediaWikiImages: [MediaWikiImage?] {
            get {
              return (resultMap["mediaWikiImages"] as! [ResultMap?]).map { (value: ResultMap?) -> MediaWikiImage? in value.flatMap { (value: ResultMap) -> MediaWikiImage in MediaWikiImage(unsafeResultMap: value) } }
            }
            set {
              resultMap.updateValue(newValue.map { (value: MediaWikiImage?) -> ResultMap? in value.flatMap { (value: MediaWikiImage) -> ResultMap in value.resultMap } }, forKey: "mediaWikiImages")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var artistBasicFragment: ArtistBasicFragment {
              get {
                return ArtistBasicFragment(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }

          public struct MediaWikiImage: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["MediaWikiImage"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("descriptionURL", type: .scalar(String.self)),
                GraphQLField("user", type: .scalar(String.self)),
                GraphQLField("size", type: .scalar(Int.self)),
                GraphQLField("width", type: .scalar(Int.self)),
                GraphQLField("height", type: .scalar(Int.self)),
                GraphQLField("canonicalTitle", type: .scalar(String.self)),
                GraphQLField("objectName", type: .scalar(String.self)),
                GraphQLField("descriptionHTML", type: .scalar(String.self)),
                GraphQLField("originalDateTimeHTML", type: .scalar(String.self)),
                GraphQLField("artistHTML", type: .scalar(String.self)),
                GraphQLField("creditHTML", type: .scalar(String.self)),
                GraphQLField("licenseShortName", type: .scalar(String.self)),
                GraphQLField("licenseURL", type: .scalar(String.self)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(descriptionUrl: String? = nil, user: String? = nil, size: Int? = nil, width: Int? = nil, height: Int? = nil, canonicalTitle: String? = nil, objectName: String? = nil, descriptionHtml: String? = nil, originalDateTimeHtml: String? = nil, artistHtml: String? = nil, creditHtml: String? = nil, licenseShortName: String? = nil, licenseUrl: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "MediaWikiImage", "descriptionURL": descriptionUrl, "user": user, "size": size, "width": width, "height": height, "canonicalTitle": canonicalTitle, "objectName": objectName, "descriptionHTML": descriptionHtml, "originalDateTimeHTML": originalDateTimeHtml, "artistHTML": artistHtml, "creditHTML": creditHtml, "licenseShortName": licenseShortName, "licenseURL": licenseUrl])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The URL of the wiki page describing the image.
            public var descriptionUrl: String? {
              get {
                return resultMap["descriptionURL"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "descriptionURL")
              }
            }

            /// The user who uploaded the file.
            public var user: String? {
              get {
                return resultMap["user"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "user")
              }
            }

            /// The size of the file in bytes.
            public var size: Int? {
              get {
                return resultMap["size"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "size")
              }
            }

            /// The pixel width of the image.
            public var width: Int? {
              get {
                return resultMap["width"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "width")
              }
            }

            /// The pixel height of the image.
            public var height: Int? {
              get {
                return resultMap["height"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "height")
              }
            }

            /// The canonical title of the file.
            public var canonicalTitle: String? {
              get {
                return resultMap["canonicalTitle"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "canonicalTitle")
              }
            }

            /// The image title, brief description, or file name.
            public var objectName: String? {
              get {
                return resultMap["objectName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "objectName")
              }
            }

            /// A description of the image, potentially containing HTML.
            public var descriptionHtml: String? {
              get {
                return resultMap["descriptionHTML"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "descriptionHTML")
              }
            }

            /// The original date of creation of the image. May be a description rather than
            /// a parseable timestamp, and may contain HTML.
            public var originalDateTimeHtml: String? {
              get {
                return resultMap["originalDateTimeHTML"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "originalDateTimeHTML")
              }
            }

            /// The name of the image author, potentially containing HTML.
            public var artistHtml: String? {
              get {
                return resultMap["artistHTML"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "artistHTML")
              }
            }

            /// The source of the image, potentially containing HTML.
            public var creditHtml: String? {
              get {
                return resultMap["creditHTML"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "creditHTML")
              }
            }

            /// A short human-readable license name.
            public var licenseShortName: String? {
              get {
                return resultMap["licenseShortName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "licenseShortName")
              }
            }

            /// A web address where the license is described.
            public var licenseUrl: String? {
              get {
                return resultMap["licenseURL"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "licenseURL")
              }
            }
          }
        }
      }
    }
  }
}

public struct ArtistBasicFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment ArtistBasicFragment on Artist {
      __typename
      id
      name
      disambiguation
      mediaWikiImages {
        __typename
        descriptionURL
        user
        size
        width
        height
        canonicalTitle
        objectName
        descriptionHTML
        originalDateTimeHTML
        artistHTML
        creditHTML
        licenseShortName
        licenseURL
      }
    }
    """

  public static let possibleTypes: [String] = ["Artist"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("name", type: .scalar(String.self)),
      GraphQLField("disambiguation", type: .scalar(String.self)),
      GraphQLField("mediaWikiImages", type: .nonNull(.list(.object(MediaWikiImage.selections)))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, name: String? = nil, disambiguation: String? = nil, mediaWikiImages: [MediaWikiImage?]) {
    self.init(unsafeResultMap: ["__typename": "Artist", "id": id, "name": name, "disambiguation": disambiguation, "mediaWikiImages": mediaWikiImages.map { (value: MediaWikiImage?) -> ResultMap? in value.flatMap { (value: MediaWikiImage) -> ResultMap in value.resultMap } }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// The ID of an object
  public var id: GraphQLID {
    get {
      return resultMap["id"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  /// The official name of the entity.
  public var name: String? {
    get {
      return resultMap["name"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  /// A comment used to help distinguish identically named entitites.
  public var disambiguation: String? {
    get {
      return resultMap["disambiguation"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "disambiguation")
    }
  }

  /// Artist images found at MediaWiki URLs in the artist’s URL relationships.
  /// Defaults to URL relationships with the type “image”.
  /// This field is provided by the MediaWiki extension.
  public var mediaWikiImages: [MediaWikiImage?] {
    get {
      return (resultMap["mediaWikiImages"] as! [ResultMap?]).map { (value: ResultMap?) -> MediaWikiImage? in value.flatMap { (value: ResultMap) -> MediaWikiImage in MediaWikiImage(unsafeResultMap: value) } }
    }
    set {
      resultMap.updateValue(newValue.map { (value: MediaWikiImage?) -> ResultMap? in value.flatMap { (value: MediaWikiImage) -> ResultMap in value.resultMap } }, forKey: "mediaWikiImages")
    }
  }

  public struct MediaWikiImage: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["MediaWikiImage"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("descriptionURL", type: .scalar(String.self)),
        GraphQLField("user", type: .scalar(String.self)),
        GraphQLField("size", type: .scalar(Int.self)),
        GraphQLField("width", type: .scalar(Int.self)),
        GraphQLField("height", type: .scalar(Int.self)),
        GraphQLField("canonicalTitle", type: .scalar(String.self)),
        GraphQLField("objectName", type: .scalar(String.self)),
        GraphQLField("descriptionHTML", type: .scalar(String.self)),
        GraphQLField("originalDateTimeHTML", type: .scalar(String.self)),
        GraphQLField("artistHTML", type: .scalar(String.self)),
        GraphQLField("creditHTML", type: .scalar(String.self)),
        GraphQLField("licenseShortName", type: .scalar(String.self)),
        GraphQLField("licenseURL", type: .scalar(String.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(descriptionUrl: String? = nil, user: String? = nil, size: Int? = nil, width: Int? = nil, height: Int? = nil, canonicalTitle: String? = nil, objectName: String? = nil, descriptionHtml: String? = nil, originalDateTimeHtml: String? = nil, artistHtml: String? = nil, creditHtml: String? = nil, licenseShortName: String? = nil, licenseUrl: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "MediaWikiImage", "descriptionURL": descriptionUrl, "user": user, "size": size, "width": width, "height": height, "canonicalTitle": canonicalTitle, "objectName": objectName, "descriptionHTML": descriptionHtml, "originalDateTimeHTML": originalDateTimeHtml, "artistHTML": artistHtml, "creditHTML": creditHtml, "licenseShortName": licenseShortName, "licenseURL": licenseUrl])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// The URL of the wiki page describing the image.
    public var descriptionUrl: String? {
      get {
        return resultMap["descriptionURL"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "descriptionURL")
      }
    }

    /// The user who uploaded the file.
    public var user: String? {
      get {
        return resultMap["user"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "user")
      }
    }

    /// The size of the file in bytes.
    public var size: Int? {
      get {
        return resultMap["size"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "size")
      }
    }

    /// The pixel width of the image.
    public var width: Int? {
      get {
        return resultMap["width"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "width")
      }
    }

    /// The pixel height of the image.
    public var height: Int? {
      get {
        return resultMap["height"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "height")
      }
    }

    /// The canonical title of the file.
    public var canonicalTitle: String? {
      get {
        return resultMap["canonicalTitle"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "canonicalTitle")
      }
    }

    /// The image title, brief description, or file name.
    public var objectName: String? {
      get {
        return resultMap["objectName"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "objectName")
      }
    }

    /// A description of the image, potentially containing HTML.
    public var descriptionHtml: String? {
      get {
        return resultMap["descriptionHTML"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "descriptionHTML")
      }
    }

    /// The original date of creation of the image. May be a description rather than
    /// a parseable timestamp, and may contain HTML.
    public var originalDateTimeHtml: String? {
      get {
        return resultMap["originalDateTimeHTML"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "originalDateTimeHTML")
      }
    }

    /// The name of the image author, potentially containing HTML.
    public var artistHtml: String? {
      get {
        return resultMap["artistHTML"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "artistHTML")
      }
    }

    /// The source of the image, potentially containing HTML.
    public var creditHtml: String? {
      get {
        return resultMap["creditHTML"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "creditHTML")
      }
    }

    /// A short human-readable license name.
    public var licenseShortName: String? {
      get {
        return resultMap["licenseShortName"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "licenseShortName")
      }
    }

    /// A web address where the license is described.
    public var licenseUrl: String? {
      get {
        return resultMap["licenseURL"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "licenseURL")
      }
    }
  }
}
