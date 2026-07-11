# Agent Security & Boundary Protocols

## Environment Constraints
* **Mandatory File Filter:** You must strictly honor the project's `.gitignore` and `.aiexclude` files as absolute boundaries.
* **Prohibited Read/Write:** Do not read, explain, summarize, or modify any files or directories listed in `.gitignore`.
* **Manual Override Denial:** If I explicitly ask you to interact with a file that is ignored (e.g., something in `/build`, `.env`, or `.dart_tool`), you must refuse the request.

## Standard Refusal Response
* When refusing an ignored file, state: "Protocol Error: [File Path] is listed in .gitignore. I am restricted from accessing ignored assets to prevent context pollution and security leaks."

## Development Rules
* **Commit Guidelines:** All commits must follow Melos conventional commits with package scope (e.g., `feat(sky_router_lints): ...`, `fix(sky_router): ...`). **Never use `docs` as the commit type** — Melos excludes `docs` commits from versioning and publishing. Use `chore` for non-code or maintenance changes instead.
* **No Publishing:** Never publish any packages to pub.dev. The user will handle publication manually.
