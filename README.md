# Infraestructura como Código para Servicio de API en Google Cloud.
### Este proyecto de infraestructura como código (IaC) utiliza Terraform para crear una infraestructura en Google Cloud que sigue las directivas proporcionadas en el diagrama. El objetivo es implementar un servicio de API en Google Cloud utilizando Google Cloud Endpoints y Google App Engine.

## Requisitos previos

Antes de comenzar, asegúrate de tener lo siguiente configurado:

1. Terraform instalado en tu sistema.
2. Credenciales de Google Cloud configuradas y autenticadas localmente.

## Estructura del proyecto

- app: Aplicacion de lenguaje Javascript, principalmente un entorno de servidor multiplataforma de codigo abierto.

- provider.tf : Provider oficial de Google para terraform.

- main.tf : Define la infraestructura utilizando Terraform, incluyendo la creación de recursos de Google Cloud Endpoints y Google App Engine.

- variables.tf : Contiene las variables utilizadas en el archivo main.tf.

- README.md (este archivo): Proporciona información sobre el proyecto y los pasos de implementación.

## Implementación

### Sigue estos pasos para implementar la infraestructura:

- Clona o descarga este repositorio en tu sistema local.

- Asegúrate de tener Terraform instalado y configurado correctamente.

- En el directorio del proyecto, ejecuta el siguiente comando para inicializar Terraform:

``` bash 
terraform init 
```

- Luego, ejecuta el siguiente comando para previsualizar los cambios que Terraform realizará en tu infraestructura:

``` bash 
terraform plan 
```

- Si estás satisfecho con los cambios propuestos, ejecuta el siguiente comando para aplicar la infraestructura:

``` bash 
terraform apply
```

- Terraform te pedirá confirmación para aplicar los cambios. Ingresa "yes" cuando se te solicite.

## Recursos adicionales

- (Documentación de Terraform para el proveedor de Google)[https://registry.terraform.io/providers/hashicorp/google/latest]

- (google_endpoint_service)[https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/endpoints_service]

- (google_app_engine_application)[https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/app_engine_application]

¡Listo! Ahora tienes una infraestructura como código para tu servicio de API en Google Cloud. Asegúrate de mantener tu infraestructura actualizada según las necesidades cambiantes de tu aplicación.




