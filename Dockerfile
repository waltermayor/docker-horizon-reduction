# Imagen base con CUDA
FROM nvidia/cuda:12.2.0-runtime-ubuntu22.04

# Evitar interacciones durante instalación
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias básicas + Python 3.10
RUN apt-get update && apt-get install -y \
    software-properties-common \
    git curl wget \
    && add-apt-repository ppa:deadsnakes/ppa -y \
    && apt-get update && apt-get install -y \
    python3.10 python3.10-distutils python3.10-venv \
    && wget https://bootstrap.pypa.io/get-pip.py -O get-pip.py \
    && python3.10 get-pip.py \
    && rm -rf /var/lib/apt/lists/* get-pip.py

# Crear symlink para que "python3" apunte a python3.10
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1

# Crear carpeta de trabajo
WORKDIR /workspace
RUN mkdir -p /workspace/shared

# Copiar requirements.txt (si existe)
COPY requirements.txt /workspace/

# Instalar dependencias de Python
RUN pip3 install --no-cache-dir -r requirements.txt

# Clonar el repo después de instalar requirements
RUN git clone https://github.com/seohongpark/horizon-reduction.git /workspace/horizon-reduction

# Copiar el script de test
COPY test.sh /workspace/test.sh
RUN chmod +x /workspace/test.sh

# Default command
CMD ["/bin/bash"]
