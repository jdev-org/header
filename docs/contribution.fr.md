# Contribution

Les contributions au header geOrchestra sont les bienvenues.

## Workflow

Il est preferable de partir de la branche `main` a jour.

1. Creer une issue.
2. Dans un fork, creer une branche a partir de la branche `main` (a jour).
3. Faire une PR.
4. Echanger avec les reviewers.

Etapes techniques :

1. Forker le depot et creer une branche de feature.
2. Installer les dependances et lancer le serveur de dev :

   ```bash
   npm install
   npm run dev
   ```

3. Lancer le lint avant d'ouvrir une PR :

   ```bash
   npm run lint
   ```

`npm run format` permet de formater les fichiers automatiquement.

## Notes

- La branche `dist` est mise a jour automatiquement a chaque commit sur `main`.
- Privilegier des PR petites et focalisees.
