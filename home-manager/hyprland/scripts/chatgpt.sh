#!/bin/sh

# Verificar si se proporcionó una pregunta
if [ -z "$1" ]; then
    echo "Por favor, ingrese una pregunta."
    exit 1
fi

# Convertir los argumentos en una cadena de texto
prompt="$*"

# Hacer la solicitud a la API de OpenAI
response=$(curl https://api.openai.com/v1/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -d '{
  "model": "text-davinci-003",
  "prompt": "'"${prompt}"'",
  "max_tokens": 100
}')

# Extraer la respuesta del JSON
echo "$response" | jq '.choices[0].text' | sed 's/^"//;s/"$//'
