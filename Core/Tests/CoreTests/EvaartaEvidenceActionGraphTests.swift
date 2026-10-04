import XCTest
@testable import Core

final class EvaartaEvidenceActionGraphTests: XCTestCase {
    func testCanonicalChain() {
        let evidence = EvaartaSemanticNode(id: "e", type: .evidence, sourceIds: ["doc"])
        let claim = EvaartaSemanticNode(id: "c", type: .claim, sourceIds: ["e"])
        let decision = EvaartaSemanticNode(id: "d", type: .decision, sourceIds: ["c"])
        let task = EvaartaSemanticNode(id: "t", type: .task, sourceIds: ["d"])
        let graph = EvaartaSemanticGraph(
            nodes: [evidence, claim, decision, task],
            edges: [
                EvaartaSemanticEdge(from: "e", to: "c", type: .supports, evidenceIds: ["e"]),
                EvaartaSemanticEdge(from: "c", to: "d", type: .resultsIn),
                EvaartaSemanticEdge(from: "d", to: "t", type: .resultsIn)
            ]
        )
        XCTAssertTrue(EvaartaEvidenceActionGraph.validate(graph))
        XCTAssertEqual(EvaartaEvidenceActionGraph.nodesOfType(graph, .evidence).count, 1)
        XCTAssertEqual(EvaartaEvidenceActionGraph.linkedNodes(graph, nodeId: "c").count, 2)
    }

    func testBrokenGraphRejected() {
        let graph = EvaartaSemanticGraph(
            nodes: [EvaartaSemanticNode(id: "e", type: .evidence)],
            edges: [EvaartaSemanticEdge(from: "e", to: "missing", type: .supports)]
        )
        XCTAssertFalse(EvaartaEvidenceActionGraph.validate(graph))
    }
}
