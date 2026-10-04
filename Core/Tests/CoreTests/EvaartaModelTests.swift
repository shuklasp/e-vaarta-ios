// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import Foundation
import Testing
@testable import Core

@Test
func conversationCanLinkToProject() {
    let conversation = EvaartaConversation(
        id: "conversation-1",
        title: "Project kickoff",
        participantIDs: ["person-1"],
        channel: .email,
        projectID: "project-1"
    )

    #expect(conversation.projectID == "project-1")
}

@Test
func taskCanPreserveConversationOrigin() {
    let task = EvaartaTask(
        id: "task-1",
        title: "Prepare project brief",
        projectID: "project-1",
        sourceConversationID: "conversation-1"
    )

    #expect(task.sourceConversationID == "conversation-1")
}
