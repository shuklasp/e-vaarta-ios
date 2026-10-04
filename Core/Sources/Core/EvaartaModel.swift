// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import Foundation

/// Platform-neutral e-Vaarta domain model.
///
/// This model intentionally contains no UI, persistence, networking, or
/// Thunderbird-specific implementation details.
public enum EvaartaChannel: String, Codable, Sendable {
    case email
    case sms
    case rcs
    case whatsapp
    case signal
    case telegram
    case slack
    case teams
    case matrix
    case xmpp
    case other
}

public enum EvaartaMessageState: String, Codable, Sendable {
    case draft
    case sent
    case delivered
    case read
    case failed
}

public struct EvaartaPerson: Identifiable, Codable, Equatable, Sendable {
    public let id: String
    public let displayName: String
    public let addresses: [String]

    public init(id: String, displayName: String, addresses: [String] = []) {
        self.id = id
        self.displayName = displayName
        self.addresses = addresses
    }
}

public struct EvaartaMessage: Identifiable, Codable, Equatable, Sendable {
    public let id: String
    public let conversationID: String
    public let senderID: String
    public let timestamp: Date
    public let channel: EvaartaChannel
    public let body: String
    public let state: EvaartaMessageState
    public let attachmentIDs: [String]

    public init(
        id: String,
        conversationID: String,
        senderID: String,
        timestamp: Date,
        channel: EvaartaChannel,
        body: String,
        state: EvaartaMessageState = .sent,
        attachmentIDs: [String] = []
    ) {
        self.id = id
        self.conversationID = conversationID
        self.senderID = senderID
        self.timestamp = timestamp
        self.channel = channel
        self.body = body
        self.state = state
        self.attachmentIDs = attachmentIDs
    }
}

public struct EvaartaConversation: Identifiable, Codable, Equatable, Sendable {
    public let id: String
    public let title: String?
    public let participantIDs: [String]
    public let channel: EvaartaChannel
    public let messageIDs: [String]
    public let projectID: String?

    public init(
        id: String,
        title: String? = nil,
        participantIDs: [String],
        channel: EvaartaChannel,
        messageIDs: [String] = [],
        projectID: String? = nil
    ) {
        self.id = id
        self.title = title
        self.participantIDs = participantIDs
        self.channel = channel
        self.messageIDs = messageIDs
        self.projectID = projectID
    }
}

public enum EvaartaTaskStatus: String, Codable, Sendable {
    case todo
    case inProgress
    case blocked
    case done
    case cancelled
}

public struct EvaartaProject: Identifiable, Codable, Equatable, Sendable {
    public let id: String
    public let name: String
    public let description: String?
    public let ownerID: String?
    public let taskIDs: [String]

    public init(
        id: String,
        name: String,
        description: String? = nil,
        ownerID: String? = nil,
        taskIDs: [String] = []
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.ownerID = ownerID
        self.taskIDs = taskIDs
    }
}

public struct EvaartaTask: Identifiable, Codable, Equatable, Sendable {
    public let id: String
    public let title: String
    public let projectID: String?
    public let status: EvaartaTaskStatus
    public let assigneeID: String?
    public let dueAt: Date?
    public let sourceConversationID: String?

    public init(
        id: String,
        title: String,
        projectID: String?,
        status: EvaartaTaskStatus = .todo,
        assigneeID: String? = nil,
        dueAt: Date? = nil,
        sourceConversationID: String? = nil
    ) {
        self.id = id
        self.title = title
        self.projectID = projectID
        self.status = status
        self.assigneeID = assigneeID
        self.dueAt = dueAt
        self.sourceConversationID = sourceConversationID
    }
}

public enum EvaartaAIExecution: String, Codable, Sendable {
    case local
    case cloud
    case hybrid
}

public struct EvaartaAIContext: Codable, Equatable, Sendable {
    public let execution: EvaartaAIExecution
    public let model: String?
    public let userApproved: Bool

    public init(
        execution: EvaartaAIExecution,
        model: String? = nil,
        userApproved: Bool = false
    ) {
        self.execution = execution
        self.model = model
        self.userApproved = userApproved
    }
}
