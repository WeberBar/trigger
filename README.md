# trigger

## Exemplo 1
a)Com a criação do Trigger o gatilho garante que a coluna "DataPedido"seja automaticamente preenchida com a data e hora atuais toda vez que alguém insere um novo registro na tabela "Pedidos":

## Exemplo 2 
### APÓS A EXECUÇÃO DO PRIMEIRO CÓDIGO REALIZE O SEGUNDO EXEMPLO;

a)Criado a tabela filmes:

b)O gatilho "chk_minutos" é projetado para evitar que valores não válidos(ou seja, valores menores ou iguais a zero) sejam inseridos na coluna "minutos" da tabela "Filmes".Se um valor inválido for inserido,o gatilho redefine o valor como NULL. Isso ajuda a garantir a integridade dos dados na tabela conforme imagem ilustrada:
```sql
create trigger check_minutos before insert on filmes

-- O gatilho vai iterar por cada linha afetada pela inserção
for each row

-- Início do bloco do gatilho
begin
    -- Condição: Verificar se o valor da coluna "minutos" na nova linha ("new.minutos") é menor que 0
    if new.minutos < 0 then
        -- Se a condição for atendida, o gatilho será acionado
        -- Ele define o valor da coluna "minutos" como NULL
        set new.minutos = null;
    end if;
-- Fim do bloco do gatilho
end$

-- Restauração do Delimitador padrão
delimiter ;

```
### inserindo os dados
```sql
INSERT INTO Filmes (titulo, minutos) VALUES ("The terrible trigger", 120);
INSERT INTO Filmes (titulo, minutos) VALUES ("O alto da compadecida", 135);
INSERT INTO Filmes (titulo, minutos) VALUES ("Faroeste caboclo", 246);
INSERT INTO Filmes (titulo, minutos) VALUES ("The matrix", 90);
INSERT INTO Filmes (titulo, minutos) VALUES ("Blade runner", -88);
INSERT INTO Filmes (titulo, minutos) VALUES ("O labirinto do fauno", 110);
INSERT INTO Filmes (titulo, minutos) VALUES ("Metropole", 0);
INSERT INTO Filmes (titulo, minutos) VALUES ("A lista", 120);
```
![erro1](check_minutos.png)


