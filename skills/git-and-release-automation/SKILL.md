---
name: git-and-release-automation
description: Git branching strategies, Conventional Commits specification, Semantic Versioning (SemVer 2.0.0), automated changelog generation, and streamlined release management.
---

# Git Workflow & Release Automation Standard

## 1. Branching Strategy & Workflow Models
- **Trunk-Based / Feature Branching**:
  - `main` / `master`: Always deployable, protected branch. Direct commits prohibited; all changes land via PRs.
  - Feature branches: `feat/<ticket-or-slug>`, Bug fixes: `fix/<ticket-or-slug>`, Chores: `chore/<slug>`.
  - Short-lived branches: Keep branch lifetime short (< 2-3 days) to minimize merge conflicts.
- **Merge Strategy**:
  - Prefer **Squash and Merge** for feature PRs to keep main branch history clean, atomic, and bisect-friendly.
  - Rebase feature branches on main before opening or completing PRs to ensure fast-forward linear history where required.

## 2. Conventional Commits 1.0.0
- **Standard Format**: `<type>(<scope>): <subject>`
  - Types:
    - `feat`: A new feature (bumps MINOR in SemVer)
    - `fix`: A bug fix (bumps PATCH in SemVer)
    - `perf`: A code change that improves performance
    - `refactor`: A code change that neither fixes a bug nor adds a feature
    - `docs`: Documentation-only changes
    - `test`: Adding missing tests or correcting existing tests
    - `chore`: Build process, dependencies, auxiliary tool changes
  - Breaking Changes: Append `!` after type/scope or include `BREAKING CHANGE: <explanation>` in footer (bumps MAJOR in SemVer).
  - Subject rules: Imperative present tense ("add", not "added"), lowercase, no period at end.

## 3. Semantic Versioning (SemVer 2.0.0)
- **Version Format**: `MAJOR.MINOR.PATCH[-PRERELEASE][+BUILD]`
  - `PATCH`: Backwards-compatible bug fixes.
  - `MINOR`: Backwards-compatible new features.
  - `MAJOR`: Incompatible API changes / breaking behavior changes.

## 4. Release Automation & Changelog Generation
- **Automated Tooling**:
  - Standardize with tools like `release-please`, `semantic-release`, or `changesets`.
  - Automatically parse commit logs to generate categorized `CHANGELOG.md`.
  - Generate annotated Git tags (`v1.2.3`) and publish GitHub Releases with release notes.

## 5. Git Hygiene & Pre-Commit Quality Checks
- Enforce commit message format with `commitlint`.
- Run fast pre-commit hooks (`husky` + `lint-staged`) to format staged files (Prettier/ESLint) before commit creation.
- Keep repository clean: prevent committing secrets, `.env` files, large binary files, and IDE configs via strict `.gitignore`.
