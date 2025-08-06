import SwiftUI

struct QueueSort: Equatable {
    var isAscending: Bool = false
    var option: Option = .byAdded

    var instance: String = ".all"
    var type: String = ".all"
    var client: String = ".all"

    var issues: Bool = false

    enum Option: CaseIterable, Hashable, Identifiable, Codable {
        var id: Self { self }

        case byTitle
        case byAdded
        case byProgress
        case byTimeRemaining

        var label: some View {
            switch self {
            case .byTitle: Label("Title", systemImage: "textformat.abc")
            case .byAdded: Label("Added", systemImage: "calendar.badge.plus")
            case .byProgress: Label("Progress", systemImage: "percent")
            case .byTimeRemaining: Label("Time Remaining", systemImage: "hourglass")
            }
        }

        func isOrderedBefore(_ lhs: QueueItem, _ rhs: QueueItem) -> Bool {
            switch self {
            case .byTitle:
                lhs.titleLabel < rhs.titleLabel
            case .byAdded:
                lhs.added ?? Date.distantPast < rhs.added ?? Date.distantPast
            case .byProgress:
                (lhs.size > 0 && lhs.sizeleft >= 0 ? lhs.sizeleft / lhs.size : 1) > (rhs.size > 0 && rhs.sizeleft >= 0 ? rhs.sizeleft / rhs.size : 1)
            case .byTimeRemaining:
                lhs.estimatedCompletionTime ?? Date.distantPast < rhs.estimatedCompletionTime ?? Date.distantPast
            }
        }
    }

    var hasFilter: Bool {
        instance != ".all" ||
        type != ".all" ||
        client != ".all" ||
        issues == true
    }
}
