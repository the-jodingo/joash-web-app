[![CI](https://github.com/the-jodingo/joash-web-app/actions/workflows/ci.yml/badge.svg)](https://github.com/the-jodingo/joash-web-app/actions/workflows/ci.yml)
[![Jenkins](https://img.shields.io/badge/CI-Jenkins-D24939?logo=jenkins&logoColor=white)](ci/Jenkinsfile)
[![Terraform](https://img.shields.io/badge/Terraform-AWS-7B42BC?logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Python](https://img.shields.io/badge/Python-3.12-3776AB?logo=python&logoColor=white)](https://www.python.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

# Joash Web App

A containerised web application with a complete delivery pipeline: Jenkins CI,
Terraform-managed infrastructure, Prometheus monitoring, and a blue-green
deployment path.

## Table of contents

- [Requirements](#requirements)
- [Quick start](#quick-start)
- [Usage](#usage)
- [Configuration](#configuration)
- [Deployment](#deployment)
- [Monitoring](#monitoring)
- [Testing and CI](#testing-and-ci)
- [Project structure](#project-structure)
- [Contributing](#contributing)
- [License](#license)

## Requirements

| Tool | Version | Needed for |
|---|---|---|
| Python | 3.11+ | Running the service and tests |
| Terraform | 1.5+ | Infrastructure |
| kubectl | 1.28+ | Deployment |
| Docker | any recent | Container builds |

## Quick start

```bash
git clone https://github.com/the-jodingo/joash-web-app.git
cd joash-web-app
make setup
make run
```

```bash
curl localhost:8080/health
# {"status": "healthy", "service": "joash-web-app"}
```

## Usage

| Command | Description |
|---|---|
| `make help` | List targets |
| `make setup` | Create venv, install dependencies |
| `make run` | Run locally on `$PORT` |
| `make test` | pytest |
| `make lint` | flake8 |
| `make deploy` | Apply blue-green manifests |

### Endpoints

| Method | Path | Response |
|---|---|---|
| `GET` | `/health` | `{"status": "healthy", "service": "joash-web-app"}` |
| `GET` | `/` | `joash-web-app running in <env>` |
| any | anything else | `404` |

## Configuration

| Variable | Default | Description |
|---|---|---|
| `PORT` | `8080` | HTTP listen port |
| `ENVIRONMENT` | `development` | Environment name |

## Deployment

```bash
./scripts/deploy.sh dev
```

Fails fast if `deployments/blue-green.yaml` or `kubectl` is missing.

## Monitoring

Alert rules and a Grafana dashboard live in `monitoring/`. Import
`monitoring/dashboards/overview.json` into Grafana to get started.

## Testing and CI

```bash
make test
make lint
```

GitHub Actions runs flake8 and pytest on Python 3.12 for every push and PR.

## Project structure

```
joash-web-app/
├── app/sample-app/         # main.py, requirements.txt
├── ci/                     # Jenkinsfile
├── infrastructure/         # vpc.tf, modules/networking/main.tf
├── monitoring/             # alerts/, dashboards/
├── scripts/                # setup.sh, deploy.sh
├── security/policies/      # security-policy.md
├── tests/                  # test_app.py
└── Makefile
```

## Contributing

Branch from `main`, add tests, run `make lint && make test`, then open a PR.

## License

[MIT](LICENSE) © Joash Odingo
