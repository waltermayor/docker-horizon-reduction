# Imagen base con CUDA
FROM nvidia/cuda:12.2.0-runtime-ubuntu22.04

# Evitar interacciones durante instalación
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias
RUN apt-get update && apt-get install -y \
    python3 python3-pip git curl wget \
    && rm -rf /var/lib/apt/lists/*

# Crear carpeta de trabajo
WORKDIR /workspace

# Copiar requirements.txt (si existe)
COPY requirements.txt /workspace/

# Instalar dependencias de Python
RUN pip3 install --no-cache-dir -r requirements.txt

# Copiar el script de test
COPY test.sh /workspace/test.sh
RUN chmod +x /workspace/test.sh

# Default command
CMD ["/bin/bash"]
