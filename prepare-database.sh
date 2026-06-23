#!/bin/bash

# Este script inicia o serviço do MySQL e restaura o banco de dados do projeto.

mysql_ping() {
        # Adicionado o sudo para garantir que o root consiga autenticar localmente
        sudo mysql --protocol=tcp --port=3306 --user=root --password=root -e "SELECT 1" &> /dev/null
}

mysql_start() {
        # Inicia o serviço nativo do sistema diretamente
        sudo /bin/systemctl start mysql.service
}

# Iniciando o serviço do MySQL
if ! mysql_ping; then
    echo -n "Starting MySQL..."
    mysql_start

    # Waiting MySQL to start
    while ! mysql_ping; do
        echo -n "."
        sleep 0.5 # Aumentei um pouco o sleep para não sobrecarregar o terminal
    done
    echo "Done!"
else
    echo "MySQL is running."
fi

# Criando o banco de dados
echo "Creating database schema..."
# Adicionado sudo aqui também para ler o schema como root
sudo mysql --protocol=tcp --port=3306 --user=root --password=root < src/main/java/resources/database.sql
