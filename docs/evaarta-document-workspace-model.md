# e-Vaarta Document Workspace Model — iOS

iOS will implement the same semantic workspace contract used by desktop and Android.

## Core entities

- Workspace
- Document
- SourceAnchor
- Excerpt
- Note
- Annotation
- Link

The model is deliberately independent from the mail UI so the iPhone/iPad experience can evolve into a full document-reading workspace.

## iPad-first interaction

The intended iPad experience is a split view:

- source document on one side
- workspace on the other

On iPhone, the workspace can become a sheet or navigation destination while preserving a one-tap return to the source anchor.

The model supports the active-reading pattern of extracting source content, annotating it, organizing ideas and linking related material. citeturn0search0turn0search1

## Shared interchange

The canonical interchange format is versioned JSON. Source anchors must survive synchronization so a note created on iPhone can navigate to the same evidence on desktop.
