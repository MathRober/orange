# Creación de un cluster EKS

Este repo contiene dos carpetas:
Kubernetes: Contiene la creación del cluster en AWS mediante terraform
usuarios: Contiene un helm con los elementos a crear dentro del cluster

## Kubernetes. IaC con Terraform
Esta carpeta contiene la cración de un cluster EKS de AWS con todos los elementos asociados.

Crea lo siguiente:
- una VPC
- Dos subredes en dos zonas de disponibilidad diferentes
- un secuirty group con reglas de tráfico
- Varios roles y directivas de administración de EKS
- Un cluster EKS
- Un grupo de nodos con dos instancias


# Ejecución
Desde una consola cmd o bash, configurar las variables de entorno de acceso a AWS

- set AWS_ACCESS_KEY_ID=<AWS_ACCESS_KEY_ID>
- set AWS_SECRET_ACCESS_KEY=<AWS_SECRET_ACCESS_KEY>
- set AWS_DEFAULT_REGION=<AWS_DEFAULT_REGION>

Descargar Terraform desde esta url: https://www.terraform.io/downloads.html
Hacer un clone del repositorio  xxxxxx y ejecutar:

```bash

terraform validate
terraform plan
terraform apply

```


Una vez desplegado configurar el cliente kubectl:

aws eks --region eu-west-3 update-kubeconfig --name cluster01

# Instalación de los yaml

Situarse ene la raiz del repo y ejecutar:

```bash

helm upgrade --debug   usuarios ./usuarios

```

# Notas

Los archivos de Terraform tienen todas las variables hardcodeades. Habría que separar las variables en un archivo .tfvars.




