import Foundation

public enum TopLevelItem {
    case story(Story)
    case job(Job)

    public var id: Int {
        switch self {
        case let .story(story): return story.id
        case let .job(job): return job.id
        }
    }

    var story: Story? {
        switch self {
        case let .story(story): return story
        case .job: return nil
        }
    }

    var job: Job? {
        switch self {
        case let .job(job): return job
        case .story: return nil
        }
    }
}

// MARK: - Decodable

extension TopLevelItem: Decodable {
    // MARK: - Error

    enum Error: Swift.Error { case decodingFailed }

    enum CodingKeys: String, CodingKey { case tags = "_tags" }

    public init(
        from decoder: Decoder
    ) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let tags = try container.decode([String].self, forKey: .tags)
        if tags.contains("story") {
            let story = try decoder.singleValueContainer().decode(Story.self)
            self = .story(story)
        } else if tags.contains("job") {
            let job = try decoder.singleValueContainer().decode(Job.self)
            self = .job(job)
        } else { throw Error.decodingFailed }
    }
}
