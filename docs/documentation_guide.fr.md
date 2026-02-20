# Guide de documentation

Ce guide explique comment installer et lancer la documentation en local.

## Prerequis

- Python 3.11+

## Installer MkDocs et ses plugins

Verifier que les scripts sont executables :

```bash
chmod +x mkdocs_installation.sh mkdocs_run.sh
```

Executer le script d'installation avec `bash` (pas `sh`) :

```bash
bash mkdocs_installation.sh
```

## Lancer la documentation en local

```bash
bash mkdocs_run.sh
```

Par defaut, MkDocs sert le site sur `http://127.0.0.1:8000/`.

## Mettre a jour les dependances

Modifier `mkdocs_requirements.txt`, puis relancer `bash mkdocs_installation.sh`.
