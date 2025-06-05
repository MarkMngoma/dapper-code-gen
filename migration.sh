#!/bin/bash
generate_timestamp_prefix() {
  date +"%Y%m%d%H%M%S"
}

create_migration_script() {
  local migration_name=$1
  local timestamp_prefix=$(generate_timestamp_prefix)

  if [ -z "$migration_name" ]; then
    echo "Error: Migration name cannot be empty."
    exit 1
  fi

  local author_name=$(git config user.name)
  if [ -z "$author_name" ]; then
    author_name="Unknown Author"
  fi
  local creation_date=$(date +"%Y-%m-%d %H:%M:%S")

  local migration_folder="Server/Infrastructure/Migrations"
  local migration_file="V${timestamp_prefix}__${migration_name}.sql"
  mkdir -p "$migration_folder"
  local migration_file_path="${migration_folder}/${migration_file}"

  echo "-- Migration script: $migration_file" > "$migration_file_path"
  echo "-- Author: $author_name" >> "$migration_file_path"
  echo "-- Created on: $creation_date" >> "$migration_file_path"

  echo "Migration script created successfully: ${migration_file_path}"
}

main() {
  echo "Enter the migration name:"
  read -p "> " migration_name
  create_migration_script "$migration_name"
  echo "Script created!"
}
main
