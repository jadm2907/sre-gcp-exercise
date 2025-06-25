## 🚀 Ejercicio SRE GCP

Este repositorio contiene scripts y configuraciones de automatización para provisionar infraestructura en Google Cloud Platform (GCP) y desplegar una aplicación de ejemplo, como parte de un ejercicio práctico para un puesto de Site Reliability Engineer (SRE).

---

## 🎯 Objetivo del Ejercicio

El objetivo de este proyecto es demostrar habilidades prácticas en automatización de infraestructura y despliegue de aplicaciones en un entorno cloud-native.
Se busca:

* ✅ Provisionar recursos clave como un balanceador de carga, Cloud DNS, un host bastion, un clúster GKE, un Container Registry y una base de datos PostgreSQL en Cloud SQL.
* ✅ Desplegar una aplicación Flask que interactúe con la base de datos, validando un flujo end-to-end.
* ✅ Configurar un entorno seguro con acceso controlado mediante un bastion.
* ✅ Mantener una estructura modular y reproducible, facilitando la colaboración y el mantenimiento.

---

## 🗂️ Componentes

| Componente                 | Descripción                                    |
| -------------------------- | ---------------------------------------------- |
| **Balanceador de Carga**   | Distribuye tráfico para alta disponibilidad    |
| **Cloud DNS**              | Gestión de nombres de dominio                  |
| **Host Bastion**           | Nodo de acceso seguro para administración      |
| **Clúster GKE**            | Orquestación de contenedores                   |
| **Artifact Registry**     | Almacenamiento de imágenes Docker              |
| **Cloud SQL (PostgreSQL)** | Base de datos relacional gestionada            |
| **Aplicación Flask**       | API de ejemplo que consume datos de PostgreSQL |

---

## 🧰 Prerrequisitos

### ✅ Entorno Local (Debian 12)

1. **Actualizar el sistema:**

   ```bash
   sudo apt update && sudo apt upgrade -y
   ```

2. **Instalar herramientas:**

   ```bash
   sudo apt install git curl unzip python3-pip docker.io -y
   sudo systemctl enable docker --now
   ```

   * **Google Cloud SDK:**

     ```bash
     curl https://sdk.cloud.google.com | bash
     exec -l $SHELL
     gcloud init
     gcloud auth application-default login
     ```

   * **Packer:** Descargar desde HashiCorp, descomprimir y mover a `/usr/local/bin`.

   * **Ansible:**

     ```bash
     pip3 install ansible
     ```

   * **Terraform:** Descargar desde HashiCorp, descomprimir y mover a `/usr/local/bin`.

---

### ✅ Cuenta de GCP

