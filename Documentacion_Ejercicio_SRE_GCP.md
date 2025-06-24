Documentación: Ejercicio Práctico para el Puesto de SRE en GCP
Introducción
Este documento proporciona una visión integral del ejercicio práctico diseñado para evaluar las competencias de un candidato al puesto de Site Reliability Engineer (SRE) en el entorno de Google Cloud Platform (GCP). El ejercicio requiere la automatización de infraestructura y el despliegue de una aplicación utilizando herramientas modernas de infraestructura como código (IaC) y prácticas de DevOps.
¿Para qué sirve este ejercicio?
El ejercicio tiene como propósito evaluar la capacidad del candidato para diseñar, implementar y automatizar infraestructura en la nube de manera eficiente, segura y escalable. Simula un escenario realista donde un SRE debe provisionar recursos en GCP, configurar un entorno seguro y desplegar una aplicación funcional que interactúe con una base de datos. Este tipo de evaluación permite medir habilidades técnicas, comprensión de herramientas de automatización y la aplicación de mejores prácticas en ingeniería de confiabilidad.
Objetivo del ejercicio
El objetivo principal es demostrar de forma práctica el conocimiento y la experiencia en automatización y configuración de infraestructura en GCP. Esto incluye:

Automatización de infraestructura: Provisionar recursos en la nube utilizando herramientas como Packer, Ansible y Terraform.
Despliegue de aplicaciones: Implementar una aplicación que interactúe con una base de datos en un clúster de Kubernetes (GKE).
Seguridad y acceso: Configurar un host bastion para acceso seguro y gestionar recursos como DNS y balanceadores de carga.
Documentación y entrega: Crear un repositorio público en GitHub con scripts funcionales y documentación clara.

El ejercicio evalúa la capacidad del candidato para integrar múltiples herramientas y servicios en un flujo de trabajo cohesivo, reflejando las responsabilidades de un SRE en un entorno empresarial.
¿Por qué se usan estas tecnologías?
Las tecnologías especificadas (Packer, Ansible, Terraform, y opcionalmente Terragrunt) son estándares de la industria en la gestión de infraestructura como código y automatización. A continuación, se explica por qué se utilizan:

Packer:

Propósito: Crear imágenes de máquinas personalizadas de manera reproducible.
Razón: Permite estandarizar entornos (como el bastion) con configuraciones predefinidas, reduciendo errores manuales y acelerando el despliegue.
Beneficio: Imágenes consistentes y optimizadas que mejoran la seguridad y la eficiencia.


Ansible:

Propósito: Automatizar la configuración y gestión de servidores.
Razón: Es una herramienta sin agentes, fácil de usar, que permite instalar software y configurar sistemas de manera declarativa.
Beneficio: Simplifica la gestión de configuraciones y asegura consistencia en múltiples entornos.


Terraform:

Propósito: Gestionar infraestructura como código en múltiples proveedores de nube.
Razón: Su enfoque declarativo y su compatibilidad con GCP permiten definir y provisionar recursos de manera reproducible y versionable.
Beneficio: Facilita la escalabilidad, el control de versiones y la colaboración en equipos.


Terragrunt (opcional):

Propósito: Mejorar la organización y reutilización de código Terraform en entornos complejos.
Razón: Ayuda a gestionar múltiples entornos (dev, prod) y reduce la duplicación de código.
Beneficio: Mayor mantenibilidad en proyectos grandes, aunque no es crítico para este ejercicio.



Estas herramientas reflejan las prácticas modernas de DevOps y SRE, promoviendo la automatización, la reproducibilidad y la escalabilidad, que son esenciales para mantener sistemas confiables y eficientes.
¿Por qué es relevante?
La relevancia del ejercicio radica en su alineación con las demandas del rol de SRE en la industria tecnológica actual:

Automatización: Los SRE buscan minimizar tareas manuales para reducir errores y mejorar la eficiencia. Este ejercicio evalúa la capacidad de automatizar procesos complejos.
Confiabilidad: La configuración de un balanceador de carga, DNS y GKE refleja la necesidad de garantizar alta disponibilidad y escalabilidad.
Seguridad: El uso de un bastion y la gestión segura de credenciales (como en Cloud SQL) demuestra un enfoque en proteger la infraestructura.
Colaboración: La entrega en un repositorio público con documentación clara simula el trabajo en equipo y la necesidad de compartir conocimiento.
Nube moderna: GCP es un proveedor líder, y dominar sus servicios es una habilidad crítica para los SRE en entornos cloud-native.

