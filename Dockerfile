# Imagen base con CUDA y Python
FROM nvidia/cuda:12.2.0-runtime-ubuntu22.04

# Evita prompts interactivos
ENV DEBIAN_FRONTEND=noninteractive

# Instala Python y dependencias
RUN apt-get update && apt-get install -y \
    python3 python3-pip git && \
    rm -rf /var/lib/apt/lists/*

# Copia requirements si existen
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt || true

# Copia el script de prueba
COPY test.sh /test.sh
RUN chmod +x /test.sh

# Default command
CMD ["bash", "/test.sh"]
