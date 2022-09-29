-- estado
DROP SCHEMA IF EXISTS medcall;
CREATE SCHEMA medcall;
use medcall;

CREATE TABLE tbl_estado (
    id tinyint unsigned NOT NULL AUTO_INCREMENT,
    uf varchar(2) NOT NULL,
    nome varchar(20) NOT NULL,
    CONSTRAINT pk_estado PRIMARY KEY (id)

) ENGINE = INNODB;

INSERT INTO tbl_estado (uf, nome) VALUES
  ('AC','Acre')
, ('AL','Alagoas')
, ('AP','Amapá')
, ('AM','Amazonas')
, ('BA','Bahia')
, ('CE','Ceará')
, ('DF','Distrito Federal')
, ('ES','Espírito Santo')
, ('GO','Goiás')
, ('MA','Maranhão')
, ('MT','Mato Grosso')
, ('MS','Mato Grosso do Sul')
, ('MG','Minas Gerais')
, ('PA','Pará')
, ('PB','Paraíba')
, ('PR','Paraná')
, ('PE','Pernambuco')
, ('PI','Piauí')
, ('RN','Rio Grande do Norte')
, ('RS','Rio Grande do Sul')
, ('RJ','Rio de Janeiro')
, ('RO','Rondônia')
, ('RR','Roraima')
, ('SC','Santa Catarina')
, ('SP','São Paulo')
, ('SE','Sergipe')
, ('TO','Tocantins');

-- cidade
CREATE TABLE tbl_cidade (
    id smallint unsigned NOT NULL AUTO_INCREMENT,
    nome varchar(40) NOT NULL,
    id_estado tinyint unsigned NOT NULL,
    CONSTRAINT pk_cidade PRIMARY KEY (id)
) ENGINE = INNODB;
ALTER TABLE tbl_cidade ADD CONSTRAINT fk_cidade_estado FOREIGN KEY (id_estado) REFERENCES tbl_estado (id);

-- bairro
CREATE TABLE tbl_bairro(
    id int unsigned NOT NULL AUTO_INCREMENT,
    nome varchar(60) NOT NULL,
    id_cidade smallint unsigned NOT NULL,
    CONSTRAINT pk_bairro PRIMARY KEY (id)
) ENGINE = INNODB;
ALTER TABLE tbl_bairro ADD CONSTRAINT fk_bairro_cidade FOREIGN KEY (id_cidade) REFERENCES tbl_cidade (id);

-- logradouro
CREATE TABLE tbl_logradouro (
    id int unsigned NOT NULL AUTO_INCREMENT,
    cep varchar(8) NOT NULL,
    nome varchar(60) NOT NULL,
    numero smallint unsigned NOT NULL,
    complemento varchar(60),
    id_bairro int unsigned NOT NULL,
    CONSTRAINT pk_logradouro PRIMARY KEY (id)
) ENGINE = INNODB;

ALTER TABLE tbl_logradouro ADD CONSTRAINT fk_logradouro_bairro FOREIGN KEY (id_bairro) REFERENCES tbl_bairro (id);

-- usuario
CREATE TABLE tbl_usuario (
    id int unsigned NOT NULL AUTO_INCREMENT,
    email varchar(64) NOT NULL,
    username varchar(20) NOT NULL,
    password varchar(255) NOT NULL,
    remember_token varchar(100),
    status varchar(1) NOT NULL DEFAULT 'A' COMMENT '[A]tivo, [I]nativo',
    CONSTRAINT pk_usuario PRIMARY KEY (id)
) ENGINE = INNODB;

ALTER TABLE tbl_usuario ADD CONSTRAINT ck_usuario_status CHECK (status IN ('A', 'I'));
CREATE UNIQUE INDEX uk_usuario_username ON tbl_usuario (username);

-- tipo_pessoa
CREATE TABLE tbl_tipo_pessoa (
    id tinyint unsigned NOT NULL AUTO_INCREMENT,
    tipo varchar(30) NOT NULL,
    sigla varchar(2) NOT NULL,
    CONSTRAINT pk_tipo_pessoa PRIMARY KEY (id)
) ENGINE = INNODB;

