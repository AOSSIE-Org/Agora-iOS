![Swift](https://github.com/AOSSIE-Org/Agora-iOS/workflows/Swift/badge.svg?branch=gsoc-2020)

<p align="middle">
<img width="80%" height="80%" img src="/Screenshots/iPhoneScreenshots.png">
</p>

## Getting Started

1. [Download](https://developer.apple.com/xcode/download/) the Xcode 11 release.
2. Clone the repository. 
3. [Download Carthage](https://github.com/Carthage/Carthage)
4. Run `carthage bootstrap --platform iOS --cache-builds` to install tools and dependencies.

## For Facebook Login
1. Right-click info.plist, and choose Open As Source Code.
2. In <array><string> in the key [CFBundleURLSchemes], replace [APP_ID] with your App ID.
3. In <string> in the key FacebookAppID, replace [APP_ID] with your App ID.


## Readme

iOS Application for Agora Web that uses [Agora](https://gitlab.com/aossie/Agora/): An Electronic Voting Library implemented in Scala. This application uses [Agora Web API](https://gitlab.com/aossie/Agora-Web) as backend application.

To run the development environment for this frontend, you need [Git](https://git-scm.com/) installed.

## Table of contents


## Best practices

1. Try to do a root cause analysis for the issue, if applicable.
2. Reference the issue being fixed in the corresponding PR.
3. Use meaningful commit messages in a PR.
4. Use one commit per task. Do not over commit (add unnecessary commits for a single task) or under commit (merge 2 or more tasks in one commit).
5. Add screenshot/short video in case the changes made in the PR, are being reflected in the UI of the application.
6. Close the issue as soon as the corresponding PR is accepted/closed. (1)

(1) . https://docs.gitlab.com/ee/user/project/issues/managing_issues.html#closing-issues-automatically


## Some don'ts

1. Send a MR without an existing issue.
2. Fix an issue assigned to somebody else and submit a PR before the assignee does.
3. Report issues which are previously reported by others. (Please check both the open and closed issues).
4. Suggest unnecessary or completely new features in the issue list.
5. Add unnecessary spacing or indentation to the code.
