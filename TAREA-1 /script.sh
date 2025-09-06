#!/bin/bash

# Tarea #01 - Script Bash para Simular la Creación de Contenedores Aleatorios
# Universidad San Carlos de Guatemala
# Facultad de Ingeniería - Ingeniería en Ciencias y Sistemas
# Sistemas Operativos 1

echo "=== SIMULACIÓN DE CREACIÓN DE CONTENEDORES ==="
echo "Iniciando script de simulación..."
echo

# Obtener el directorio donde se encuentra el script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "Directorio de trabajo: $SCRIPT_DIR"

# Cambiar al directorio del script
cd "$SCRIPT_DIR"

# Solicitar número de carnet al usuario
echo "Por favor, ingresa tu número de carnet:"
read -p "Carnet: " CARNET

# Validar que se ingresó un carnet
if [ -z "$CARNET" ]; then
    echo "Error: Debe ingresar un número de carnet válido."
    exit 1
fi

echo "Carnet ingresado: $CARNET"
echo

# Generar número aleatorio entre 1 y 4 para la cantidad de contenedores
NUM_CONTENEDORES=$((RANDOM % 4 + 1))
echo "Generando $NUM_CONTENEDORES contenedor(es) aleatorio(s)..."
echo

# Array de nombres aleatorios para los contenedores
NOMBRES_ALEATORIOS=(
    "webserver"
    "database"
    "cache"
    "frontend"
    "backend"
    "nginx"
    "redis"
    "mysql"
    "apache"
    "nodejs"
    "python"
    "java"
    "docker"
    "kubernetes"
    "microservice"
    "api"
    "gateway"
    "proxy"
    "loadbalancer"
    "monitor"
)

# Función para generar un nombre aleatorio
generar_nombre_aleatorio() {
    local nombre_base=${NOMBRES_ALEATORIOS[$RANDOM % ${#NOMBRES_ALEATORIOS[@]}]}
    local numero_aleatorio=$((RANDOM % 1000))
    echo "${nombre_base}${numero_aleatorio}"
}

# Crear los contenedores (archivos)
for ((i=1; i<=NUM_CONTENEDORES; i++)); do
    # Generar nombre aleatorio único
    NOMBRE_ALEATORIO=$(generar_nombre_aleatorio)
    
    # Crear nombre del archivo
    NOMBRE_ARCHIVO="contenedor_${CARNET}_${NOMBRE_ALEATORIO}.txt"
    
    # Verificar si el archivo ya existe y generar uno nuevo si es necesario
    while [ -f "$NOMBRE_ARCHIVO" ]; do
        NOMBRE_ALEATORIO=$(generar_nombre_aleatorio)
        NOMBRE_ARCHIVO="contenedor_${CARNET}_${NOMBRE_ALEATORIO}.txt"
    done
    
    # Crear el archivo con su nombre como contenido
    echo "$NOMBRE_ARCHIVO" > "$NOMBRE_ARCHIVO"
    
    # Mostrar información del contenedor creado
    echo "✓ Contenedor $i creado: $NOMBRE_ARCHIVO"
    echo "  Ruta completa: $SCRIPT_DIR/$NOMBRE_ARCHIVO"
    echo "  Contenido: $(cat "$NOMBRE_ARCHIVO")"
    echo "  Tamaño: $(wc -c < "$NOMBRE_ARCHIVO") bytes"
    echo
done

echo "=== RESUMEN DE CONTENEDORES CREADOS ==="
echo "Total de contenedores creados: $NUM_CONTENEDORES"
echo "Carnet utilizado: $CARNET"
echo "Ubicación: $SCRIPT_DIR"
echo

echo "Lista de archivos creados:"
ls -la contenedor_${CARNET}_*.txt 2>/dev/null || echo "No se encontraron archivos de contenedores."

echo
echo "Contenido de los archivos creados:"
for archivo in contenedor_${CARNET}_*.txt; do
    if [ -f "$archivo" ]; then
        echo "--- $archivo ---"
        cat "$archivo"
        echo
    fi
done

echo "=== SIMULACIÓN COMPLETADA ==="
echo "Fecha y hora: $(date)"
echo "Script ejecutado desde: $SCRIPT_DIR"
echo "¡Contenedores simulados creados exitosamente!"