# Documentation guide

This guide explains how to install and run the documentation locally.

## Prerequisites

- Python 3.11+

## Install MkDocs and plugins

Make sure the scripts are executable:

```bash
chmod +x mkdocs_installation.sh mkdocs_run.sh
```

Run the installation script with `bash` (not `sh`):

```bash
bash mkdocs_installation.sh
```

## Run the documentation locally

```bash
bash mkdocs_run.sh
```

MkDocs serves the site on `http://127.0.0.1:8000/` by default.

## Update dependencies

Edit `mkdocs_requirements.txt`, then re-run `bash mkdocs_installation.sh`.
