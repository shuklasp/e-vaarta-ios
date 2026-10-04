import Foundation
struct EvaartaEvidenceTimelineEntry{let index:Int;let itemId:String;let kind:String;let title:String;let text:String;let page:Int?}
extension EvaartaDocumentWorkspace{
    func evidenceTimeline(documentId:String)->[EvaartaEvidenceTimelineEntry]{
        items.filter{$0.anchor?.documentId==documentId}
            .sorted{
                let ap=$0.anchor?.page ?? Int.max, bp=$1.anchor?.page ?? Int.max
                if ap != bp { return ap < bp }
                let ao=$0.anchor?.startOffset ?? Int.max, bo=$1.anchor?.startOffset ?? Int.max
                if ao != bo { return ao < bo }
                return $0.id < $1.id
            }
            .enumerated()
            .map{EvaartaEvidenceTimelineEntry(index:$0.offset,itemId:$0.element.id,kind:$0.element.kind.rawValue,title:$0.element.title ?? $0.element.kind.rawValue,text:$0.element.text ?? $0.element.anchor?.quote ?? "",page:$0.element.anchor?.page)}
    }
}