INSERT INTO tbl_tipo_pessoa (tipo, sigla) VALUES
  ('Profissional Pessoa Jurídica', 'PJ')
, ('Profissional Pessoa Física', 'PF')
, ('Assistente', 'PA')
, ('Paciente', 'PP');

-- pessoa
CREATE TABLE tbl_pessoa (
    id int unsigned NOT NULL AUTO_INCREMENT,
    nome varchar(60) NOT NULL,
    id_tipo_pessoa tinyint unsigned NOT NULL,
    id_usuario int unsigned NOT NULL,
    CONSTRAINT pk_pessoa PRIMARY KEY (id)
) ENGINE = INNODB;

ALTER TABLE tbl_pessoa ADD CONSTRAINT fk_pessoa_tipo_pessoa FOREIGN KEY (id_tipo_pessoa) REFERENCES tbl_tipo_pessoa (id);
ALTER TABLE tbl_pessoa ADD CONSTRAINT fk_pessoa_usuario FOREIGN KEY (id_usuario) REFERENCES tbl_usuario (id);

-- pessoa juridica
CREATE TABLE tbl_pessoa_juridica (
    id int unsigned AUTO_INCREMENT,
    razao_social varchar(60) NOT NULL,
    nome_fantasia varchar(60) NOT NULL,
    cnpj varchar(14) NOT NULL,
    registro varchar(20) NOT NULL,
    id_pessoa int unsigned NOT NULL,
    id_logradouro int unsigned NOT NULL,
    CONSTRAINT pk_pessoa_juridica PRIMARY KEY (id)
) ENGINE = INNODB;

ALTER TABLE tbl_pessoa_juridica ADD CONSTRAINT fk_pessoa_juridica_pessoa FOREIGN KEY (id_pessoa) REFERENCES tbl_pessoa (id);
ALTER TABLE tbl_pessoa_juridica ADD CONSTRAINT fk_pessoa_juridica_logradouro FOREIGN KEY (id_logradouro) REFERENCES tbl_logradouro (id);

-- pessoa fisica
CREATE TABLE tbl_pessoa_fisica(
    id int unsigned NOT NULL AUTO_INCREMENT,
    cpf varchar(11) NOT NULL,
    rg varchar(12) NOT NULL,
    registro varchar(20) NOT NULL,
    id_pessoa int unsigned NOT NULL,
    id_logradouro int unsigned NOT NULL,
    CONSTRAINT pk_pessoa_fisica PRIMARY KEY (id)
) ENGINE = INNODB;

ALTER TABLE tbl_pessoa_fisica ADD CONSTRAINT fk_pessoa_fisica_pessoa FOREIGN KEY (id_pessoa) REFERENCES tbl_pessoa (id);
ALTER TABLE tbl_pessoa_fisica ADD CONSTRAINT fk_pessoa_fisica_logradouro FOREIGN KEY (id_logradouro) REFERENCES tbl_logradouro (id);

-- assistente
CREATE TABLE tbl_assistente (
    id int unsigned NOT NULL AUTO_INCREMENT,
    cpf varchar(11) NOT NULL,
    rg varchar(12) NOT NULL,
    id_pessoa int unsigned NOT NULL,
    id_profissional int unsigned NOT NULL,
    CONSTRAINT pk_assistente PRIMARY KEY (id)
) ENGINE = INNODB;

ALTER TABLE tbl_assistente ADD CONSTRAINT fk_assistente_pessoa FOREIGN KEY (id_pessoa) REFERENCES tbl_pessoa (id);
ALTER TABLE tbl_assistente ADD CONSTRAINT fk_assistente_profissional FOREIGN KEY (id_profissional) REFERENCES tbl_pessoa (id);

