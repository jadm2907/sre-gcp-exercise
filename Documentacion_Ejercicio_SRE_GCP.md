## 📄 Documentación Completa: Ejercicio Práctico SRE en GCP

### 🎯 Introducción

Este documento detalla **todo el contenido original** del ejercicio práctico para SRE en GCP, manteniendo **cada párrafo y frase**, organizado visualmente con **secciones, listas, tablas y bloques de código** para facilitar su lectura.

---

### ✅ ¿Para qué sirve este ejercicio?

Evalúa la capacidad de diseñar, automatizar y desplegar infraestructura **eficiente, segura y escalable**, simulando un escenario real de trabajo de un SRE.

### 🎯 Objetivo del Ejercicio

* **Automatizar la infraestructura** usando **Packer, Ansible y Terraform**.
* **Desplegar una aplicación** que use Cloud SQL y GKE.
* **Configurar acceso seguro** con Bastion y claves SSH.
* **Publicar scripts reproducibles y documentados en GitHub**.

---

### 🛠️ ¿Por qué se usan estas tecnologías?

**Packer:** Crea imágenes reproducibles para entornos estandarizados.

**Ansible:** Configura servidores de forma declarativa y sin agentes.

**Terraform:** Gestiona infraestructura como código, reproducible y versionable.

**Terragrunt (opcional):** Organiza múltiples entornos para grandes proyectos.

---

### 📌 Relevancia

* **Automatización:** Minimiza tareas manuales.
* **Confiabilidad:** Balanceador, DNS y GKE garantizan disponibilidad.
* **Seguridad:** Bastion y gestión de credenciales.
* **Colaboración:** Documentación y scripts claros en repositorio público.

---

### 🎯 Objetivos Principales (detallados)

* Provisionar Load Balancer, DNS, Bastion, GKE, Registry y Cloud SQL.
* Usar la VPC predeterminada.
* Implementar una app funcional con acceso DB.
* Asegurar acceso controlado y seguro.
* Documentar y entregar en GitHub.
* Mostrar dominio de herramientas SRE.

---

### 🗂️ Componentes Clave

| Componente                        | Función                | Beneficio                  |
| --------------------------------- | ---------------------- | -------------------------- |
| **Cloud Load Balancer**           | Balancea tráfico       | Alta disponibilidad        |
| **Cloud DNS**                     | Gestiona dominio       | Acceso amigable            |
| **Bastion**                       | Punto de acceso seguro | Menor exposición pública   |
| **GKE**                           | Orquesta contenedores  | Despliegue escalable       |
| **Container Registry**            | Guarda imágenes Docker | Seguridad y centralización |
| **Cloud SQL (PostgreSQL)**        | Base de datos          | Gestión y escalabilidad    |
| **Aplicación de ejemplo (Flask)** | Valida integración     | Flujo E2E funcional        |

---

### 📂 Estructura del Proyecto

```plaintext
sre-gcp-exercise/
├── packer/
├── ansible/
├── terraform/ (módulos por recurso)
├── app/ (código Flask, Dockerfile, manifiestos K8s)
├── docs/
└── README.md
```

---

### ⚙️ Flujo de Ejecución Completo

1️⃣ **Clonar repositorio:**

```bash
git clone <repo_url>
cd sre-gcp-exercise
```

2️⃣ **Configurar entorno local:**

* Google Cloud SDK
* Packer
* Ansible
* Terraform
* Docker

3️⃣ **Construir imagen Bastion:**

```bash
cd packer
packer build -var 'project_id=<PROJECT_ID>' bastion.json
```

4️⃣ **Configurar Bastion:**

```bash
cd ../ansible
ansible-playbook -i inventory.yml playbook.yml
```

5️⃣ **Provisionar Infraestructura:**

```bash
cd ../terraform
terraform init
terraform apply -var-file="terraform.tfvars"
```

6️⃣ **Construir y subir imagen Flask:**

```bash
cd ../app
docker build -t gcr.io/<PROJECT_ID>/sre-app:latest .
docker push gcr.io/<PROJECT_ID>/sre-app:latest
```

7️⃣ **Desplegar en GKE:**

```bash
gcloud container clusters get-credentials sre-gke-cluster --zone us-central1-a
kubectl apply -f deployment.yaml
```

8️⃣ **Verificar IP Load Balancer:**

```bash
terraform output load_balancer_ip
curl http://<IP>
```

---

### 🔑 Acceso Bastion y Depuración

* **Obtener nombre:**

```bash
terraform output instance_name
```

* **Acceso SSH:**

```bash
gcloud compute ssh $(terraform output -raw instance_name) --zone us-central1-a
```

* **Listar instancias:**

```bash
gcloud compute instances list --filter="zone:us-central1-a"
```

* **Automatizar comando:**

```bash
gcloud compute ssh $(terraform output -raw instance_name) --zone us-central1-a
```

* **Clave SSH:**

```bash
ssh-keygen -t rsa -b 4096 -C "email@example.com"
ssh-add -l
```

* **Depuración SSH:**

```bash
gcloud compute ssh bastion-host-YYYYMMDD --zone us-central1-a --ssh-flag="-v"
```

* **Nombre fijo:**

```hcl
name = "bastion-host"
```

```bash
terraform apply -var-file="terraform.tfvars"
gcloud compute ssh bastion-host --zone us-central1-a
```

---

### ✅ Consideraciones Finales

* Mantén claves SSH y secretos seguros.
* Consulta `docs/configuracion.md` para más detalles.
* No publiques `terraform.tfvars` ni `terraform.tfstate`.

---

## 🎓 Conclusión

Este ejercicio combina automatización, infraestructura como código, seguridad y prácticas reales de SRE para demostrar capacidades técnicas completas en GCP. Perfecto para simular situaciones reales de trabajo.


