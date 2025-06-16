#!/bin/bash

# Archivo de entrada y salida
INPUT_JSON="outputs.json"
OUTPUT_TFVARS="terraform.tfvars"

terraform output -json > $INPUT_JSON

if [ ! -f "$INPUT_JSON" ]; then
  echo "❌ No se encontró el archivo $INPUT_JSON. Ejecuta 'terraform output -json > $INPUT_JSON' primero."
  exit 1
fi

echo "🔄 Generando $OUTPUT_TFVARS desde $INPUT_JSON..."

jq -r '
to_entries[] |
  if .value.type == "string" then
    "\(.key) = \"\(.value.value)\""
  elif .value.type[0] == "list" then
    "\(.key) = [\(.value.value | map("\""+.+"\"") | join(", "))]"
  elif .value.type == "bool" or .value.type == "number" then
    "\(.key) = \(.value.value)"
  else
    "# tipo no soportado para \(.key)"
  end
' "$INPUT_JSON" > "$OUTPUT_TFVARS"

echo "✅ Archivo $OUTPUT_TFVARS generado correctamente."
