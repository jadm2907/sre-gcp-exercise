# Ejercicio SRE GCP

Este repositorio contiene scripts de automatización para provisionar infraestructura en GCP y desplegar una aplicación de ejemplo.

## Componentes
- Balanceador de Carga en la Nube
- Cloud DNS
- Host Bastion
- Clúster GKE
- Container Registry
- Cloud SQL (PostgreSQL)
- Aplicación Flask de Ejemplo

## Configuración
Ver [docs/configuracion.md](docs/configuracion.md) para instrucciones detalladas.

## Uso
1. Clonar repositorio: `git clone https://github.com/jadm2907/sre-gcp-exercise.git`
2. Configurar credenciales de GCP.
3. Ejecutar Packer, Ansible, Terraform y desplegar la aplicación según la guía de configuración.