# README

## Sobre o Projeto

Este é um projeto de exercício do programa Quero Ser Dev 7 da Locaweb. O projeto consiste em um sistema de gerenciamento de galpões.


## API

### Galpões

#### Listar todos os galpões

**Requisiçao:**

```
GET /api/v1/warehouses
```
**Resposta:**

```
Status: 200 (OK)

[
  {
    "id": 1,
    "name": "Maceió",
    "code": "MCZ",
    "description": "Ótimo galpão numa linda cidade",
    "city": "Maceió",
    "state": "AL",
    "postal_code": "57050-000",
    "total_area": 10000,
    "useful_area": 8000
  },
  
  {
    "id": 2,
    "name": "JF",
    "code": "JFG",
    "description": "Lindo galpão",
    "address": "Av. Rio Branco",
    "city": "Juiz de Fora",
    "state": "MG",
    "zip_code": "36015-412",
    "total_area": 10000,
    "useful_area": 2500
  }
]
```
#### Criar um galpão

**Requisiçao:**

```
POST /api/v1/warehouses
```
**Resposta:**

```
Status: 201 (Criado)

[
  {
    "id": 1,
    "name": "Maceió",
    "code": "MCZ",
    "description": "Ótimo galpão numa linda cidade",
    "city": "Maceió",
    "state": "AL",
    "postal_code": "57050-000",
    "total_area": 10000,
    "useful_area": 8000
  }
]
```


