Guía de Instalación
Proyecto SO1: Desarrollo de Contenedores y Gestión de Imágenes en Entornos Virtualizados
Información del Proyecto

Estudiante: Melvin Valencia
Carnet: 202111556
Curso: Sistemas Operativos 1 - USAC
Fecha: Agosto 2025


Prerrequisitos del Sistema
Hardware Mínimo

RAM: 8 GB (recomendado 16 GB)
Almacenamiento: 60 GB libres
CPU: Procesador con soporte para virtualización (Intel VT-x o AMD-V)
Red: Conexión a internet estable

Software Base

Sistema Operativo: Ubuntu 20.04+ / CentOS 8+ / Fedora 35+
Privilegios: Acceso root/sudo
Herramientas: git, curl, wget

Verificación de Soporte de Virtualización
bash# Verificar soporte de virtualización
egrep -c '(vmx|svm)' /proc/cpuinfo
# Debe retornar un número > 0

# Verificar módulos KVM
lsmod | grep kvm

Fase 1: Preparación del Entorno Host

1.1 Actualización del Sistema
bash# Ubuntu/Debian
sudo apt update && sudo apt upgrade -y

1.2 Instalación de KVM y Herramientas de Virtualización
Ubuntu/Debian:
bash# Instalar paquetes necesarios
sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virtinst virt-manager

1.3 Configuración de Usuarios y Servicios
bash# Agregar usuario a grupos necesarios
sudo usermod -aG libvirt $USER
sudo usermod -aG kvm $USER

# Habilitar y iniciar servicios
sudo systemctl enable libvirtd
sudo systemctl start libvirtd
sudo systemctl enable virtlogd
sudo systemctl start virtlogd

# Verificar estado de servicios
sudo systemctl status libvirtd