-- paciente
CREATE TABLE tbl_paciente (
    id int unsigned NOT NULL AUTO_INCREMENT,
    cpf varchar(11) NOT NULL,
    rg varchar(12) NOT NULL,
    deficiencia_auditiva varchar(1) NOT NULL DEFAULT 'N',
    dt_nascimento date NOT NULL,
    id_pessoa int unsigned NOT NULL,
    id_logradouro int unsigned NOT NULL,
    CONSTRAINT pk_paciente PRIMARY KEY (id)
) ENGINE = INNODB;
ALTER TABLE tbl_paciente ADD CONSTRAINT fk_paciente_pessoa FOREIGN KEY (id_pessoa) REFERENCES tbl_pessoa (id);
ALTER TABLE tbl_paciente ADD CONSTRAINT fk_paciente_logradouro FOREIGN KEY (id_logradouro) REFERENCES tbl_logradouro (id);
ALTER TABLE tbl_paciente ADD CONSTRAINT ck_paciente_deficiencia CHECK (deficiencia_auditiva in ('S', 'N'));

-- tipo_telefone
CREATE TABLE tbl_tipo_telefone (
    id tinyint unsigned NOT NULL AUTO_INCREMENT,
    tipo varchar(15) NOT NULL,
    CONSTRAINT pk_tipo_telefone PRIMARY KEY (id)
) ENGINE = INNODB;

INSERT INTO tbl_tipo_telefone (tipo) VALUES
  ('Residencial')
, ('Celular')
, ('Comercial')
, ('Recado');

-- telefone
CREATE TABLE tbl_telefone (
    id int unsigned NOT NULL AUTO_INCREMENT,
    ddd varchar(2) NOT NULL,
    numero varchar(9) NOT NULL,
    id_tipo_telefone tinyint unsigned NOT NULL,
    id_pessoa int unsigned NOT NULL,
CONSTRAINT pk_telefone PRIMARY KEY (id)
) ENGINE = INNODB;

ALTER TABLE tbl_telefone ADD CONSTRAINT fk_telefone_tipo_telefone FOREIGN KEY (id_tipo_telefone) REFERENCES tbl_tipo_telefone (id);
ALTER TABLE tbl_telefone ADD CONSTRAINT fk_telefone_pessoa FOREIGN KEY (id_pessoa) REFERENCES tbl_pessoa (id);

-- procedimento
CREATE TABLE tbl_procedimento (
    id smallint unsigned NOT NULL AUTO_INCREMENT,
    procedimento varchar(60) NOT NULL,
    CONSTRAINT pk_procedimento PRIMARY KEY (id)
) ENGINE = INNODB;

-- procedimento_pessoa
CREATE TABLE tbl_procedimento_pessoa (
    id int unsigned NOT NULL AUTO_INCREMENT,
    valor decimal(10,2) COMMENT 'Valor do procedimento se não for convenio',
    id_procedimento smallint unsigned NOT NULL,
    id_pessoa int unsigned NOT NULL,
    CONSTRAINT pk_procedimento_pessoa PRIMARY KEY (id)
) ENGINE = INNODB;
ALTER TABLE tbl_procedimento_pessoa ADD CONSTRAINT fk_procedimento_pessoa_procedimento FOREIGN KEY (id_procedimento) REFERENCES tbl_procedimento (id);
ALTER TABLE tbl_procedimento_pessoa ADD CONSTRAINT fk_procedimento_pessoa_pessoa FOREIGN KEY (id_pessoa) REFERENCES tbl_pessoa (id);

-- especialidade
CREATE TABLE tbl_especialidade (
    id smallint unsigned NOT NULL AUTO_INCREMENT,
    especialidade varchar(60) NOT NULL,
    CONSTRAINT pk_especialidade PRIMARY KEY (id)
) ENGINE = INNODB;

-- especialidade_pessoa
CREATE TABLE tbl_especialidade_pessoa (
    id int unsigned NOT NULL AUTO_INCREMENT,
    id_especialidade smallint unsigned NOT NULL,
    id_pessoa int unsigned NOT NULL,
    CONSTRAINT pk_especialidade_pessoa PRIMARY KEY (id)
) ENGINE = INNODB;
ALTER TABLE tbl_especialidade_pessoa ADD CONSTRAINT fk_especialidade_pessoa_especialidade FOREIGN KEY (id_especialidade) REFERENCES tbl_especialidade (id);
ALTER TABLE tbl_especialidade_pessoa ADD CONSTRAINT fk_especialidade_pessoa_pessoa FOREIGN KEY (id_pessoa) REFERENCES tbl_pessoa (id);

