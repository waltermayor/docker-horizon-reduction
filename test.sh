#!/bin/bash
echo "=== Testeando contenedor ==="
python3 --version
pip list | head -n 10
echo "Todo OK ✅"