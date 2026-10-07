[![Jenkins](https://img.shields.io/badge/CI-Jenkins-D24939?logo=jenkins&logoColor=white)](https://github.com/the-jodingo/joash-web-app)
[![Terraform](https://img.shields.io/badge/Terraform-AWS-7B42BC?logo=terraform&logoColor=white)](https://github.com/the-jodingo/joash-web-app)
[![Python](https://img.shields.io/badge/Python-3-3776AB?logo=python&logoColor=white)](https://www.python.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

# Joash Web App

A reference DevOps platform project: a small containerised service with
infrastructure as code, a CI pipeline, monitoring, and security policy.

## Stack

| Component           | Choice                                  |
|---------------------|-----------------------------------------|
| Application         | Python 3 (`http.server`), no framework  |
| CI/CD               | Jenkins                                 |
| Infrastructure      | Terraform — AWS VPC + EKS               |
| Deployment strategy | Blue-green                              |
| Environments        | dev, stage, prod                        |
| Observability       | Prometheus + Grafana                    |
| Security            | NIST CSF-aligned policy + scanning      |

## Layout

```
joash-web-app/
├── app/sample-app/        # Service source (main.py) + requirements.txt
├── ci/                    # Jenkinsfile
├── infrastructure/        # Terraform: vpc.tf, modules/networking
├── monitoring/            # prometheus.yml, alert rules, Grafana dashboard
├── scripts/               # setup.sh, deploy.sh
└── security/policies/     # Security policy document
```

## Quick start

```bash
make setup     # create venv, install dependencies
make run       # start the service locally
make test      # run tests
make lint      # flake8
make deploy    # run scripts/deploy.sh (requires kubectl context)
```

The service listens on `$PORT` (default `8080`):

```bash
curl localhost:8080/health
# {"status": "healthy", "service": "joash-web-app"}
```

## Configuration

| Variable      | Default       | Purpose                    |
|---------------|---------------|----------------------------|
| `PORT`        | `8080`        | HTTP listen port           |
| `ENVIRONMENT` | `development` | Environment name in output |

## Infrastructure

`infrastructure/vpc.tf` provisions a VPC with three private subnets across
availability zones, plus an EKS cluster.

```bash
cd infrastructure
terraform init
terraform plan  -var="environment=dev"
terraform apply -var="environment=dev"
```

## Deployment

`scripts/deploy.sh` applies the blue-green manifests:

```bash
./scripts/deploy.sh dev
```

> **Note:** `deployments/blue-green.yaml` is not committed yet — add your
> blue/green Kubernetes manifests there before running a real deploy.

## Observability

`monitoring/prometheus.yml` scrapes the service; `monitoring/alerts/rules.yml`
defines alert conditions; `monitoring/dashboards/overview.json` is a Grafana
dashboard you can import directly.

## License

MIT
