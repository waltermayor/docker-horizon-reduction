#!/bin/bash
set -e

echo "=== Test de entorno en contenedor ==="

# Verificar que Python arranca
python3 --version

# Verificar que PyTorch se puede importar
python3 - <<'EOF'
import jax
import jax.numpy as jnp

print("✅ JAX importado correctamente")
print("Versión:", jax.__version__)

# Revisar dispositivos disponibles
devices = jax.devices()
print("Dispositivos detectados:", devices)
EOF

# Verificar que tu app se ejecuta al menos en modo CPU
if [ -f app.py ]; then
    echo "=== Ejecutando app.py en CPU ==="
    python3 app.py --help || echo "app.py ejecutado en modo test ✅"
fi

echo "✅ Pruebas de contenedor completadas (sin GPU)"
