# Shared library release workflow

For future updates to this library, follow the workflow requested by the user:

1. Implement shared behavior here, without duplicating it in the server or app.
2. Run the relevant tests and commit only the changes for the current task.
3. Create the next available patch tag, preserving the existing `1.3.xxx` naming convention. Never replace an existing tag.
4. Push the library commit and new tag to both configured remotes, `origin` and `origin1`, without force pushes.
5. Update the shared-package requirement and resolved version in both `/Users/massimodileonardo/sc_server` and `/Users/massimodileonardo/StudioCaffeApp` to the published release, then verify both consumers.
6. Preserve unrelated local and staged changes. Commit the consumer updates when the task authorizes commits; do not push consumer repositories or deploy unless requested.
