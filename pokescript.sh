#! /bin/bash

if [ $# -eq 0 ]; then
  echo "Núm. de argumentos no válido. Por favor, ingrese el nombre del pokemon que desea consultar."
  exit 1
fi

pokemon_to_search=$1

request_url="https://pokeapi.co/api/v2/pokemon/${pokemon_to_search}"

response=$(curl -fs $request_url)

if [ $? -ne 0 ]; then
  echo "Error. No se pudieron obtener los datos del Pokémon '$pokemon_to_search'. ¿Es posible que el Pokémon no exista?"
  exit 1
fi


name=$(jq -r '.name' <<< $response)
name=$(tr '[:lower:]' '[:upper:]' <<< ${name:0:1})${name:1}
id=$(jq -r '.id' <<< "$response")
order=$(jq -r '.order' <<< $response)
weight=$(jq -r '.weight' <<< $response)
height=$(jq -r '.height' <<< $response)

echo "$name (No. $id)"
echo "Id = $order"
echo "Weight = $weight"
echo "Height = $height"
