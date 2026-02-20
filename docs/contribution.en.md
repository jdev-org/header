# Contribution

We welcome contributions to the geOrchestra header.

## Workflow

Please use `main` as the up-to-date base branch.

1. Create an issue.
2. In a fork, create a branch from `main` (up to date).
3. Open a PR.
4. Discuss with reviewers.

Technical steps:

1. Fork the repository and create a feature branch.
2. Install dependencies and run the dev server:

   ```bash
   npm install
   npm run dev
   ```

3. Run linting before opening a PR:

   ```bash
   npm run lint
   ```

`npm run format` automatically formats files.

## Notes

- The `dist` branch is updated automatically on every commit to `main`.
- Many contributions should update documentation when relevant.
- Prefer small, focused pull requests.