* **Cuenta gratuita:** Crear una cuenta gratuita en [Google Cloud](https://cloud.google.com/free).
* **APIs habilitadas:**

  * Compute Engine API
  * Kubernetes Engine API
  * Cloud SQL Admin API
  * Container Registry API
  * Cloud DNS API
  * Cloud Load Balancing API
* **Credenciales:** Configurar credenciales de servicio o autenticación de usuario.
* **Red:** Usar la VPC predeterminada y sus subredes.

---

## 📁 Estructura del Proyecto

```plaintext
sre-gcp-exercise/
├── .gitignore
├── README.md
├── create_project_structure.sh
├── packer/
│   └── bastion.json
├── ansible/
│   ├── playbook.yml
│   └── inventory.yml
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── modules/
│       ├── load_balancer/
│       ├── cloud_dns/
│       ├── bastion/
│       ├── gke/
│       ├── artifact_registry/
│       └── cloud_sql/
├── app/
│   ├── main.py
│   ├── requirements.txt
│   ├── Dockerfile
│   └── deployment.yaml
├── docs/
│   └── configuracion.md
```

---

## ⚙️ Orden de Ejecución

### 1️⃣ Clonar el Repositorio

```bash
git clone https://github.com/jadm2907/sre-gcp-exercise.git
cd sre-gcp-exercise
```

### 2️⃣ Crear Estructura del Proyecto

```bash
bash create_project_structure.sh
```

### 3️⃣ Construir la Imagen del Bastion con Packer

1. Edita `packer/bastion.json` para incluir tu `project_id`.
2. Ejecuta:

   ```bash
   cd packer
   packer build -var 'project_id=<TU_PROJECT_ID>' bastion.json
   ```

### 4️⃣ Configurar el Bastion con Ansible

1. Verifica `ansible/playbook.yml` para instalar `gcloud`, `kubectl`, `psql`, etc.
2. Ejecuta:

   ```bash
   cd ../ansible
   ansible-playbook -i inventory.yml playbook.yml
   ```

### 5️⃣ Provisionar Infraestructura con Terraform

1. Crea `terraform/terraform.tfvars`:

   ```hcl
   project_id        = "<TU_PROJECT_ID>"
   region            = "us-central1"
   zone              = "us-central1-a"
   domain            = "<TU_DOMINIO.COM>"
   database_name     = "appdb"
   database_user     = "appuser"
   database_password = "<CONTRASEÑA_SEGURA>"
   ```

2. Inicializa y aplica:

   ```bash
   cd ../terraform
   terraform init
   terraform apply -var-file="terraform.tfvars"
   ```

### 6️⃣ Construir y Subir la Imagen de la Aplicación

```bash
cd ../app
docker build -t gcr.io/<TU_PROJECT_ID>/sre-app:latest .
docker push gcr.io/<TU_PROJECT_ID>/sre-app:latest
```

### 7️⃣ Desplegar la Aplicación en GKE

1. Configura credenciales:

   ```bash
   gcloud container clusters get-credentials my-gke-cluster --zone us-central1-a
   ```

2. Aplica manifiestos:

   ```bash
   kubectl apply -f deployment.yaml
   ```

### 8️⃣ Verificar Despliegue

* Obtén la IP:

  ```bash
  terraform output load_balancer_ip
  ```

* Prueba la app:

  ```bash
  curl http://<IP_LOAD_BALANCER>
  ```

* Accede al Bastion:

  ```bash
  gcloud compute ssh bastion --zone us-central1-a
  ```

---

## 📚 Configuración Detallada

Consulta `docs/configuracion.md` para instrucciones y ejemplos adicionales.

---

## ⚠️ Notas

* **Seguridad:** No subas archivos sensibles (`terraform.tfvars`, `terraform.tfstate`). Están listados en `.gitignore`.
* **Validación:** Prueba el despliegue en un entorno limpio.
* **Tiempo estimado:** 30-60 minutos según red y recursos.

---

## 🔑 Depuración y Acceso SSH al Bastion

### 📌 Cómo obtener el nombre exacto de la instancia Bastion

1. **Usa la salida de Terraform:**

   ```bash
   terraform output instance_name
   ```

   Esto devuelve el nombre, por ejemplo: `bastion-host-20250624`.

2. **Accede vía SSH con el nombre:**

   ```bash
   gcloud compute ssh bastion-host-20250624 --zone us-central1-a
   ```

3. **Listar instancias como alternativa:**

   ```bash
   gcloud compute instances list --filter="zone:us-central1-a"
   ```

4. **Automatizar el comando:**

   ```bash
   gcloud compute ssh $(terraform output -raw instance_name) --zone us-central1-a
   ```

### ⚙️ Verifica tu clave SSH

* Asegúrate de tener `~/.ssh/id_rsa` y `~/.ssh/id_rsa.pub`.
* Si no existen, genera una:

  ```bash
  ssh-keygen -t rsa -b 4096 -C "tu_email@example.com"
  ```
* Verifica claves cargadas:

  ```bash
  ssh-add -l
  ```

### ✅ Consideraciones

* `enable-oslogin` está en `FALSE`, por lo que se usan claves SSH.
* Para usar nombre fijo, ajusta `main.tf`:

  ```hcl
  name = "bastion-host"
  ```

  Y re-aplica:

  ```bash
  terraform apply -var-file="terraform.tfvars"
  ```

  Luego usa:

  ```bash
  gcloud compute ssh bastion-host --zone us-central1-a
  ```

### 🕵️ Depura si falla

* Si falla la conexión:

  ```bash
  gcloud compute ssh bastion-host-20250624 --zone us-central1-a --ssh-flag="-v"
  ```
* Si no existe la instancia, asegúrate de aplicar Terraform de nuevo:

  ```bash
  terraform apply -var-file="terraform.tfvars"
  ```
## 📄 Documentación
- [Documento de Visión General del Proyecto](docs/Vision_General_Proyecto.pdf): Introducción al proyecto SRE-GCP, sus objetivos y arquitectura.
- [Guía de Instalación y Configuración](docs/Guia_Instalacion_Configuracion.pdf): Instrucciones para configurar el entorno local y GCP.
- [Manual de Provisionamiento con Terraform](docs/Manual_Provisionamiento_Terraform.pdf): Guía para provisionar infraestructura con Terraform.
- [Guía de Construcción con Packer y Ansible](docs/Guia_Construccion_Packer_Ansible.pdf): Instrucciones para crear imágenes y configurar con Ansible.

✅ **Fin del README**.