-- convenio
CREATE TABLE tbl_convenio (
    id smallint unsigned NOT NULL AUTO_INCREMENT,
    convenio varchar(60) NOT NULL,
    CONSTRAINT pk_convenio PRIMARY KEY (id)
) ENGINE = INNODB;

-- convenio_pessoa
CREATE TABLE tbl_convenio_pessoa (
    id int unsigned NOT NULL AUTO_INCREMENT,
    id_convenio smallint unsigned NOT NULL,
    id_pessoa int unsigned NOT NULL,
    CONSTRAINT pk_convenio_pessoa PRIMARY KEY (id)
) ENGINE = INNODB;
ALTER TABLE tbl_convenio_pessoa ADD CONSTRAINT fk_convenio_pessoa_convenio FOREIGN KEY (id_convenio) REFERENCES tbl_convenio (id);
ALTER TABLE tbl_convenio_pessoa ADD CONSTRAINT fk_convenio_pessoa_pessoa FOREIGN KEY (id_pessoa) REFERENCES tbl_pessoa (id);

-- dias_mes
CREATE TABLE tbl_dias_mes (
    id tinyint unsigned NOT NULL AUTO_INCREMENT,
    dia tinyint NOT NULL,
    CONSTRAINT pk_dias_mes PRIMARY KEY (id)
) ENGINE = INNODB;
INSERT INTO tbl_dias_mes (dia) VALUES
 (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),(21),(22),(23),(24),(25),(26),(27),(28),(29),(30),(31);

-- disponibilidade
CREATE TABLE tbl_disponibilidade (
    id int unsigned NOT NULL AUTO_INCREMENT,
    dia_semana smallint NOT NULL COMMENT 'Dia da semana de 1 a 7, começa Domingo',
    horario time NOT NULL,
    id_pessoa int unsigned NOT NULL,
    CONSTRAINT pk_disponibilidade PRIMARY KEY (id)
) ENGINE = INNODB;

ALTER TABLE tbl_disponibilidade ADD CONSTRAINT fk_disponibilidade_pessoa FOREIGN KEY (id_pessoa) REFERENCES tbl_pessoa (id);

-- agenda
CREATE TABLE tbl_agenda (
    id int unsigned NOT NULL AUTO_INCREMENT,
    data datetime NOT NULL,
    status tinyint unsigned NOT NULL DEFAULT 0 COMMENT '[0] Aguardando aprovação, [1] Aprovado, [2] Cancelado paciente, [3] Cancelado profissional',
    valor decimal(10,2) COMMENT 'Valor do procedimento se for particular',
    pagamento tinyint unsigned COMMENT 'Tipo se for particular, [1] Dinheiro, [2] Credito, [3] Debito',
    id_profissional int unsigned NOT NULL,
    id_paciente int unsigned NOT NULL,
    id_procedimento smallint unsigned NOT NULL,
    id_convenio smallint unsigned COMMENT 'FK do convenio se for o caso',
    CONSTRAINT pk_agenda PRIMARY KEY (id)
) ENGINE = INNODB;

ALTER TABLE tbl_agenda ADD CONSTRAINT fk_agenda_profissional FOREIGN KEY (id_profissional) REFERENCES tbl_pessoa (id);
ALTER TABLE tbl_agenda ADD CONSTRAINT fk_agenda_paciente FOREIGN KEY (id_paciente) REFERENCES tbl_pessoa (id);
ALTER TABLE tbl_agenda ADD CONSTRAINT fk_agenda_procedimento FOREIGN KEY (id_procedimento) REFERENCES tbl_procedimento (id);
ALTER TABLE tbl_agenda ADD CONSTRAINT fk_agenda_convenio FOREIGN KEY (id_convenio) REFERENCES tbl_convenio (id);
ALTER TABLE tbl_agenda ADD CONSTRAINT ck_agenda_status CHECK (status in (0,1,2,3));



