# e-Vaarta iOS Production Integration

The iOS client mirrors the desktop production boundary: semantic objects remain local-first, provider credentials remain references, and consequential actions require capability authorization.

Native provider SDKs, Keychain integration, background execution, notification handling, share-sheet flows, encrypted storage, and physical-device validation must be exercised in iOS CI/device environments before a release is marked validated.
