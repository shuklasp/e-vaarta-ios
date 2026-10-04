# e-Vaarta iOS Integrated Product Architecture

iOS follows the same semantic workspace flow: communication → document → evidence → claim → finding → decision → task → project → report → citation → communication.

The Core layer supplies workspace routing, identity matching, attachment deduplication and grounded-AI checks. SwiftUI/UIKit surfaces should project this shared semantic model.

Offline state and synchronization remain explicit; credentials are isolated from semantic data.

Source-level parity does not constitute iOS build, lifecycle, background task, share-sheet, keychain, accessibility or physical-device validation.
