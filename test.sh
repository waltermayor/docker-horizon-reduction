#!/bin/bash
set -e

echo "=== Probando acceso a CUDA ==="
nvidia-smi || { echo "❌ No se detecta GPU"; exit 1; }

echo "=== Probando PyTorch ==="
python3 - <<'EOF'
import torch
print("PyTorch CUDA disponible:", torch.cuda.is_available())
print("Número de GPUs:", torch.cuda.device_count())
if torch.cuda.is_available():
    print("GPU actual:", torch.cuda.get_device_name(0))
EOF

echo "✅ Todas las pruebas pasaron"
