# Guía de Configuración

## Prerrequisitos
- Debian 12
- Cuenta gratuita de GCP
- Herramientas: Packer, Ansible, Terraform, Docker, gcloud SDK

## Pasos
1. **Instalar Herramientas**: Seguir los pasos de instalación en los prerrequisitos.
2. **Packer**: Construir imagen del bastion: `packer build -var 'project_id=<tu-project-id>' packer/bastion.json`
3. **Terraform**: Provisionar infraestructura: `cd terraform; terraform apply -var-file=terraform.tfvars`
4. **Despliegue de la Aplicación**:
   - Construir y subir imagen Docker: `cd app; docker build -t gcr.io/<tu-project-id>/sre-app:latest .; docker push gcr.io/<tu-project-id>/sre-app:latest`
   - Desplegar en GKE: `kubectl apply -f app/deployment.yaml`