En un contexto donde las empresas dependen de sistemas distribuidos y de alta disponibilidad, este ejercicio prueba la capacidad del candidato para contribuir a la estabilidad y escalabilidad de la infraestructura.
Objetivos principales

Automatizar la infraestructura en GCP:

Provisionar recursos como Cloud Load Balancer, Cloud DNS, bastion, GKE, Container Registry y Cloud SQL utilizando herramientas IaC.
Aprovechar la VPC predeterminada para simplificar la configuración de red.


Desplegar una aplicación funcional:

Implementar una aplicación que consuma datos de una base de datos PostgreSQL en Cloud SQL.
Asegurar que la aplicación sea accesible a través del balanceador de carga.


Garantizar seguridad y acceso controlado:

Configurar un host bastion para accesos seguros a la infraestructura.
Gestionar credenciales de manera segura (por ejemplo, usando Secret Manager).


Entregar un producto documentado:

Proveer un repositorio público en GitHub con scripts funcionales y documentación clara.
Incluir instrucciones para reproducir el entorno y desplegar la aplicación.


Demostrar competencias técnicas:

Mostrar dominio de Packer, Ansible, Terraform y Kubernetes.
Aplicar mejores prácticas de SRE, como la reproducibilidad y la modularidad.



Componentes clave, su función y beneficios
A continuación, se detalla cada componente del ejercicio, su propósito y los beneficios que aporta:

Cloud Load Balancer:

Función: Distribuye el tráfico entrante entre las instancias de la aplicación en GKE, asegurando alta disponibilidad.
Beneficio: Mejora la escalabilidad y la resiliencia al balancear la carga y manejar fallos de nodos automáticamente.
Uso en el ejercicio: Permite acceder a la aplicación a través de una IP pública estática.


Cloud DNS:

Función: Gestiona registros DNS para asociar un dominio con la IP del balanceador de carga.
Beneficio: Facilita el acceso a la aplicación mediante un nombre de dominio amigable y mejora la experiencia del usuario.
Uso en el ejercicio: Configura un dominio para la aplicación, simulando un entorno de producción.


Bastion:

Función: Actúa como un punto de entrada seguro para acceder a recursos internos de la VPC, como GKE o Cloud SQL.
Beneficio: Reduce la superficie de ataque al limitar el acceso directo a los recursos y centralizar la autenticación.
Uso en el ejercicio: Utiliza una imagen personalizada creada con Packer y configurada con Ansible para instalar herramientas como kubectl y psql.


GKE (Google Kubernetes Engine):

Función: Orquesta contenedores para desplegar y gestionar la aplicación de manera escalable.
Beneficio: Simplifica la gestión de aplicaciones cloud-native, ofreciendo autoescalado, actualizaciones sin downtime y monitoreo integrado.
Uso en el ejercicio: Aloja la aplicación Flask y la expone a través de un servicio interno conectado al balanceador de carga.


Container Registry:

Función: Almacena imágenes Docker de la aplicación para su despliegue en GKE.
Beneficio: Proporciona un repositorio seguro y privado para imágenes, integrado con GCP.
Uso en el ejercicio: Guarda la imagen Docker de la aplicación Flask para su uso en el clúster GKE.


Cloud SQL (PostgreSQL):

Función: Proporciona una base de datos relacional gestionada para almacenar datos de la aplicación.
Beneficio: Ofrece alta disponibilidad, copias de seguridad automáticas y escalabilidad sin necesidad de gestionar servidores.
Uso en el ejercicio: La aplicación Flask consulta la base de datos para devolver la hora actual, demostrando integración con datos persistentes.


Aplicación de ejemplo:

Función: Una aplicación simple (en este caso, Flask en Python) que interactúa con Cloud SQL para probar la infraestructura.
Beneficio: Valida la correcta configuración de los componentes (GKE, balanceador, base de datos) y demuestra funcionalidad end-to-end.
Uso en el ejercicio: Sirve como prueba de concepto para un despliegue real.



Conclusión
El ejercicio práctico para el puesto de SRE en GCP es una evaluación completa que refleja las responsabilidades reales de un ingeniero de confiabilidad. Al combinar automatización, infraestructura como código, seguridad y despliegue de aplicaciones, el ejercicio permite al candidato demostrar habilidades técnicas y un enfoque sistemático para resolver problemas complejos. Las tecnologías utilizadas (Packer, Ansible, Terraform) son fundamentales en la industria, y los componentes implementados (Load Balancer, DNS, GKE, etc.) son esenciales para construir sistemas confiables y escalables. Este ejercicio no solo evalúa competencias técnicas, sino también la capacidad de documentar y entregar soluciones de manera profesional, lo que es crítico para el éxito en un rol de SRE.