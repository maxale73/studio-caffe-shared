# Shared library release workflow

For future updates to this library, follow the workflow requested by the user:

1. Implement shared behavior here, without duplicating it in the server or app.
2. Run the relevant tests and commit only the changes for the current task.
3. Create the next available patch tag, preserving the existing `1.3.xxx` naming convention. Never replace an existing tag.
4. Push the library commit and new tag to both configured remotes, `origin` and `origin1`, without force pushes.
5. Update the shared-package requirement and resolved version in both `/Users/massimodileonardo/sc_server` and `/Users/massimodileonardo/StudioCaffeApp` to the published release, then verify both consumers.
6. Preserve unrelated local and staged changes. Commit the consumer updates when the task authorizes commits; do not push consumer repositories or deploy unless requested.

## Keep consumer package references stable

- Keep both consumers on the published remote package. Do not replace the app's `XCRemoteSwiftPackageReference` with a local package or leave the server in `swift package edit` mode. Test unpublished changes in an isolated temporary consumer checkout instead.
- Preserve the existing Xcode package and product identifiers, repository URL, and links in both the macOS and iOS targets. Update only the version requirement and resolved pin; never remove and re-add the package as part of a release.
- Publish and verify the new tag before updating either consumer. If publication is blocked, leave their working remote configuration intact and report the pending release.
- `from:` and Xcode's minimum version are lower bounds, and `Package.resolved` deliberately pins a version. After publication, update both lower bounds and explicitly resolve the new shared version; do not expect ordinary builds to select the newest tag automatically.
- Verify that the server's workspace state uses `sourceControlCheckout` rather than `edited`, that both resolved files point to the published tag's commit, and that unrelated pins are unchanged. Remove an existing editable override with `swift package unedit studio-caffe-shared`, preserving the external shared checkout.
- Resolve and build both app targets and the server using the remote dependency before completing the work. Do not clear all caches or change dependency identities to hide a resolution failure.
