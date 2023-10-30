create database Trigger_ohata;
use Trigger_ohata;
CREATE TABLE Pedidos (
IDPedido INT AUTO_INCREMENT PRIMARY KEY,

DataPedido DATETIME,

NomeCliente VARCHAR(100)
);
-- Inserção de dados de exemplo
INSERT INTO Pedidos (DataPedido, NomeCliente) VALUES
(NOW(), 'João'),
(NOW(), 'Maria'),
(NOW(), 'Ricardo');

select * from pedidos;

-- **Declaração do gatilho**
DELIMITER $
CREATE TRIGGER RegistroDataCriacaoPedido
BEFORE INSERT ON Pedidos
FOR EACH ROW
BEGIN
-- **Comando SQL**
SET NEW. DataPedido = NOW();
END;
$
DELIMITER ;
-- **Comentários**

-- **Declaração do gatilho**
-- Define um gatilho chamado `RegistroDataCriacaoPedido` que será executado antes de cada inserção na tabela `Pedidos`.
-- O gatilho será executado para cada linha afetada pela inserção.

-- **Comando SQL**
-- Define o valor da coluna `DataPedido` da nova linha como a data e hora atual.


insert into pedidos (NomeCliente) values ('Analivia');

select * from pedidos;

create table Filmes(
id int primary key not null auto_increment,
titulo varchar(200),
minutos int
);

delimiter $
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

INSERT INTO Filmes (titulo, minutos) VALUES ("The terrible trigger", 120);
INSERT INTO Filmes (titulo, minutos) VALUES ("O alto da compadecida", 135);
INSERT INTO Filmes (titulo, minutos) VALUES ("Faroeste caboclo", 246);
INSERT INTO Filmes (titulo, minutos) VALUES ("The matrix", 90);
INSERT INTO Filmes (titulo, minutos) VALUES ("Blade runner", -88);
INSERT INTO Filmes (titulo, minutos) VALUES ("O labirinto do fauno", 110);
INSERT INTO Filmes (titulo, minutos) VALUES ("Metropole", 0);
INSERT INTO Filmes (titulo, minutos) VALUES ("A lista", 120);

-- Definição do Delimitador
DELIMITER $
-- Criação do Trigger que alem de mandar
CREATE TRIGGER chk_minutos BEFORE INSERT ON Filmes
FOR EACH ROW
BEGIN
    DECLARE custom_message VARCHAR(255);

    IF new.minutos <= 0 THEN
        -- Atribuir a mensagem de erro personalizada à variável
        SET custom_message = "O valor em miutos está invalido";

        -- Lançar um Erro com mensagem personalizada e código de erro
        SIGNAL SQLSTATE '22007' SET MESSAGE_TEXT = custom_message;
    END IF;
END$
-- Restauração do Delimitador Padrão
DELIMITER ;

insert into Filmes (titulo, minutos) values ('Vingadores: ultimato', 0);
select * from Filmes;

create table Log_deletions (
id int primary key not null auto_increment,
titulo varchar(60),
quando datetime,
quem varchar(40)
);

-- **Declaração do gatilho**
DELIMITER $
create trigger log_deletions after delete on Filmes
	for each row 
    begin
		-- **Comando SQL**
		insert into Log_deletions values (null, old.titulo, sysdate(), user());
	end$
DELIMITER ;


delete from Filmes where id = 2;
delete from Filmes where id = 3;

select * from Log_deletions;