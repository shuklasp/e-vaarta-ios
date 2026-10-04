# e-Vaarta iOS Bootstrap

## Role

This repository is the iPhone/iPad client foundation for e-Vaarta, based on Thunderbird for iOS.

## Platform technology

Thunderbird iOS is a native Swift and SwiftUI application. e-Vaarta should retain that native architecture rather than introducing a cross-platform UI layer solely for code sharing.

## Shared product model

The iOS client should converge on the same e-Vaarta concepts as desktop and Android:

- accounts and identities
- people and conversations
- messages and attachments
- projects and tasks
- calendar events
- documents
- notifications
- AI actions
- permissions and workspace context

These are shared product contracts, not a requirement that UI or storage implementations be identical.

## Existing foundation

The upstream iOS project already contains native work around mail protocols, persistence, secure keychain storage and MIME handling. e-Vaarta should build on those foundations rather than replace them.

## Development principle

Keep e-Vaarta additions modular and preserve a clean path for incorporating upstream security and protocol improvements.
