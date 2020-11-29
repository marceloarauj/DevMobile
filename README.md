# FurniCommerce

POST https://furnicommerce.herokuapp.com/comprarMovel
Content-Type: application/json

{
    "uid":8,
    "venda_id": 11
}

POST https://furnicommerce.herokuapp.com/login
Content-Type: application/json

{
    "email":"adm@gmail.com",
    "senha":"adm"
}

POST https://furnicommerce.herokuapp.com/register
Content-Type: application/json

{
    "nome":"Administrador",
    "cpf":"300.300.300-30",
    "email":"adm@adm.com",
    "senha":"adm",
    "endereco":"Av. Teste do sul"
}

POST https://furnicommerce.herokuapp.com/vendaId
Content-Type: application/json

{
    "venda_id": 11
}

POST https://furnicommerce.herokuapp.com/venda
Content-Type: application/json

{   
    "uid":8,
    "movelId":2,
    "imagem":"base64"
}
POST https://furnicommerce.herokuapp.com/vendaUsuario
Content-Type: application/json

{
    "uid":8
}