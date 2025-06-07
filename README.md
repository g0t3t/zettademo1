# ZETTADEMO1

This is a simple Python Flask application that serves a web page displaying **Lorem Ipsum** text and a random image from a static folder. It is containerized, deployed to Azure Kubernetes Service (AKS), and includes TLS, GitOps via Argo CD, and a CI/CD pipeline with GitHub Actions.

---

## 🌐 Features

- ✅ Python Flask backend with CORS
- ✅ Serves random images and static HTML content
- ✅ Containerized with Docker
- ✅ Hosted on Azure Kubernetes Service (AKS)
- ✅ TLS certificates via Let's Encrypt and cert-manager
- ✅ Ingress-NGINX controller for routing
- ✅ Argo CD ApplicationSet for GitOps
- ✅ CI/CD using GitHub Actions

---

## 📁 Project Structure

ZETTADEMO1/
├── .github/workflows/ # GitHub Actions workflow
│ └── build_and_deploy.yml
├── app/
│ ├── app.py # Flask app
│ ├── Dockerfile # Container image build
│ ├── requirements.txt # Python deps
│ ├── templates/
│ │ └── index.html # HTML template
│ ├── static/ # 1.jpg - 8.jpg random images
│ └── k8s/
│ ├── manifest.yaml # Deployment, Service, Ingress
│ └── applicationset.yaml # Argo CD ApplicationSet
├── infra/tf/ # Terraform Azure setup
│ ├── main.tf
│ ├── variables.tf
│ ├── terraform.tfvars
│ ├── argocd.yaml # Argo CD setup
│ ├── cert-manager.yaml # Let's Encrypt cert-manager
│ └── ingress.yaml # Ingress NGINX
└── README.md

---

## 🚀 Getting Started

### Prerequisites

- Python 3.11
- Docker
- Terraform
- Azure CLI (logged in)
- kubectl
- Argo CD CLI (optional)

---

### 🧪 Local Development

```bash
cd app
python -m zetta1venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python app.py
```

Access at http://localhost:5000

---

### 🐳 Docker

docker build -t zettademo1-app .
docker run -p 5000:5000 zettademo1-app

---

### ☁️ Infrastructure Provisioning

az login
cd infra/tf
terraform init
terraform apply
cd ..
kubectl apply -f ingress.yaml cert-manger.yaml argocd.yaml

This creates the Azure infrastructure including AKS, Ingress, Cert-Manger and ArgoCD.

---

### ☸️ Kubernetes Deployment

cd app/k8s
kubectl apply -f manifest.yaml

This will manually run the app in the k8s cluster.

---

### 🤖 GitOps with Argo CD

kubectl apply -f app/k8s/applicationset.yaml

This setups the app and connects the ArgoCD to the repo so that it is ready for deploying.

---

### 🔁 CI/CD with GitHub Actions

The pipeline in .github/workflows/build_and_deploy.yml builds and deploys the app to AKS on push.

---

## 📈 Future Scaling and Optimizations

Better workflow:
- Add PR validation pipeline
- Add a DAST/SAST
- Use a custom distroless base image

App Scale:
- Add HorizontalPodAutoscaler and Cluster Autoscaler for AKS
- Cache static content using CDN

App and cluster monitoring:
- Create a second cluster in AKS
- Setup Prometheus stack with helm(Mimir can be used instead if the project will need HA)
- Setup Loki and optionally Tempo
