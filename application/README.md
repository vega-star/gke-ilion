# Teste Flowdrive para desenvolvedor: Sistema para entrada e saída de veiculos com base na sua categoria

## Como fazer testes locais com a aplicação

## 1. Clonar ou baixar o repositório via Download ZIP

Para clonar via comando bash

```sh
git clone https://github.com/KaysonN/parking-application.git
```

## 2. Criar um ambiente virtual instalando o que estiver no arquivo requirements.txt

```sh
cd parking-application
virtualenv -p python3.7.8 venv
source venv/bin/activate
pip install -r requirements.txt
```

## 3. Faça as migrações com

```sh
py manage.py makemigrations
py manage.py migrate
```

## Importante

Certifique-se foi criado um banco de dados PostgreSQL com as mesmas configurações definidas na settings.py.

Não esquecer de verificar qual porta o seu banco de dados está utilizando.

## 4. Rodar a aplicação

```sh
py manage.py runserver
```
