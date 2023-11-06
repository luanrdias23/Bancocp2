

--
-- Criar sequence para o funcionario
--
DROP SEQUENCE SQ_RHSTU_FUNC;

DROP TABLE t_rhstu_bairro CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_cidade CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_consulta CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_consulta_forma_pagto CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_contato_paciente CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_email_paciente CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_endereco_paciente CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_endereco_unidhosp CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_estado CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_forma_pagamento CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_funcionario CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_logradouro CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_medicamento CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_medico CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_motorista CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_paciente CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_paciente_plano_saude CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_plano_saude CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_prescricao_medica CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_telefone_paciente CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_tipo_contato CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_unid_hospitalar CASCADE CONSTRAINTS;

CREATE SEQUENCE SQ_RHSTU_FUNC START WITH 1;
-- Criando a tabela de Estados
CREATE TABLE t_rhstu_estado (
    id_estado    NUMBER(2) NOT NULL,
    sg_estado    CHAR(2) NOT NULL,
    nm_estado    VARCHAR2(30) NOT NULL,
    dt_cadastro  DATE NOT NULL,
    nm_usuario   VARCHAR2(30) NOT NULL
);

ALTER TABLE t_rhstu_estado ADD CONSTRAINT pk_rhstu_estado PRIMARY KEY ( id_estado );
-- Crie a tabela de Cidades
CREATE TABLE t_rhstu_cidade (
    id_cidade    NUMBER(8) NOT NULL,
    id_estado    NUMBER(2) NOT NULL,
    nm_cidade    VARCHAR2(29) NOT NULL,
    cd_ibge      NUMBER(8) NOT NULL,
    nr_ddd       NUMBER(3) NOT NULL,
    dt_cadastro  DATE NOT NULL,
    nm_usuario   VARCHAR2(29) NOT NULL
);
COMMENT ON COLUMN t_rhstu_cidade.id_cidade IS
    'Esta coluna ir? receber o codigo da cidade e seu conte?do ? obrigat?rio e ser? preenchido automaticamente pelo sistema.

';

COMMENT ON COLUMN t_rhstu_cidade.id_estado IS
    'Esta coluna ir? receber o codigo interno para garantir unicidade dos Estados do Brasil. Seu conte?do ? obrigat?rio e ?nico ser? preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN t_rhstu_cidade.nm_cidade IS
    'Esta coluna ir? receber o nome do Cidade pertencente ao Estado Brasileiro. O padr?o de armazenmento ?  InitCap e seu conte?do ? obrigat?rio. Essa tabela j? ser? preenchida pela ?rea respons?vel. Novas inse??es necessitam ser avaladas pelos gestores.';

COMMENT ON COLUMN t_rhstu_cidade.cd_ibge IS
    'Esta coluna ir? receber o c?digo do IBGE que fornece informa??es para gera??o da NFe.';

COMMENT ON COLUMN t_rhstu_cidade.nr_ddd IS
    'ESSE ATRIBUTO RECEBER? DADOS DO NUMERO DO DDD, SENDO OBRIGAT?RIO';

COMMENT ON COLUMN t_rhstu_cidade.dt_cadastro IS
    'esse atributo receber? informa??es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_cidade.nm_usuario IS
    'esse atributo receber? informa??es sobre o nome do usu?rio que realizou o cadastro na tabela, sendo obrigat?rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_cidade ADD CONSTRAINT pk_rhstu_cidade PRIMARY KEY ( id_cidade );
-- Crie a tabela de Bairros
CREATE TABLE t_rhstu_bairro (
    id_bairro       NUMBER(8) NOT NULL,
    id_cidade       NUMBER(8) NOT NULL,
    nm_bairro       VARCHAR2(45) NOT NULL,
    nm_zona_bairro  VARCHAR2(20) NOT NULL,
    dt_cadastro     DATE NOT NULL,
    nm_usuario      VARCHAR2(30) NOT NULL
);
ALTER TABLE t_rhstu_bairro
    ADD CONSTRAINT uk_t_pkd_bairro_zona CHECK ( nm_zona_bairro IN (
        'CENTRO',
        'ZONA LESTE',
        'ZONA NORTE',
        'ZONA OESTE',
        'ZONA SUL'
        
    ) );
COMMENT ON COLUMN t_rhstu_bairro.id_bairro IS
    'Esta coluna ir? receber o codigo interno para garantir o cadastro dos  Bairros da Cidade do Estado do Brasil. Seu conte?do ? obrigat?rio e ?nico ser? preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN t_rhstu_bairro.id_cidade IS
    'Esta coluna ir? receber o codigo da cidade e seu conte?do ? obrigat?rio e ser? preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN t_rhstu_bairro.nm_bairro IS
    'Esta coluna ir? receber o nome do Bairro  pertencente Cidade do Estado Brasileiro. O padr?o de armazenmento ?  InitCap e seu conte?do ? obrigat?rio. Essa tabela j? ser? preenchida pela ?rea respons?vel. Novas inse??es necessitam ser avaladas pelos gestores.';

COMMENT ON COLUMN t_rhstu_bairro.nm_zona_bairro IS
    'Esta coluna ir? receber a localiza??o da zona onde se encontra o bairro. Alguns exemplos: Zona Norte, Zona Sul, Zona Leste, Zona Oeste, Centro.';

COMMENT ON COLUMN t_rhstu_bairro.dt_cadastro IS
    'esse atributo receber? informa??es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_bairro.nm_usuario IS
    'esse atributo receber? informa??es sobre o nome do usu?rio que realizou o cadastro na tabela, sendo obrigat?rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_bairro ADD CONSTRAINT pk_rhstu_bairro PRIMARY KEY ( id_bairro );
-- Crie a tabela de Louugradouro
CREATE TABLE t_rhstu_logradouro (
    id_logradouro   NUMBER(10) NOT NULL,
    id_bairro       NUMBER(8) NOT NULL,
    nm_logradouro   VARCHAR2(100)NOT NULL,
    nr_cep          NUMBER(8) NOT NULL,
    nm_usuario      VARCHAR2(30) NOT NULL
);
ALTER TABLE t_rhstu_logradouro ADD CONSTRAINT pk_rhstu_logradouro PRIMARY KEY ( id_logradouro );
CREATE TABLE t_rhstu_consulta (
    id_unid_hospital  NUMBER(9) NOT NULL,
    id_consulta       NUMBER(10) NOT NULL,
    id_paciente       NUMBER(9) NOT NULL,
    id_func           NUMBER(10) NOT NULL,
    dt_hr_consulta    DATE NOT NULL,
    nr_consultorio    NUMBER(5) NOT NULL,
    dt_cadastro       DATE NOT NULL,
    nm_usuario        VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_rhstu_consulta.id_unid_hospital IS
    'Esse atributo ir? receber a chave prim?ria da Unidade Hospitalar. Esse n?mero ? sequencia e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_consulta.id_consulta IS
    'ESSE ATRIBUTO RECEBER? DADOS DO ID DA CONSULTA, SENDO GERADO SEQUENCIALMENTE';

COMMENT ON COLUMN t_rhstu_consulta.id_paciente IS
    'Esse atributo ir? receber a chave prim?ria do paciente. Esse n?mero ? sequencial e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_consulta.id_func IS
    'Esse atributo ir? receber a chave prim?ria do m?dico. Esse n?mero ? sequencial e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_consulta.dt_hr_consulta IS
    'ESSE ATRIBUTO RECEBER? DADOS SOBRE A DATA E HORA DA CONSULTA, SENDO OBRIGAT?RIO';

COMMENT ON COLUMN t_rhstu_consulta.nr_consultorio IS
    'ESSE ATRIBUTO RECEBER? DADOS SOBRE O NUMERO DO CONSULT?RIO EM QUE A CONSULTA SER? FEITA, SENDO OBRIGAT?RIO';

COMMENT ON COLUMN t_rhstu_consulta.dt_cadastro IS
    'esse atributo receber? informa??es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_consulta.nm_usuario IS
    'esse atributo receber? informa??es sobre o nome do usu?rio que realizou o cadastro na tabela, sendo obrigat?rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_consulta ADD CONSTRAINT pk_rhstu_consulta PRIMARY KEY ( id_consulta,
                                                                            id_unid_hospital );

CREATE TABLE t_rhstu_consulta_forma_pagto (
    id_consulta_forma_pagto  NUMBER(10) NOT NULL,
    id_unid_hospital         NUMBER(9) NOT NULL,
    id_consulta              NUMBER(10) NOT NULL,
    id_paciente_ps           NUMBER(10) NOT NULL,
    id_forma_pagto           NUMBER(9) NOT NULL,
    dt_pagto_consulta        DATE,
    st_pagto_consulta        CHAR(1) NOT NULL,
    dt_cadastro              DATE NOT NULL,
    nm_usuario               VARCHAR2(30) NOT NULL
);

ALTER TABLE t_rhstu_consulta_forma_pagto
    ADD CONSTRAINT uk_rhstu_status_pagto_paci CHECK ( st_pagto_consulta IN (
        'A',
        'C',
        'P'
    ) );

COMMENT ON COLUMN t_rhstu_consulta_forma_pagto.id_consulta_forma_pagto IS
    'ESSE ATRIBUTO RECEBER? DADOS SOBRE O ID DA CONSULTA DA FORMA DE PAGAMENTO, SENDO GERADO SEQUENCIALMENTE';

COMMENT ON COLUMN t_rhstu_consulta_forma_pagto.id_unid_hospital IS
    'Esse atributo ir? receber a chave prim?ria da Unidade Hospitalar. Esse n?mero ? sequencia e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_consulta_forma_pagto.id_consulta IS
    'ESSE ATRIBUTO RECEBER? DADOS DO ID DA CONSULTA, SENDO GERADO SEQUENCIALMENTE';

COMMENT ON COLUMN t_rhstu_consulta_forma_pagto.id_paciente_ps IS
    'Esse atributo ir? receber a chave prim?ria do plano de sa?de do paciente. Esse n?mero ? sequencial e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_consulta_forma_pagto.id_forma_pagto IS
    'Esse atributo ir? receber a chave prim?ria da forma de pagamento. Esse n?mero ? sequencial e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_consulta_forma_pagto.dt_pagto_consulta IS
    'ESSE ATRIBUTO RECEBER? INFORMA??ES SOBRE A DATA DE PAGAMENTO DA CONSULTA, SENDO OPCIONAL';

COMMENT ON COLUMN t_rhstu_consulta_forma_pagto.st_pagto_consulta IS
    'ESSE ATRIBUTO RECEBER? INFORMA??ES SOBRE O STATUS DO PAGAMENTO DA CONSULTA, SENDO OBRIGAT?RIO';

COMMENT ON COLUMN t_rhstu_consulta_forma_pagto.dt_cadastro IS
    'esse atributo receber? informa??es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_consulta_forma_pagto.nm_usuario IS
    'esse atributo receber? informa??es sobre o nome do usu?rio que realizou o cadastro na tabela, sendo obrigat?rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_consulta_forma_pagto ADD CONSTRAINT pk_rhstu_consulta_forma_pagto PRIMARY KEY ( id_consulta_forma_pagto );

CREATE TABLE t_rhstu_contato_paciente (
    id_paciente      NUMBER(9) NOT NULL,
    id_contato       NUMBER(9) NOT NULL,
    id_tipo_contato  NUMBER(5) NOT NULL,
    nm_contato       VARCHAR2(40) NOT NULL,
    nr_ddi           NUMBER(3),
    nr_ddd           NUMBER(3),
    nr_telefone      NUMBER(10),
    dt_cadastro      DATE NOT NULL,
    nm_usuario       VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_rhstu_contato_paciente.id_paciente IS
    'Esse atributo ir? receber a chave prim?ria do paciente. Esse n?mero ? sequencial e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_contato_paciente.id_contato IS
    'Esse atributo ir? receber a chave prim?ria do contato do paciente. Esse n?mero ? sequencial e inicia sempre com 1 a partir do id do paciente e ? gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_contato_paciente.id_tipo_contato IS
    'Esse atributo ir? receber a chave prim?ria do tipo do contato. Esse n?mero ? sequencial e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_contato_paciente.nm_contato IS
    'Este atributo ir? receber o nome do contato do paciente. Seu conteudo ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_contato_paciente.nr_ddi IS
    'Este atributo ir? receber o n?mero do DDI do telefone do contato do paciente. Seu conteudo ? opcional.';

COMMENT ON COLUMN t_rhstu_contato_paciente.nr_ddd IS
    'Este atributo ir? receber o n?mero do DDD  do telefone do contato do paciente. Seu conteudo ? opcional.';

COMMENT ON COLUMN t_rhstu_contato_paciente.nr_telefone IS
    'Este atributo ir? receber o n?mero do telefone do contato do paciente. Seu conteudo ? opcional.';

COMMENT ON COLUMN t_rhstu_contato_paciente.dt_cadastro IS
    'esse atributo receber? informa??es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_contato_paciente.nm_usuario IS
    'esse atributo receber? informa??es sobre o nome do usu?rio que realizou o cadastro na tabela, sendo obrigat?rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_contato_paciente ADD CONSTRAINT pk_rhstu_contato_emerg_pac PRIMARY KEY ( id_contato,
                                                                                             id_paciente );

CREATE TABLE t_rhstu_email_paciente (
    id_email     NUMBER(9) NOT NULL,
    id_paciente  NUMBER(9) NOT NULL,
    ds_email     VARCHAR2(100) NOT NULL,
    tp_email     VARCHAR2(20) NOT NULL,
    st_email     CHAR(1) NOT NULL,
    dt_cadastro  DATE NOT NULL,
    nm_usuario   VARCHAR2(30) NOT NULL
);

ALTER TABLE t_rhstu_email_paciente
    ADD CONSTRAINT uk_rhstu_paciente_st_email CHECK ( st_email IN (
        'A',
        'I'
    ) );

COMMENT ON COLUMN t_rhstu_email_paciente.id_email IS
    'Esse atributo ir? receber a chave prim?ria do email do paciente. Esse n?mero ? sequencial e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_email_paciente.id_paciente IS
    'Esse atributo ir? receber a chave prim?ria do paciente. Esse n?mero ? sequencial e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_email_paciente.ds_email IS
    'Esse atributo ir? receber o email do paciente.  Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_email_paciente.tp_email IS
    'Esse atributo ir? receber o tipo email do paciente.  Seu conte?do ? obrigat?rio e deve possuir os seguintes valores: Pessoal ou Profissional.';

COMMENT ON COLUMN t_rhstu_email_paciente.st_email IS
    'Esse atributo ir? receber o status do email do paciente.  Seu conte?do ? obrigat?rio e deve possuir os seguintes valores: (A)tivo ou (I)nativo.';

COMMENT ON COLUMN t_rhstu_email_paciente.dt_cadastro IS
    'esse atributo receber? informa??es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_email_paciente.nm_usuario IS
    'esse atributo receber? informa??es sobre o nome do usu?rio que realizou o cadastro na tabela, sendo obrigat?rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_email_paciente ADD CONSTRAINT pk_rhstu_email_paciente PRIMARY KEY ( id_email );

CREATE TABLE t_rhstu_endereco_paciente (
    id_endereco            NUMBER(9) NOT NULL,
    id_paciente            NUMBER(9) NOT NULL,
    id_logradouro          NUMBER(10) NOT NULL,
    nr_logradouro          NUMBER(7),
    ds_complemento_numero  VARCHAR2(30),
    ds_ponto_referencia    VARCHAR2(50),
    dt_inicio              DATE NOT NULL,
    dt_fim                 DATE,
    dt_cadastro            DATE NOT NULL,
    nm_usuario             VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_rhstu_endereco_paciente.id_endereco IS
    'Esse atributo ir? receber a chave prim?ria do endereco do paciente. Esse n?mero ? sequencia e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_endereco_paciente.id_paciente IS
    'Esse atributo ir? receber a chave prim?ria do paciente. Esse n?mero ? sequencial e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_endereco_paciente.id_logradouro IS
    'Esta coluna ir? receber o codigo interno para garantir o lograouro, que esta localizado no? cadastro dos? Bairros da Cidade do Estado do Brasil. Seu conte?do ? obrigat?rio e ?nico ser? preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN t_rhstu_endereco_paciente.nr_logradouro IS
    'Esse atributo ir? receber o n?mero do logradouro do endereco do paciente.  Seu conte?do ? opcional.';

COMMENT ON COLUMN t_rhstu_endereco_paciente.ds_complemento_numero IS
    'Esse atributo ir? receber o complemeneto  do logradouro do endereco do paciente caso ele exista. Seu conte?do ? opcional.';

COMMENT ON COLUMN t_rhstu_endereco_paciente.ds_ponto_referencia IS
    'Esse atributo ir? receber o ponto de refer?ncia  do logradouro do endereco do paciente.  Seu conte?do ? opcional.';

COMMENT ON COLUMN t_rhstu_endereco_paciente.dt_inicio IS
    'Esse atributo ir? receber a data inicio do paciente associado ao endere?o (logradouro). Seu conte?do ? obrigatorio.';

COMMENT ON COLUMN t_rhstu_endereco_paciente.dt_fim IS
    'Esse atributo ir? receber a data fim do paciente associado ao endere?o (logradouro), ou seja, ele n?o reside mais nesse endere?o.  Seu conte?do ? opcional.';

COMMENT ON COLUMN t_rhstu_endereco_paciente.dt_cadastro IS
    'esse atributo receber? informa??es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_endereco_paciente.nm_usuario IS
    'esse atributo receber? informa??es sobre o nome do usu?rio que realizou o cadastro na tabela, sendo obrigat?rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_endereco_paciente ADD CONSTRAINT pk_rhstu_endereco_paciente PRIMARY KEY ( id_endereco );

CREATE TABLE t_rhstu_endereco_unidhosp (
    id_end_unidhosp        NUMBER(9) NOT NULL,
    id_unid_hospital       NUMBER(9) NOT NULL,
    id_logradouro          NUMBER(10) NOT NULL,
    nr_logradouro          NUMBER(7),
    ds_complemento_numero  VARCHAR2(30),
    ds_ponto_referencia    VARCHAR2(50),
    dt_inicio              DATE NOT NULL,
    dt_fim                 DATE,
    dt_cadastro            DATE NOT NULL,
    nm_usuario             VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_rhstu_endereco_unidhosp.id_end_unidhosp IS
    'Esse atributo ir? receber a chave prim?ria do endereco da Unidade Hospitalar. Esse n?mero ? sequencia e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_endereco_unidhosp.nr_logradouro IS
    'Esse atributo ir? receber o n?mero do logradouro do endereco da Unidade Hospitalar.  Seu conte?do ? opcional.';

COMMENT ON COLUMN t_rhstu_endereco_unidhosp.ds_complemento_numero IS
    'Esse atributo ir? receber o complemeneto  do logradouro do endereco da Unidade hospitalar  caso ele exista. Seu conte?do ? opcional.';

COMMENT ON COLUMN t_rhstu_endereco_unidhosp.ds_ponto_referencia IS
    'Esse atributo ir? receber o ponto de refer?ncia  do logradouro do endereco da Unidade Hospitalar.  Seu conte?do ? opcional.
';

COMMENT ON COLUMN t_rhstu_endereco_unidhosp.dt_inicio IS
    'Esse atributo ir? receber a data inicio da Unidade Hospitalar  associado ao endere?o (logradouro). Seu conte?do ? obrigatorio.';

COMMENT ON COLUMN t_rhstu_endereco_unidhosp.dt_fim IS
    'Esse atributo ir? receber a data fim da Unidade Hospitalar associado ao endere?o (logradouro), ou seja, ele n?o reside mais nesse endere?o.  Seu conte?do ? opcional.';

COMMENT ON COLUMN t_rhstu_endereco_unidhosp.dt_cadastro IS
    'esse atributo receber? informa??es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_endereco_unidhosp.nm_usuario IS
    'esse atributo receber? informa??es sobre o nome do usu?rio que realizou o cadastro na tabela, sendo obrigat?rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_endereco_unidhosp ADD CONSTRAINT pk_rhstu_endereco_pacientev1 PRIMARY KEY ( id_end_unidhosp );
CREATE TABLE t_rhstu_forma_pagamento (
    id_forma_pagto  NUMBER(9) NOT NULL,
    nm_forma_pagto  VARCHAR2(60) NOT NULL,
    ds_forma_pagto  VARCHAR2(500),
    st_forma_pagto  CHAR(1) NOT NULL,
    dt_cadastro     DATE NOT NULL,
    nm_usuario      VARCHAR2(30) NOT NULL
);

ALTER TABLE t_rhstu_forma_pagamento
    ADD CONSTRAINT uk_rhstu_status_pagto CHECK ( st_forma_pagto IN (
        'A',
        'C',
        'P'
    ) );

COMMENT ON COLUMN t_rhstu_forma_pagamento.id_forma_pagto IS
    'Esse atributo ir? receber a chave prim?ria da forma de pagamento. Esse n?mero ? sequencial e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_forma_pagamento.nm_forma_pagto IS
    'Esse atributo ir? receber o nome da forma de pagamento. Seu conte?do ? obrigat?rio';

COMMENT ON COLUMN t_rhstu_forma_pagamento.ds_forma_pagto IS
    'Esse atributo ir? receber a descri??o da forma de pagamento. Seu conte?do n?o ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_forma_pagamento.st_forma_pagto IS
    'Esse atributo ir? receber o status da forma de pagamento. Seu conte?do ? obrigat?rio e deve possuir os seguintes valores: (A)tivo ou (I)nativo.';

COMMENT ON COLUMN t_rhstu_forma_pagamento.dt_cadastro IS
    'esse atributo receber? informa??es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_forma_pagamento.nm_usuario IS
    'esse atributo receber? informa??es sobre o nome do usu?rio que realizou o cadastro na tabela, sendo obrigat?rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_forma_pagamento ADD CONSTRAINT pk_rhstu_forma_pagto PRIMARY KEY ( id_forma_pagto );

CREATE TABLE t_rhstu_funcionario (
    id_func        NUMBER(10) NOT NULL,
    id_superior    NUMBER(10),
    nm_func        VARCHAR2(90) NOT NULL,
    ds_cargo       VARCHAR2(77) NOT NULL,
    dt_nascimento  DATE NOT NULL,
    vl_salario     NUMBER(10, 2),
    nr_rg          VARCHAR2(12) NOT NULL,
    nr_cpf         NUMBER(12) NOT NULL,
    st_func        VARCHAR2(50) DEFAULT 'A' NOT NULL,
    dt_cadastro    DATE NOT NULL,
    nm_usuario     VARCHAR2(30) NOT NULL
);

ALTER TABLE t_rhstu_funcionario
    ADD CHECK ( st_func IN (
        'A',
        'I'
    ) );

COMMENT ON COLUMN t_rhstu_funcionario.id_func IS
    'Esse atributo ir? receber a chave prim?ria do funcionario. Esse n?mero ? sequencial e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_funcionario.id_superior IS
    'Esse atributo ir? receber a chave prim?ria do SUPERIOR DO funcionario (GESTOR). Esse n?mero ? sequencial e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_funcionario.nm_func IS
    'Esse atributo ir? receber o nome completo do funcionario.? Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_funcionario.ds_cargo IS
    'Este atributo deve receber a  descri??o do cargo do funcion?rio.';

COMMENT ON COLUMN t_rhstu_funcionario.dt_nascimento IS
    'esse atributo receber? informa??es sobre a data de cadastro do funcionario, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_funcionario.vl_salario IS
    'esse atributo receber? informa??es sobre o valor do salario  do funcionario, sendo obrigatorio';

COMMENT ON COLUMN t_rhstu_funcionario.nr_rg IS
    'esse atributo receber? informa??es sobre o NUMERO DO RG do funcionario, sendo obrigatorio';

COMMENT ON COLUMN t_rhstu_funcionario.nr_cpf IS
    'esse atributo receber? informa??es sobre o NUMERO DO CPF  do funcionario, sendo obrigatorio';

COMMENT ON COLUMN t_rhstu_funcionario.st_func IS
    'ESSE ATRIBUTO RECEBER? CONTEUDO SOBRE O STATUS DO FUNCIONARIO, PODENDO SER (A)tivo e (I)nativo.';

COMMENT ON COLUMN t_rhstu_funcionario.dt_cadastro IS
    'esse atributo receber? informa??es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_funcionario.nm_usuario IS
    'esse atributo receber? informa??es sobre o nome do usu?rio que realizou o cadastro na tabela, sendo obrigat?rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_funcionario ADD CONSTRAINT pk_rhstu_func PRIMARY KEY ( id_func );
CREATE TABLE t_rhstu_medicamento (
    id_medicamento            NUMBER(9) NOT NULL,
    nm_medicamento            VARCHAR2(50) NOT NULL,
    ds_detalhada_medicamento  VARCHAR2(4000),
    nr_codigo_barras          NUMBER NOT NULL,
    dt_cadastro               DATE NOT NULL,
    nm_usuario                VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_rhstu_medicamento.id_medicamento IS
    'ESSE ATRIBUTO RECEBER? O ID DO MEDICAMENTO, SENDO GERADO SEQUENCIALMENTE';

COMMENT ON COLUMN t_rhstu_medicamento.nm_medicamento IS
    'ESSE ATRIBUTO RECEBER? DADOS SOBRE O NOME DO MEDICAMENTO, SENDO OBRIGAT?RIO NA TABELA';

COMMENT ON COLUMN t_rhstu_medicamento.ds_detalhada_medicamento IS
    'Esse atributo ir? receber a descri??o detalhada do medicamento. Seu conte?do ? opcional.';

COMMENT ON COLUMN t_rhstu_medicamento.nr_codigo_barras IS
    'Esse atributo ir? receber o n?mero do c?digo de barras do medicamento, seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_medicamento.dt_cadastro IS
    'esse atributo receber? informa??es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_medicamento.nm_usuario IS
    'esse atributo receber? informa??es sobre o nome do usu?rio que realizou o cadastro na tabela, sendo obrigat?rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_medicamento ADD CONSTRAINT pk_rhstu_medicamento PRIMARY KEY ( id_medicamento );

CREATE TABLE t_rhstu_medico (
    id_func           NUMBER(10) NOT NULL,
    nr_crm            NUMBER(10) NOT NULL,
    ds_especialidade  VARCHAR2(50) NOT NULL,
    dt_cadastro       DATE NOT NULL,
    nm_usuario        VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_rhstu_medico.nr_crm IS
    'Esse atributo ir? receber o n?mero do CRM do m?dico. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_medico.ds_especialidade IS
    'Esse atributo ir? receber a especialidade do m?dico. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_medico.dt_cadastro IS
    'esse atributo receber? informa??es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_medico.nm_usuario IS
    'esse atributo receber? informa??es sobre o nome do usu?rio que realizou o cadastro na tabela, sendo obrigat?rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_medico ADD CONSTRAINT pk_rhstu_medico PRIMARY KEY ( id_func );

CREATE TABLE t_rhstu_motorista (
    id_func           NUMBER(10) NOT NULL,
    nr_cnh            NUMBER(14) NOT NULL,
    nm_categoria_cnh  VARCHAR2(70) NOT NULL,
    dt_validade_cnh   DATE NOT NULL,
    dt_cadastro       DATE NOT NULL,
    nm_usuario        VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_rhstu_motorista.nr_cnh IS
    'Esse atributo ir? receber o n?mero da CNH  do motorista. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_motorista.dt_validade_cnh IS
    'Esse atributo ir? receber a especialidade do m?dico. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_motorista.dt_cadastro IS
    'esse atributo receber? informa??es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_motorista.nm_usuario IS
    'esse atributo receber? informa??es sobre o nome do usu?rio que realizou o cadastro na tabela, sendo obrigat?rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_motorista ADD CONSTRAINT pk_rhstu_motorista PRIMARY KEY ( id_func );

CREATE TABLE t_rhstu_paciente (
    id_paciente         NUMBER(9) NOT NULL,
    nm_paciente         VARCHAR2(80) NOT NULL,
    nr_cpf              NUMBER(12) NOT NULL,
    nm_rg               VARCHAR2(15),
    dt_nascimento       DATE NOT NULL,
    fl_sexo_biologico   CHAR(1) NOT NULL,
    ds_escolaridade     VARCHAR2(40) NOT NULL,
    ds_estado_civil     VARCHAR2(25) NOT NULL,
    nm_grupo_sanguineo  VARCHAR2(6) NOT NULL,
    nr_altura           NUMBER(3, 2) DEFAULT 0.1 NOT NULL,
    nr_peso             NUMBER(4, 1) NOT NULL,
    dt_cadastro         DATE NOT NULL,
    nm_usuario          VARCHAR2(30) NOT NULL
);

ALTER TABLE t_rhstu_paciente
    ADD CONSTRAINT uk_rhstu_paciente_sexobio CHECK ( fl_sexo_biologico IN (
        'F',
        'I',
        'M'
    ) );

ALTER TABLE t_rhstu_paciente
    ADD CONSTRAINT ck_rhstu_altura_paciente CHECK ( nr_altura BETWEEN 0.1 AND 2.99 );

ALTER TABLE t_rhstu_paciente
    ADD CONSTRAINT uk_rhstu_paciente_peso CHECK ( nr_peso BETWEEN 1 AND 800 );

COMMENT ON COLUMN t_rhstu_paciente.id_paciente IS
    'Esse atributo ir? receber a chave prim?ria do paciente. Esse n?mero ? sequencial e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_paciente.nm_paciente IS
    'Esse atributo ir? receber o nome completo do  paciente.  Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_paciente.nr_cpf IS
    'Esse atributo ir? receber o n?mero do  CPF paciente.  Seu conte?do ? obrigat?rio e ser? validado de acordo com regras de neg?cio.';

COMMENT ON COLUMN t_rhstu_paciente.nm_rg IS
    'Esse atributo ir? receber o n?mero do  RG  paciente.  Seu conte?do ? obrigat?rio e ser? validado de acordo com regras de neg?cio.';

COMMENT ON COLUMN t_rhstu_paciente.dt_nascimento IS
    'Esse atributo ir? receber a data de nascimento do  paciente.  Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_paciente.fl_sexo_biologico IS
    'Esse atributo ir? receber a flag do sexo biol?gico de nascimento do Paciente. Os valores poss?veis s?o (F)emea  ou (M)acho ou (I)ntersexual. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_paciente.ds_escolaridade IS
    'Esse atributo ir? receber a Escolaridade do  paciente.  Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_paciente.ds_estado_civil IS
    'Esse atributo ir? receber o Estado Civil  do  paciente.  Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_paciente.nm_grupo_sanguineo IS
    'Esse atributo ir? receber o grupo sanguineo do  paciente.  Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_paciente.nr_altura IS
    'Esse atributo ir? receber a altura do  paciente.  Seu conte?do ? obrigat?rio e o limite de altura deve ficar entre 0.1 e 2.99.';

COMMENT ON COLUMN t_rhstu_paciente.nr_peso IS
    'Esse atributo ir? receber o peso  do  paciente.  Seu conte?do ? obrigat?rio. A faixa de valores permitidos est? entre 1 e 800kg.';

COMMENT ON COLUMN t_rhstu_paciente.dt_cadastro IS
    'esse atributo receber? informa??es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_paciente.nm_usuario IS
    'esse atributo receber? informa??es sobre o nome do usu?rio que realizou o cadastro na tabela, sendo obrigat?rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_paciente ADD CONSTRAINT pk_rhstu_paciente PRIMARY KEY ( id_paciente );

ALTER TABLE t_rhstu_paciente ADD CONSTRAINT uk_rhstu_cpf_paciente UNIQUE ( nr_cpf );

ALTER TABLE t_rhstu_paciente ADD CONSTRAINT uk_rhstu_rg_paciente UNIQUE ( nm_rg );

CREATE TABLE t_rhstu_paciente_plano_saude (
    id_paciente_ps  NUMBER(10) NOT NULL,
    id_paciente     NUMBER(9) NOT NULL,
    id_plano_saude  NUMBER(5) NOT NULL,
    nr_carteira_ps  NUMBER(15),
    dt_inicio       DATE NOT NULL,
    dt_fim          DATE,
    dt_cadastro     DATE NOT NULL,
    nm_usuario      VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.id_paciente_ps IS
    'Esse atributo ir? receber a chave prim?ria do plano de sa?de do paciente. Esse n?mero ? sequencial e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.id_paciente IS
    'Esse atributo ir? receber a chave prim?ria do paciente. Esse n?mero ? sequencial e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.id_plano_saude IS
    'Esse atributo ir? receber a chave prim?ria do plano de sa?de. Esse n?mero ? sequencial e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.nr_carteira_ps IS
    'ESSE ATRIBUTO RECEBER? O NUMERO DA CARTEIRA DE CADA PACIENTE DO PLANO DE SA?DE';

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.dt_inicio IS
    'Esse atributo ir? receber a data de in?cio para atendimento do plano de sa?de do cliente aceito na RHSTU. Seu conte?do ? opcional.';

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.dt_fim IS
    'Esse atributo ir? receber a data de encerramento do plano de sa?de aceito na RHSTU. Seu conte?do ? opcional.';

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.dt_cadastro IS
    'esse atributo receber? informa??es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.nm_usuario IS
    'esse atributo receber? informa??es sobre o nome do usu?rio que realizou o cadastro na tabela, sendo obrigat?rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_paciente_plano_saude ADD CONSTRAINT pk_rhstu_pac_plano_saude PRIMARY KEY ( id_paciente_ps );

CREATE TABLE t_rhstu_plano_saude (
    id_plano_saude           NUMBER(5) NOT NULL,
    ds_razao_social          VARCHAR2(70) NOT NULL,
    nm_fantasia_plano_saude  VARCHAR2(80),
    ds_plano_saude           VARCHAR2(100) NOT NULL,
    nr_cnpj                  NUMBER(14) NOT NULL,
    nm_contato               VARCHAR2(30),
    ds_telefone              VARCHAR2(30),
    dt_inicio                DATE NOT NULL,
    dt_fim                   DATE,
    dt_cadastro              DATE NOT NULL,
    nm_usuario               VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_rhstu_plano_saude.id_plano_saude IS
    'Esse atributo ir? receber a chave prim?ria do plano de sa?de. Esse n?mero ? sequencial e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_plano_saude.ds_razao_social IS
    'Esse atributo ir? receber Raz?o Social do plano de sa?de aceito na RHSTU. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_plano_saude.nm_fantasia_plano_saude IS
    'Esse atributo ir? receber o nome Fantasia do plano de sa?de aceito na RHSTU. Seu conte?do ? opcional.';

COMMENT ON COLUMN t_rhstu_plano_saude.ds_plano_saude IS
    'Esse atributo ir? receber a descri??o do  plano de sa?de aceito na RHSTU. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_plano_saude.nr_cnpj IS
    'Esse atributo ir? receber o numero do CNPJ do plano de sa?de aceito na RHSTU. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_plano_saude.nm_contato IS
    'Esse atributo ir? receber o nome  do contato dentro do plano de sa?de aceito na RHSTU. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_plano_saude.ds_telefone IS
    'Esse atributo ir? receber os dados do telefone para contato no plano de sa?de aceito na RHSTU. Seu conte?do ? opcional.';

COMMENT ON COLUMN t_rhstu_plano_saude.dt_inicio IS
    'Esse atributo ir? receber a data de in?cio para atendimento do plano de sa?de aceito na RHSTU. Seu conte?do ? opcional.';

COMMENT ON COLUMN t_rhstu_plano_saude.dt_fim IS
    'Esse atributo ir? receber a data de encerramento do plano de sa?de aceito na RHSTU. Seu conte?do ? opcional.';

COMMENT ON COLUMN t_rhstu_plano_saude.dt_cadastro IS
    'esse atributo receber? informa??es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_plano_saude.nm_usuario IS
    'esse atributo receber? informa??es sobre o nome do usu?rio que realizou o cadastro na tabela, sendo obrigat?rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_plano_saude ADD CONSTRAINT pk_rhstu_plano_saude PRIMARY KEY ( id_plano_saude );

CREATE TABLE t_rhstu_prescricao_medica (
    id_prescricao_medica  NUMBER(10) NOT NULL,
    id_unid_hospital      NUMBER(9) NOT NULL,
    id_consulta           NUMBER(10) NOT NULL,
    id_medicamento        NUMBER(9) NOT NULL,
    ds_posologia          VARCHAR2(150) NOT NULL,
    ds_via                VARCHAR2(40) NOT NULL,
    ds_observacao_uso     VARCHAR2(100),
    qt_medicamento        NUMBER(10, 4),
    nm_usuario            VARCHAR2(30) NOT NULL,
    dt_cadastro           DATE NOT NULL
);

COMMENT ON COLUMN t_rhstu_prescricao_medica.id_prescricao_medica IS
    'Esse atributo ir? receber a chave prim?ria da prescri??o m?dica. Esse n?mero ? sequencial e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_prescricao_medica.id_unid_hospital IS
    'Esse atributo ir? receber a chave prim?ria da unidade hospitalar. Esse n?mero ? sequencial e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio. Trata-se de uma chave prim?ria herdada da tabela consulta.';

COMMENT ON COLUMN t_rhstu_prescricao_medica.id_consulta IS
    'Esse atributo ir? receber o n?mero da consulta do paciente.  Seu conte?do ? obrigat?rio e ser? validado de acordo com regras de neg?cio. Trata-se de uma chave prim?ria herdada da tabela consulta. ';

COMMENT ON COLUMN t_rhstu_prescricao_medica.id_medicamento IS
    'Esse atributo ir? receber a chave prim?ria do medicamento. Esse n?mero ? sequencial e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_prescricao_medica.ds_posologia IS
    'Esse atributo ir? receber a descri??o da posologia. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_prescricao_medica.ds_via IS
    'Esse atributo ir? receber a descri??o das vias de administra??o de medicamentos. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_prescricao_medica.ds_observacao_uso IS
    'Esse atributo receber? a descri??o das observa??es de uso. Seu conte?do ? opcional.';

COMMENT ON COLUMN t_rhstu_prescricao_medica.qt_medicamento IS
    'Este atributo receber? as especifica??es da quantidade de medicamento. Seu conte?do ? opcional';

COMMENT ON COLUMN t_rhstu_prescricao_medica.nm_usuario IS
    'esse atributo receber? informa??es sobre o nome do usu?rio que realizou o cadastro na tabela, sendo obrigat?rio, contendo 30 caracteres';

COMMENT ON COLUMN t_rhstu_prescricao_medica.dt_cadastro IS
    'esse atributo receber? informa??es sobre a data de cadastro da tabela, sendo obrigatorio
';

ALTER TABLE t_rhstu_prescricao_medica ADD CONSTRAINT pk_rhstu_prescricao_medica PRIMARY KEY ( id_prescricao_medica );

CREATE TABLE t_rhstu_telefone_paciente (
    id_paciente  NUMBER(9) NOT NULL,
    id_telefone  NUMBER(9) NOT NULL,
    nr_ddi       NUMBER(3) NOT NULL,
    nr_ddd       NUMBER(3) NOT NULL,
    nr_telefone  NUMBER(10) NOT NULL,
    tp_telefone  VARCHAR2(20) DEFAULT 'CELULAR' NOT NULL,
    st_telefone  CHAR(1) NOT NULL,
    dt_cadastro  DATE NOT NULL,
    nm_usuario   VARCHAR2(30) NOT NULL
);

ALTER TABLE t_rhstu_telefone_paciente
    ADD CHECK ( tp_telefone IN (
        'CELULAR',
        'COMERCIAL',
        'CONTATO OU RECADO',
        'RESIDENCIAL'
    ) );

ALTER TABLE t_rhstu_telefone_paciente
    ADD CONSTRAINT ck_rhstu_st_tel_pac CHECK ( st_telefone IN (
        'A',
        'I'
    ) );

COMMENT ON COLUMN t_rhstu_telefone_paciente.id_paciente IS
    'Esse atributo ir? receber a chave prim?ria do paciente. Esse n?mero ? sequencial e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_telefone_paciente.id_telefone IS
    'Esse atributo ir? receber a chave prim?ria do telefone do paciente. Esse n?mero ? sequencial iniciando com 1 a partir do id do paciente e ?  gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_telefone_paciente.nr_ddi IS
    'Este atributo ir? receber o n?mero do DDI do telefone do  paciente. Seu conteudo ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_telefone_paciente.nr_ddd IS
    'Esse atributo ir? receber o n?mero do DDD do telefone paciente.  Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_telefone_paciente.nr_telefone IS
    'Esse atributo ir? receber o n?mero do telefone do  DDD do telefone paciente.  Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_telefone_paciente.tp_telefone IS
    'Esse atributo ir? receber o tipo do  telefone  do telefone paciente.  Seu conte?do ? obrigat?rio e os valores possiveis s?o: Comercial, Residencial, Recado e Celular';

COMMENT ON COLUMN t_rhstu_telefone_paciente.st_telefone IS
    'Esse atributo ir? receber o status do telefone do paciente.  Seu conte?do ? obrigat?rio e deve possuir os seguintes valores: (A)tivo ou (I)nativo.';

COMMENT ON COLUMN t_rhstu_telefone_paciente.dt_cadastro IS
    'esse atributo receber? informa??es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_telefone_paciente.nm_usuario IS
    'esse atributo receber? informa??es sobre o nome do usu?rio que realizou o cadastro na tabela, sendo obrigat?rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_telefone_paciente ADD CONSTRAINT pk_rhstu_telefone_paciente PRIMARY KEY ( id_telefone,
                                                                                              id_paciente );

CREATE TABLE t_rhstu_tipo_contato (
    id_tipo_contato  NUMBER(5) NOT NULL,
    nm_tipo_contato  VARCHAR2(80) NOT NULL,
    dt_inicio        DATE NOT NULL,
    dt_fim           DATE,
    dt_cadastro      DATE NOT NULL,
    nm_usuario       VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_rhstu_tipo_contato.id_tipo_contato IS
    'Esse atributo ir? receber a chave prim?ria do tipo do contato. Esse n?mero ? sequencial e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_tipo_contato.nm_tipo_contato IS
    'Este atributo ir?  receber o nome  do tipo de contato (M?e, Pai, Prima(o), Irm?(o), Amiga(o), Colega de trabalho) entre outros. Seu conteudo ? obrigat?rio.
';

COMMENT ON COLUMN t_rhstu_tipo_contato.dt_inicio IS
    'Este atributo ir?  receber a data de in?cio de validade do tipo do contato. Seu conteudo ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_tipo_contato.dt_fim IS
    'Este atributo ir?  receber a data de t?rmino  de validade do tipo do contato. Seu conteudo ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_tipo_contato.dt_cadastro IS
    'esse atributo receber? informa??es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_tipo_contato.nm_usuario IS
    'esse atributo receber? informa??es sobre o nome do usu?rio que realizou o cadastro na tabela, sendo obrigat?rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_tipo_contato ADD CONSTRAINT pk_rhstu_tipo_contato PRIMARY KEY ( id_tipo_contato );

CREATE TABLE t_rhstu_unid_hospitalar (
    id_unid_hospital           NUMBER(9) NOT NULL,
    nm_unid_hospitalar         VARCHAR2(80) NOT NULL,
    nm_razao_social_unid_hosp  VARCHAR2(80) NOT NULL,
    dt_fundacao                DATE,
    nr_logradouro              NUMBER(7),
    ds_complemento_numero      VARCHAR2(30),
    ds_ponto_referencia        VARCHAR2(50),
    dt_inicio                  DATE NOT NULL,
    dt_termino                 DATE,
    dt_cadastro                DATE NOT NULL,
    nm_usuario                 VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_rhstu_unid_hospitalar.id_unid_hospital IS
    'Esse atributo ir? receber a chave prim?ria da Unidade Hospitalar. Esse n?mero ? sequencia e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_unid_hospitalar.nm_unid_hospitalar IS
    'Esse atributo ir? receber o nome da unidade hospitalar. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_unid_hospitalar.nm_razao_social_unid_hosp IS
    'Esse atributo ir? receber a raz?o social da unidade hospitalar. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_unid_hospitalar.dt_fundacao IS
    'Esse atributo ir? receber a data de funda??o da unidade hospitalar. Seu conte?do ? opcional.';

COMMENT ON COLUMN t_rhstu_unid_hospitalar.nr_logradouro IS
    'Esse atributo ir? receber o n?mero do logradouro do endereco da Unidade Hospitalar.  Seu conte?do ? opcional.';

COMMENT ON COLUMN t_rhstu_unid_hospitalar.ds_complemento_numero IS
    'Esse atributo ir? receber o complemeneto  do logradouro do endereco da Unidade Hospitalar caso ele exista. Seu conte?do ? opcional.';

COMMENT ON COLUMN t_rhstu_unid_hospitalar.ds_ponto_referencia IS
    'Esse atributo ir? receber o ponto de refer?ncia? do logradouro do endereco da unidade hospitalar.? Seu conte?do ? opcional.';

COMMENT ON COLUMN t_rhstu_unid_hospitalar.dt_inicio IS
    'Esse atributo ir? receber a data inicio do endere?o da Unidade Hospitalar associado ao endere?o (logradouro). Seu conte?do ? obrigatorio.';

COMMENT ON COLUMN t_rhstu_unid_hospitalar.dt_termino IS
    'Esse atributo ir? receber a data t?rmino  do endere?o da Unidade Hospitalar associado ao endere?o (logradouro). Seu conte?do ? opcional.';

COMMENT ON COLUMN t_rhstu_unid_hospitalar.dt_cadastro IS
    'esse atributo receber? informa??es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_unid_hospitalar.nm_usuario IS
    'esse atributo receber? informa??es sobre o nome do usu?rio que realizou o cadastro na tabela, sendo obrigat?rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_unid_hospitalar ADD CONSTRAINT pk_rhstu_uni_hosp_end PRIMARY KEY ( id_unid_hospital );

ALTER TABLE t_rhstu_logradouro
    ADD CONSTRAINT fk_rhstu_bairro_logradouro FOREIGN KEY ( id_bairro )
        REFERENCES t_rhstu_bairro ( id_bairro );

ALTER TABLE t_rhstu_bairro
    ADD CONSTRAINT fk_rhstu_cidade_bairro FOREIGN KEY ( id_cidade )
        REFERENCES t_rhstu_cidade ( id_cidade );

ALTER TABLE t_rhstu_consulta_forma_pagto
    ADD CONSTRAINT fk_rhstu_consulta_forma_pagto FOREIGN KEY ( id_consulta,
                                                               id_unid_hospital )
        REFERENCES t_rhstu_consulta ( id_consulta,
                                      id_unid_hospital );

ALTER TABLE t_rhstu_prescricao_medica
    ADD CONSTRAINT fk_rhstu_consulta_presc_medica FOREIGN KEY ( id_consulta,
                                                                id_unid_hospital )
        REFERENCES t_rhstu_consulta ( id_consulta,
                                      id_unid_hospital );

ALTER TABLE t_rhstu_cidade
    ADD CONSTRAINT fk_rhstu_estado_cidade FOREIGN KEY ( id_estado )
        REFERENCES t_rhstu_estado ( id_estado );

ALTER TABLE t_rhstu_consulta_forma_pagto
    ADD CONSTRAINT fk_rhstu_forma_pagto_consult FOREIGN KEY ( id_forma_pagto )
        REFERENCES t_rhstu_forma_pagamento ( id_forma_pagto );

ALTER TABLE t_rhstu_medico
    ADD CONSTRAINT fk_rhstu_func_medico FOREIGN KEY ( id_func )
        REFERENCES t_rhstu_funcionario ( id_func );

ALTER TABLE t_rhstu_motorista
    ADD CONSTRAINT fk_rhstu_func_motorista FOREIGN KEY ( id_func )
        REFERENCES t_rhstu_funcionario ( id_func );

ALTER TABLE t_rhstu_funcionario
    ADD CONSTRAINT fk_rhstu_func_superior FOREIGN KEY ( id_superior )
        REFERENCES t_rhstu_funcionario ( id_func );

ALTER TABLE t_rhstu_endereco_paciente
    ADD CONSTRAINT fk_rhstu_logr_end FOREIGN KEY ( id_logradouro )
        REFERENCES t_rhstu_logradouro ( id_logradouro );

ALTER TABLE t_rhstu_endereco_unidhosp
    ADD CONSTRAINT fk_rhstu_logr_unidhosp_end FOREIGN KEY ( id_logradouro )
        REFERENCES t_rhstu_logradouro ( id_logradouro );

ALTER TABLE t_rhstu_consulta
    ADD CONSTRAINT fk_rhstu_med_consulta FOREIGN KEY ( id_func )
        REFERENCES t_rhstu_funcionario ( id_func );

ALTER TABLE t_rhstu_prescricao_medica
    ADD CONSTRAINT fk_rhstu_medicamento_pm FOREIGN KEY ( id_medicamento )
        REFERENCES t_rhstu_medicamento ( id_medicamento );

ALTER TABLE t_rhstu_consulta
    ADD CONSTRAINT fk_rhstu_pac_consulta FOREIGN KEY ( id_paciente )
        REFERENCES t_rhstu_paciente ( id_paciente );

ALTER TABLE t_rhstu_contato_paciente
    ADD CONSTRAINT fk_rhstu_pac_cont FOREIGN KEY ( id_paciente )
        REFERENCES t_rhstu_paciente ( id_paciente );

ALTER TABLE t_rhstu_consulta_forma_pagto
    ADD CONSTRAINT fk_rhstu_pac_plano_pagto FOREIGN KEY ( id_paciente_ps )
        REFERENCES t_rhstu_paciente_plano_saude ( id_paciente_ps );

ALTER TABLE t_rhstu_email_paciente
    ADD CONSTRAINT fk_rhstu_paciente_email FOREIGN KEY ( id_paciente )
        REFERENCES t_rhstu_paciente ( id_paciente );

ALTER TABLE t_rhstu_endereco_paciente
    ADD CONSTRAINT fk_rhstu_paciente_endereco FOREIGN KEY ( id_paciente )
        REFERENCES t_rhstu_paciente ( id_paciente );

ALTER TABLE t_rhstu_paciente_plano_saude
    ADD CONSTRAINT fk_rhstu_paciente_plano FOREIGN KEY ( id_paciente )
        REFERENCES t_rhstu_paciente ( id_paciente );

ALTER TABLE t_rhstu_telefone_paciente
    ADD CONSTRAINT fk_rhstu_paciente_telefone FOREIGN KEY ( id_paciente )
        REFERENCES t_rhstu_paciente ( id_paciente );

ALTER TABLE t_rhstu_paciente_plano_saude
    ADD CONSTRAINT fk_rhstu_plano_saude_pac FOREIGN KEY ( id_plano_saude )
        REFERENCES t_rhstu_plano_saude ( id_plano_saude );

ALTER TABLE t_rhstu_contato_paciente
    ADD CONSTRAINT fk_rhstu_tipo_contato FOREIGN KEY ( id_tipo_contato )
        REFERENCES t_rhstu_tipo_contato ( id_tipo_contato );

ALTER TABLE t_rhstu_consulta
    ADD CONSTRAINT fk_rhstu_unid_hosp_consulta FOREIGN KEY ( id_unid_hospital )
        REFERENCES t_rhstu_unid_hospitalar ( id_unid_hospital );

ALTER TABLE t_rhstu_endereco_unidhosp
    ADD CONSTRAINT fk_rhstu_unidhosp_end FOREIGN KEY ( id_unid_hospital )
        REFERENCES t_rhstu_unid_hospitalar ( id_unid_hospital );

CREATE OR REPLACE TRIGGER arc_trg_general_t_rhstu_medico BEFORE
    INSERT OR UPDATE OF id_func ON t_rhstu_medico
    FOR EACH ROW
DECLARE
    d NUMBER(10);
BEGIN
    SELECT
        a.id_func
    INTO d
    FROM
        t_rhstu_funcionario a
    WHERE
        a.id_func = :new.id_func;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_trg_gene_t_rhstu_motorista BEFORE
    INSERT OR UPDATE OF id_func ON t_rhstu_motorista
    FOR EACH ROW
DECLARE
    d NUMBER(10);
BEGIN
    SELECT
        a.id_func
    INTO d
    FROM
        t_rhstu_funcionario a
    WHERE
        a.id_func = :new.id_func;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

-- Inserindo os estados
INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (1, 'AC', 'Acre', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (2, 'AL', 'Alagoas', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (3, 'AP', 'Amapá', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (4, 'AM', 'Amazonas', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (5, 'BA', 'Bahia', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (6, 'CE', 'Ceará', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (7, 'ES', 'Espírito Santo', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (8, 'GO', 'Goiás', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (9, 'MA', 'Maranhão', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (10, 'MT', 'Mato Grosso', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (11, 'MS', 'Mato Grosso do Sul', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (12, 'MG', 'Minas Gerais', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (13, 'PA', 'Pará', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (14, 'PB', 'Paraíba', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (15, 'PR', 'Paraná', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (16, 'PE', 'Pernambuco', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (17, 'PI', 'Piauí', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (18, 'RJ', 'Rio de Janeiro', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (19, 'RN', 'Rio Grande do Norte', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (20, 'RS', 'Rio Grande do Sul', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (21, 'RO', 'Rondônia', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (22, 'RR', 'Roraima', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (23, 'SC', 'Santa Catarina', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (24, 'SP', 'São Paulo', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (25, 'SE', 'Sergipe', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (26, 'TO', 'Tocantins', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (27, 'DF', 'Distrito Federal', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Inserindo as 10 cidades para o estado do Acre (Estado com ID 1)
-- Estado 1: Acre
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (1, 1, 'Rio Branco', 1200401, 68, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (2, 1, 'Cruzeiro do Sul', 1200203, 68, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (3, 1, 'Sena Madureira', 1200454, 68, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (4, 1, 'Tarauacá', 1200603, 68, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (5, 1, 'Feijó', 1200306, 68, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (6, 1, 'Porto Acre', 1200802, 68, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (7, 1, 'Plácido de Castro', 1200389, 68, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (8, 1, 'Xapuri', 1200802, 68, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (9, 1, 'Marechal Thaumaturgo', 1200306, 68, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (10, 1, 'Brasiléia', 1200389, 68, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 2: Alagoas
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (11, 2, 'Maceió', 2704302, 82, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (12, 2, 'Arapiraca', 2700409, 82, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (13, 2, 'Penedo', 2706703, 82, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (14, 2, 'Palmeira dos Índios', 2706307, 82, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (15, 2, 'Rio Largo', 2707404, 82, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (16, 2, 'Delmiro Gouveia', 2702405, 82, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (17, 2, 'Campo Alegre', 2701407, 82, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (18, 2, 'Santana do Ipanema', 2708907, 82, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (19, 2, 'União dos Palmares', 2709301, 82, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (20, 2, 'Maragogi', 2704906, 82, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 3: Amapá
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (21, 3, 'Macapá', 1600303, 96, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (22, 3, 'Santana', 1600600, 96, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (23, 3, 'Mazagão', 1600402, 96, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (24, 3, 'Oiapoque', 1600501, 96, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (25, 3, 'Laranjal do Jari', 1600279, 96, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (26, 3, 'Calçoene', 1600204, 96, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (27, 3, 'Cutias', 1600212, 96, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (28, 3, 'Pedra Branca do Amapari', 1600154, 96, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (29, 3, 'Serra do Navio', 1600700, 96, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (30, 3, 'Amapá', 1600105, 96, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 4: Amazonas
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (31, 4, 'Manaus', 1302603, 92, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (32, 4, 'Manacapuru', 1302504, 92, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (33, 4, 'Parintins', 1303403, 92, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (34, 4, 'Itacoatiara', 1301902, 92, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (35, 4, 'Iranduba', 1301803, 92, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (36, 4, 'Tefé', 1304203, 92, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (37, 4, 'Coari', 1301209, 92, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (38, 4, 'Tabatinga', 1304062, 92, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (39, 4, 'Manicoré', 1302504, 92, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (40, 4, 'Humaitá', 1301704, 92, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 5: Bahia
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (41, 5, 'Salvador', 2927408, 71, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (42, 5, 'Feira de Santana', 2910800, 75, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (43, 5, 'Vitória da Conquista', 2932605, 77, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (44, 5, 'Camaçari', 2904706, 71, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (45, 5, 'Itabuna', 2914602, 73, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (46, 5, 'Juazeiro', 2911103, 74, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (47, 5, 'Lauro de Freitas', 2919206, 71, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (48, 5, 'Ilhéus', 2910700, 73, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (49, 5, 'Serrinha', 2930501, 75, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (50, 5, 'Porto Seguro', 2925304, 73, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 6: Ceará
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (51, 6, 'Fortaleza', 2304400, 85, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (52, 6, 'Caucaia', 2303709, 85, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (53, 6, 'Juazeiro do Norte', 2307304, 88, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (54, 6, 'Maracanaú', 2307650, 85, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (55, 6, 'Sobral', 2312907, 88, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (56, 6, 'Crato', 2304103, 88, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (57, 6, 'Itapipoca', 2306406, 88, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (58, 6, 'Maranguape', 2307650, 85, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (59, 6, 'Quixadá', 2311305, 88, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (60, 6, 'Iguatu', 2305507, 88, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 7: Espírito Santo
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (61, 7, 'Vitória', 3205309, 27, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (62, 7, 'Vila Velha', 3205200, 27, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (63, 7, 'Cariacica', 3201307, 27, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (64, 7, 'Serra', 3205001, 27, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (65, 7, 'Linhares', 3203204, 27, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (66, 7, 'Cachoeiro de Itapemirim', 3201208, 28, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (67, 7, 'Guarapari', 3202404, 27, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (68, 7, 'Colatina', 3201503, 27, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (69, 7, 'Aracruz', 3200604, 27, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (70, 7, 'Nova Venécia', 3203905, 27, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 8: Goiás
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (71, 8, 'Goiânia', 5208707, 62, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (72, 8, 'Aparecida de Goiânia', 5201405, 62, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (73, 8, 'Anápolis', 5201108, 62, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (74, 8, 'Luziânia', 5212502, 61, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (75, 8, 'Águas Lindas de Goiás', 5200259, 61, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (76, 8, 'Valparaíso de Goiás', 5221859, 61, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (77, 8, 'Formosa', 5208006, 61, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (78, 8, 'Caldas Novas', 5204906, 64, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (79, 8, 'Itumbiara', 5209905, 64, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (80, 8, 'Jataí', 5211901, 64, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 9: Maranhão
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (81, 9, 'São Luís', 2111300, 98, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (82, 9, 'Imperatriz', 2105302, 99, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (83, 9, 'São José de Ribamar', 2111250, 98, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (84, 9, 'Timon', 2112233, 99, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (85, 9, 'Caxias', 2103000, 99, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (86, 9, 'Codó', 2103307, 99, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (87, 9, 'Paço do Lumiar', 2107606, 98, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (88, 9, 'Açailândia', 2100055, 99, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (89, 9, 'Bacabal', 2101202, 99, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (90, 9, 'Balsas', 2101608, 99, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 10: Mato Grosso
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (91, 10, 'Cuiabá', 5103403, 65, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (92, 10, 'Várzea Grande', 5108402, 65, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (93, 10, 'Rondonópolis', 5107602, 66, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (94, 10, 'Sinop', 5107909, 66, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (95, 10, 'Tangará da Serra', 5107925, 65, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (96, 10, 'Primavera do Leste', 5107040, 66, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (97, 10, 'Barra do Garças', 5101704, 66, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (98, 10, 'Nova Mutum', 5106209, 65, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (99, 10, 'Pontes e Lacerda', 5106753, 65, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (100, 10, 'Campo Verde', 5102703, 65, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 11: Mato Grosso do Sul
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (101, 11, 'Campo Grande', 5002704, 67, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (102, 11, 'Dourados', 5003702, 67, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (103, 11, 'Três Lagoas', 5008305, 67, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (104, 11, 'Corumbá', 5003306, 67, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (105, 11, 'Ponta Porã', 5006606, 67, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (106, 11, 'Naviraí', 5005707, 67, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (107, 11, 'Amambai', 5001102, 67, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (108, 11, 'Rio Brilhante', 5007208, 67, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (109, 11, 'Nova Andradina', 5006200, 67, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (110, 11, 'Coxim', 5003206, 67, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (111, 12, 'Belo Horizonte', 3106200, 31, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (112, 12, 'Uberlândia', 3170206, 34, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (113, 12, 'Contagem', 3118601, 31, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (114, 12, 'Juiz de Fora', 3136703, 32, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (115, 12, 'Betim', 3106705, 31, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (116, 12, 'Montes Claros', 3143303, 38, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (117, 12, 'Ribeirão das Neves', 3154805, 31, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (118, 12, 'Uberaba', 3170107, 34, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (119, 12, 'Governador Valadares', 3127702, 33, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (120, 12, 'Ipatinga', 3131301, 31, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 13: Pará
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (121, 13, 'Belém', 1501402, 91, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (122, 13, 'Ananindeua', 1500800, 91, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (123, 13, 'Santarém', 1506807, 93, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (124, 13, 'Marabá', 1504207, 94, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (125, 13, 'Castanhal', 1502409, 91, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (126, 13, 'Parauapebas', 1505535, 94, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (127, 13, 'Itaituba', 1503605, 93, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (128, 13, 'Tucuruí', 1508308, 94, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (129, 13, 'Belém do Pará', 1501436, 91, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (130, 13, 'Ananindeua do Pará', 1500824, 91, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 14: Paraíba
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (131, 14, 'João Pessoa', 2507507, 83, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (132, 14, 'Campina Grande', 2504008, 83, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (133, 14, 'Santa Rita', 2513703, 83, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (134, 14, 'Patos', 2510808, 83, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (135, 14, 'Bayeux', 2501805, 83, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (136, 14, 'Cabedelo', 2503207, 83, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (137, 14, 'Santa Luzia', 2513505, 83, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (138, 14, 'Guarabira', 2506308, 83, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (139, 14, 'Sousa', 2515939, 83, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (140, 14, 'Cajazeiras', 2503909, 83, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Estado 15: Paraná
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (141, 15, 'Curitiba', 4106902, 41, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (142, 15, 'Londrina', 4113709, 43, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (143, 15, 'Maringá', 4115209, 44, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (144, 15, 'Ponta Grossa', 4119904, 42, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (145, 15, 'Cascavel', 4104807, 45, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (146, 15, 'São José dos Pinhais', 4125506, 41, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (147, 15, 'Foz do Iguaçu', 4108304, 45, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (148, 15, 'Colombo', 4105805, 41, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (149, 15, 'Piraquara', 4119607, 41, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (150, 15, 'Paranaguá', 4118105, 41, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 16: Pernambuco
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (151, 16, 'Recife', 2611606, 81, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (152, 16, 'Jaboatão dos Guararapes', 2607901, 81, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (153, 16, 'Olinda', 2609600, 81, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (154, 16, 'Caruaru', 2604106, 81, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (155, 16, 'Petrolina', 2611101, 87, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (156, 16, 'Paulista', 2610608, 81, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (157, 16, 'Cabo de Santo Agostinho', 2602907, 81, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (158, 16, 'Camaragibe', 2604002, 81, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (159, 16, 'São Lourenço da Mata', 2613708, 81, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (160, 16, 'Garanhuns', 2606007, 87, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 17: Piauí
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (161, 17, 'Teresina', 2211001, 86, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (162, 17, 'Parnaíba', 2207701, 86, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (163, 17, 'Picos', 2208006, 89, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (164, 17, 'Campo Maior', 2201902, 86, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (165, 17, 'Floriano', 2203908, 89, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (166, 17, 'Barras', 2201175, 86, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (167, 17, 'José de Freitas', 2205359, 86, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (168, 17, 'Piripiri', 2208502, 86, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (169, 17, 'Oeiras', 2207009, 89, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (170, 17, 'Campo Alegre do Fidalgo', 2201902, 89, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 19: Rio de Janeiro
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (171, 19, 'Rio de Janeiro', 3304557, 21, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (172, 19, 'São Gonçalo', 3304904, 21, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (173, 19, 'Duque de Caxias', 3301701, 21, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (174, 19, 'Nova Iguaçu', 3303509, 21, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (175, 19, 'Niterói', 3303301, 21, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (176, 19, 'Belford Roxo', 3300455, 21, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (177, 19, 'Campos dos Goytacazes', 3301008, 22, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (178, 19, 'São João de Meriti', 3305157, 21, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (179, 19, 'Bangu', 3300800, 21, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (180, 19, 'Nova Friburgo', 3303400, 22, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 20: Rio Grande do Norte
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (181, 20, 'Natal', 2408102, 84, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (182, 20, 'Mossoró', 2408003, 84, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (183, 20, 'Parnamirim', 2403251, 84, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (184, 20, 'Macaíba', 2407203, 84, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (185, 20, 'Ceará-Mirim', 2402600, 84, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (186, 20, 'Caicó', 2402204, 84, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (187, 20, 'Currais Novos', 2403103, 84, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (188, 20, 'São Gonçalo do Amarante', 2412005, 84, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (189, 20, 'Apodi', 2401107, 84, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (190, 20, 'Parelhas', 2408608, 84, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 21: Rio Grande do Sul
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (191, 21, 'Porto Alegre', 4314902, 51, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (192, 21, 'Caxias do Sul', 4305108, 54, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (193, 21, 'Pelotas', 4314407, 53, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (194, 21, 'Canoas', 4304600, 51, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (195, 21, 'Santa Maria', 4316908, 55, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (196, 21, 'Novo Hamburgo', 4313400, 51, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (197, 21, 'São Leopoldo', 4318706, 51, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (198, 21, 'Rio Grande', 4315603, 53, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (199, 21, 'Uruguaiana', 4322401, 55, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (200, 21, 'Bagé', 4301606, 53, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 22: Rondônia
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (201, 22, 'Porto Velho', 1100205, 69, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (202, 22, 'Ji-Paraná', 1100122, 69, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (203, 22, 'Ariquemes', 1100023, 69, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (204, 22, 'Vilhena', 1100304, 69, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (205, 22, 'Cacoal', 1100049, 69, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (206, 22, 'Pimenta Bueno', 1100180, 69, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (207, 22, 'Ouro Preto do Oeste', 1100156, 69, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (208, 22, 'Guajará-Mirim', 1100107, 69, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (209, 22, 'Jaru', 1100909, 69, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (210, 22, 'Rolim de Moura', 1100288, 69, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 23: Roraima
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (211, 23, 'Boa Vista', 1400100, 95, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (212, 23, 'Caracaraí', 1400233, 95, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (213, 23, 'Rorainópolis', 1400472, 95, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (214, 23, 'Mucajaí', 1400308, 95, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (215, 23, 'Cantá', 1400234, 95, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (216, 23, 'Pacaraima', 1400456, 95, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (217, 23, 'Amajari', 1400027, 95, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (218, 23, 'Bonfim', 1400105, 95, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (219, 23, 'Caroebe', 1400257, 95, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (220, 23, 'Iracema', 1400281, 95, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 24: Santa Catarina
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (221, 24, 'Florianópolis', 4205407, 48, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (222, 24, 'Joinville', 4209102, 47, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (223, 24, 'Blumenau', 4202404, 47, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (224, 24, 'Criciúma', 4204608, 48, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (225, 24, 'Chapecó', 4204202, 49, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (226, 24, 'São José', 4216603, 48, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (227, 24, 'Lages', 4209301, 49, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (228, 24, 'Jaraguá do Sul', 4208907, 47, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (229, 24, 'Itajaí', 4208204, 47, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (230, 24, 'Balneário Camboriú', 4202008, 47, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 25: São Paulo
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (231, 25, 'São Paulo', 3550308, 11, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (232, 25, 'Guarulhos', 3518800, 11, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (233, 25, 'Campinas', 3509502, 19, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (234, 25, 'São Bernardo do Campo', 3548708, 11, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (235, 25, 'Santo André', 3547809, 11, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (236, 25, 'Osasco', 3534401, 11, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (237, 25, 'Ribeirão Preto', 3543402, 16, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (238, 25, 'Sorocaba', 3552203, 15, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (239, 25, 'Santos', 3548508, 13, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (240, 25, 'Jundiaí', 3525904, 11, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 26: Sergipe
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (241, 26, 'Aracaju', 2800308, 79, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (242, 26, 'Nossa Senhora do Socorro', 2804904, 79, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (243, 26, 'Maceió', 2704302, 82, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (244, 26, 'Lagarto', 2803501, 79, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (245, 26, 'Itabaiana', 2802900, 79, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (246, 26, 'Estância', 2802108, 79, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (247, 26, 'São Cristóvão', 2806704, 79, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (248, 26, 'Nossa Senhora da Glória', 2804902, 79, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (249, 26, 'Tobias Barreto', 2807301, 79, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (250, 26, 'Propriá', 2805602, 79, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 27: Tocantins
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (251, 27, 'Palmas', 1721000, 63, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (252, 27, 'Araguaína', 1702109, 63, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (253, 27, 'Gurupi', 1709302, 63, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (254, 27, 'Paraíso do Tocantins', 1716109, 63, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (255, 27, 'Porto Nacional', 1718204, 63, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (256, 27, 'Araguatins', 1702109, 63, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (257, 27, 'Colinas do Tocantins', 1705508, 63, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (258, 27, 'Guaraí', 1709303, 63, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (259, 27, 'Dianópolis', 1707000, 63, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (260, 27, 'Miracema do Tocantins', 1713209, 63, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 27: Distrito Federal
-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (261, 27, 'Taguatinga', 5300108, 61, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (271, 27, 'Lianópolis', 1607000, 613, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (273, 27, 'Ceilândia', 5300108, 61, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (274, 27, 'Planaltina', 5300108, 61, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (275, 27, 'Sobradinho', 5300108, 61, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (276, 27, 'Gama', 5300108, 61, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (277, 27, 'Paranoá', 5300108, 61, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (278, 27, 'Santa Maria', 5300108, 61, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (279, 27, 'Recanto das Emas', 5300108, 61, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (280, 27, 'Samambaia', 5300108, 61, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
 
--
-- Exemplo para a cidade de Rio Branco, Acre (1ª cidade)
-- Criação de bairros fictícios
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (1, 1, 'Bairro da Floresta', 'ZONA LESTE', TO_DATE('2022-04-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (2, 1, 'Bairro Novo', 'ZONA SUL', TO_DATE('2019-11-20', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 1 (para Bairro da Floresta)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (1, 1, 'Rua das Árvores', 69900-001, 'Admin');

-- Logradouro 2 (para Bairro da Floresta)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (2, 1, 'Avenida das Flores', 69900-002, 'Admin');

-- Logradouro 3 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (3, 2, 'Rua do Sol', 69900-003, 'Admin');

-- Logradouro 4 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (4, 2, 'Avenida do Futuro', 69900-004, 'Admin');
-- Cidade: Cruzeiro do Sul, Acre
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (3, 2, 'Bairro Central', 'CENTRO', TO_DATE('2021-03-25', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (4, 2, 'Bairro Industrial', 'ZONA OESTE', TO_DATE('2019-10-18', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 5 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (5, 3, 'Rua do Comércio', 69900-005, 'Admin');

-- Logradouro 6 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (6, 3, 'Avenida da Paz', 69900-006, 'Admin');

-- Logradouro 7 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (7, 4, 'Rua da Indústria', 69900-007, 'Admin');

-- Logradouro 8 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (8, 4, 'Avenida da Produção', 69900-008, 'Admin');
-- Cidade: Tarauacá, Acre
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (7, 4, 'Bairro Tarumã', 'ZONA LESTE', TO_DATE('2020-11-05', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (8, 4, 'Bairro São João', 'ZONA OESTE', TO_DATE('2019-07-12', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 13 (para Bairro Tarumã)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (13, 7, 'Rua do Riacho', 69920-001, 'Admin');

-- Logradouro 14 (para Bairro Tarumã)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (14, 7, 'Avenida da Natureza', 69920-002, 'Admin');

-- Logradouro 15 (para Bairro São João)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (15, 8, 'Rua São João', 69920-003, 'Admin');

-- Logradouro 16 (para Bairro São João)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (16, 8, 'Avenida da Amizade', 69920-004, 'Admin');
-- Cidade: Feijó, Acre
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (9, 5, 'Bairro Central', 'CENTRO', TO_DATE('2020-12-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (10, 5, 'Bairro Progresso', 'ZONA SUL', TO_DATE('2021-05-03', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 17 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (17, 9, 'Rua do Comércio', 69930-001, 'Admin');

-- Logradouro 18 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (18, 9, 'Avenida da Paz', 69930-002, 'Admin');

-- Logradouro 19 (para Bairro Progresso)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (19, 10, 'Rua do Progresso', 69930-003, 'Admin');

-- Logradouro 20 (para Bairro Progresso)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (20, 10, 'Avenida do Desenvolvimento', 69930-004, 'Admin');

-- Cidade: Porto Acre, Acre
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (11, 6, 'Bairro Novo', 'ZONA SUL', TO_DATE('2020-08-21', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (12, 6, 'Bairro Industrial', 'ZONA OESTE', TO_DATE('2019-11-30', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 21 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (21, 11, 'Rua da Amizade', 69940-001, 'Admin');

-- Logradouro 22 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (22, 11, 'Avenida da Esperança', 69940-002, 'Admin');

-- Logradouro 23 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (23, 12, 'Rua da Indústria', 69940-003, 'Admin');

-- Logradouro 24 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (24, 12, 'Avenida da Produção', 69940-004, 'Admin');
-- Cidade: Plácido de Castro, Acre
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (13, 7, 'Bairro Central', 'CENTRO', TO_DATE('2021-02-14', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (14, 7, 'Bairro Novo', 'ZONA SUL', TO_DATE('2021-03-30', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 25 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (25, 13, 'Rua da Paz', 69950-001, 'Admin');

-- Logradouro 26 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (26, 13, 'Avenida Central', 69950-002, 'Admin');

-- Logradouro 27 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (27, 14, 'Rua da Amizade', 69950-003, 'Admin');

-- Logradouro 28 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (28, 14, 'Avenida da Esperança', 69950-004, 'Admin');
-- Cidade: Xapuri, Acre
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (15, 8, 'Bairro São Francisco', 'CENTRO', TO_DATE('2020-07-29', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (16, 8, 'Bairro Novo', 'ZONA SUL', TO_DATE('2019-11-12', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 29 (para Bairro São Francisco)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (29, 15, 'Rua da Paz', 69960-001, 'Admin');

-- Logradouro 30 (para Bairro São Francisco)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (30, 15, 'Avenida Central', 69960-002, 'Admin');

-- Logradouro 31 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (31, 16, 'Rua da Amizade', 69960-003, 'Admin');

-- Logradouro 32 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (32, 16, 'Avenida da Esperança', 69960-004, 'Admin');
-- Cidade: Marechal Thaumaturgo, Acre
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (17, 9, 'Bairro Central', 'CENTRO', TO_DATE('2020-08-03', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (18, 9, 'Bairro Novo', 'ZONA SUL', TO_DATE('2019-12-01', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 33 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (33, 17, 'Rua da Paz', 69970-001, 'Admin');

-- Logradouro 34 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (34, 17, 'Avenida Central', 69970-002, 'Admin');

-- Logradouro 35 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (35, 18, 'Rua da Amizade', 69970-003, 'Admin');

-- Logradouro 36 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (36, 18, 'Avenida da Esperança', 69970-004, 'Admin');
-- Cidade: Brasiléia, Acre
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (19, 10, 'Bairro Central', 'CENTRO', TO_DATE('2020-07-18', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (20, 10, 'Bairro Novo', 'ZONA SUL', TO_DATE('2020-09-04', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 37 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (37, 19, 'Rua da Paz', 69980-001, 'Admin');

-- Logradouro 38 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (38, 19, 'Avenida Central', 69980-002, 'Admin');

-- Logradouro 39 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (39, 20, 'Rua da Amizade', 69980-003, 'Admin');

-- Logradouro 40 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (40, 20, 'Avenida da Esperança', 69980-004, 'Admin');
-- Cidade: Maceió, Alagoas
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (21, 11, 'Bairro Centro', 'CENTRO', TO_DATE('2021-04-05', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (22, 11, 'Bairro Farol', 'ZONA LESTE', TO_DATE('2019-08-11', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 41 (para Bairro Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (41, 21, 'Rua da Alegria', 57000-001, 'Admin');

-- Logradouro 42 (para Bairro Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (42, 21, 'Avenida Principal', 57000-002, 'Admin');

-- Logradouro 43 (para Bairro Farol)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (43, 22, 'Rua da Praia', 57000-003, 'Admin');

-- Logradouro 44 (para Bairro Farol)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (44, 22, 'Avenida da Orla', 57000-004, 'Admin');

-- Cidade: Arapiraca, Alagoas
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (23, 12, 'Bairro Central', 'CENTRO', TO_DATE('2021-02-22', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (24, 12, 'Bairro Novo', 'ZONA SUL', TO_DATE('2021-03-14', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 45 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (45, 23, 'Rua do Comércio', 57300-001, 'Admin');

-- Logradouro 46 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (46, 23, 'Avenida da Paz', 57300-002, 'Admin');

-- Logradouro 47 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (47, 24, 'Rua da Indústria', 57300-003, 'Admin');

-- Logradouro 48 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (48, 24, 'Avenida da Produção', 57300-004, 'Admin');
-- Cidade: Palmeira dos Índios, Alagoas
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (25, 13, 'Bairro Central', 'CENTRO', TO_DATE('2020-10-12', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (26, 13, 'Bairro Novo', 'ZONA SUL', TO_DATE('2019-06-30', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 49 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (49, 25, 'Rua da Praça', 57600-001, 'Admin');

-- Logradouro 50 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (50, 25, 'Avenida das Flores', 57600-002, 'Admin');

-- Logradouro 51 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (51, 26, 'Rua da Esperança', 57600-003, 'Admin');

-- Logradouro 52 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (52, 26, 'Avenida dos Sonhos', 57600-004, 'Admin');

-- Cidade: Rio Largo, Alagoas
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (27, 14, 'Bairro Central', 'CENTRO', TO_DATE('2020-08-14', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (28, 14, 'Bairro Industrial', 'ZONA OESTE', TO_DATE('2019-11-19', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 53 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (53, 27, 'Rua da Alegria', 57100-001, 'Admin');

-- Logradouro 54 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (54, 27, 'Avenida Principal', 57100-002, 'Admin');

-- Logradouro 55 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (55, 28, 'Rua da Indústria', 57100-003, 'Admin');

-- Logradouro 56 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (56, 28, 'Avenida da Produção', 57100-004, 'Admin');
-- Cidade: Marechal Deodoro, Alagoas
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (29, 15, 'Bairro Histórico', 'CENTRO', TO_DATE('2020-12-08', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (30, 15, 'Bairro Novo', 'ZONA SUL', TO_DATE('2021-02-17', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 57 (para Bairro Histórico)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (57, 29, 'Rua das Ruínas', 57900-001, 'Admin');

-- Logradouro 58 (para Bairro Histórico)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (58, 29, 'Avenida da História', 57900-002, 'Admin');

-- Logradouro 59 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (59, 30, 'Rua da Esperança', 57900-003, 'Admin');

-- Logradouro 60 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (60, 30, 'Avenida dos Sonhos', 57900-004, 'Admin');

-- Cidade: Penedo, Alagoas
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (31, 16, 'Bairro do Comércio', 'CENTRO', TO_DATE('2021-06-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (32, 16, 'Bairro Industrial', 'ZONA OESTE', TO_DATE('2019-09-30', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 61 (para Bairro do Comércio)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (61, 31, 'Rua do Mercado', 57200-001, 'Admin');

-- Logradouro 62 (para Bairro do Comércio)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (62, 31, 'Avenida da Feira', 57200-002, 'Admin');

-- Logradouro 63 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (63, 32, 'Rua da Indústria', 57200-003, 'Admin');

-- Logradouro 64 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (64, 32, 'Avenida da Produção', 57200-004, 'Admin');
-- Cidade: União dos Palmares, Alagoas
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (33, 17, 'Bairro Central', 'CENTRO', TO_DATE('2020-04-25', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (34, 17, 'Bairro Novo', 'ZONA SUL', TO_DATE('2021-08-14', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 65 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (65, 33, 'Rua da Praça', 57300-001, 'Admin');

-- Logradouro 66 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (66, 33, 'Avenida das Flores', 57300-002, 'Admin');

-- Logradouro 67 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (67, 34, 'Rua da Esperança', 57300-003, 'Admin');

-- Logradouro 68 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (68, 34, 'Avenida dos Sonhos', 57300-004, 'Admin');

-- Cidade: Delmiro Gouveia, Alagoas
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (35, 18, 'Bairro Central', 'CENTRO', TO_DATE('2020-11-07', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (36, 18, 'Bairro Industrial', 'ZONA OESTE', TO_DATE('2019-07-24', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 69 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (69, 35, 'Rua do Comércio', 57400-001, 'Admin');

-- Logradouro 70 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (70, 35, 'Avenida da Paz', 57400-002, 'Admin');

-- Logradouro 71 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (71, 36, 'Rua da Indústria', 57400-003, 'Admin');

-- Logradouro 72 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (72, 36, 'Avenida da Produção', 57400-004, 'Admin');
-- Cidade: Arapiraca, Alagoas
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (37, 19, 'Bairro Central', 'CENTRO', TO_DATE('2020-08-17', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (38, 19, 'Bairro Novo', 'ZONA SUL', TO_DATE('2021-07-12', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 73 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (73, 37, 'Rua do Comércio', 57300-001, 'Admin');

-- Logradouro 74 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (74, 37, 'Avenida da Paz', 57300-002, 'Admin');

-- Logradouro 75 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (75, 38, 'Rua da Esperança', 57300-003, 'Admin');

-- Logradouro 76 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (76, 38, 'Avenida dos Sonhos', 57300-004, 'Admin');

-- Cidade: Palmeira dos Índios, Alagoas
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (39, 20, 'Bairro Central', 'CENTRO', TO_DATE('2020-06-05', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (40, 20, 'Bairro Industrial', 'ZONA OESTE', TO_DATE('2019-12-19', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 77 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (77, 39, 'Rua do Comércio', 57500-001, 'Admin');

-- Logradouro 78 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (78, 39, 'Avenida da Paz', 57500-002, 'Admin');

-- Logradouro 79 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (79, 40, 'Rua da Indústria', 57500-003, 'Admin');

-- Logradouro 80 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (80, 40, 'Avenida da Produção', 57500-004, 'Admin');
-- Cidade: Penedo, Alagoas
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (41, 21, 'Bairro Central', 'CENTRO', TO_DATE('2020-10-30', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (42, 21, 'Bairro Novo', 'ZONA SUL', TO_DATE('2021-06-05', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 81 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (81, 41, 'Rua do Comércio', 57460-001, 'Admin');

-- Logradouro 82 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (82, 41, 'Avenida da Paz', 57460-002, 'Admin');

-- Logradouro 83 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (83, 42, 'Rua da Esperança', 57460-003, 'Admin');

-- Logradouro 84 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (84, 42, 'Avenida dos Sonhos', 57460-004, 'Admin');

-- Cidade: Santana do Ipanema, Alagoas
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (43, 22, 'Bairro Central', 'CENTRO', TO_DATE('2020-02-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (44, 22, 'Bairro Industrial', 'ZONA OESTE', TO_DATE('2021-04-08', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 85 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (85, 43, 'Rua do Comércio', 57620-001, 'Admin');

-- Logradouro 86 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (86, 43, 'Avenida da Paz', 57620-002, 'Admin');

-- Logradouro 87 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (87, 44, 'Rua da Indústria', 57620-003, 'Admin');

-- Logradouro 88 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (88, 44, 'Avenida da Produção', 57620-004, 'Admin');
-- Cidade: Delmiro Gouveia, Alagoas
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (45, 23, 'Bairro Central', 'CENTRO', TO_DATE('2019-11-11', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (46, 23, 'Bairro Novo', 'ZONA SUL', TO_DATE('2020-07-14', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 89 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (89, 45, 'Rua do Comércio', 57480-001, 'Admin');

-- Logradouro 90 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (90, 45, 'Avenida da Paz', 57480-002, 'Admin');

-- Logradouro 91 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (91, 46, 'Rua da Esperança', 57480-003, 'Admin');

-- Logradouro 92 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (92, 46, 'Avenida dos Sonhos', 57480-004, 'Admin');

-- Cidade: União dos Palmares, Alagoas
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (47, 24, 'Bairro Central', 'CENTRO', TO_DATE('2020-03-30', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (48, 24, 'Bairro Industrial', 'ZONA OESTE', TO_DATE('2019-09-27', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 93 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (93, 47, 'Rua do Comércio', 57700-001, 'Admin');

-- Logradouro 94 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (94, 47, 'Avenida da Paz', 57700-002, 'Admin');

-- Logradouro 95 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (95, 48, 'Rua da Indústria', 57700-003, 'Admin');

-- Logradouro 96 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (96, 48, 'Avenida da Produção', 57700-004, 'Admin');
-- Cidade: Macapá, Amapá
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (53, 27, 'Bairro Central', 'CENTRO', TO_DATE('2021-04-12', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (54, 27, 'Bairro Novo', 'ZONA SUL', TO_DATE('2019-08-28', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 105 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (105, 53, 'Rua do Comércio', 68900-001, 'Admin');

-- Logradouro 106 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (106, 53, 'Avenida da Paz', 68900-002, 'Admin');

-- Logradouro 107 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (107, 54, 'Rua da Esperança', 68900-003, 'Admin');

-- Logradouro 108 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (108, 54, 'Avenida dos Sonhos', 68900-004, 'Admin');

-- Cidade: Santana, Amapá
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (55, 28, 'Bairro Central', 'CENTRO', TO_DATE('2020-11-03', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (56, 28, 'Bairro Industrial', 'ZONA OESTE', TO_DATE('2021-05-14', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 109 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (109, 55, 'Rua do Comércio', 68925-001, 'Admin');

-- Logradouro 110 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (110, 55, 'Avenida da Paz', 68925-002, 'Admin');

-- Logradouro 111 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (111, 56, 'Rua da Indústria', 68925-003, 'Admin');

-- Logradouro
-- Cidade: Laranjal do Jari, Amapá
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (57, 29, 'Bairro Central', 'CENTRO', TO_DATE('2021-10-30', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (58, 29, 'Bairro Novo', 'ZONA SUL', TO_DATE('2019-07-22', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 113 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (113, 57, 'Rua do Comércio', 68920-001, 'Admin');

-- Logradouro 114 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (114, 57, 'Avenida da Paz', 68920-002, 'Admin');

-- Logradouro 115 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (115, 58, 'Rua da Esperança', 68920-003, 'Admin');

-- Logradouro 116 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (116, 58, 'Avenida dos Sonhos', 68920-004, 'Admin');

-- Cidade: Oiapoque, Amapá
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (59, 30, 'Bairro Central', 'CENTRO', TO_DATE('2022-02-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (60, 30, 'Bairro Industrial', 'ZONA OESTE', TO_DATE('2020-06-07', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 117 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (117, 59, 'Rua do Comércio', 68980-001, 'Admin');

-- Logradouro 118 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (118, 59, 'Avenida da Paz', 68980-002, 'Admin');

-- Logradouro 119 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (119, 60, 'Rua da Indústria', 68980-003, 'Admin');

-- Logradouro 120 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (120, 60, 'Avenida da Produção', 68980-004, 'Admin');
-- Cidade: Calçoene, Amapá
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (61, 31, 'Bairro Central', 'CENTRO', TO_DATE('2020-08-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (62, 31, 'Bairro Novo', 'ZONA SUL', TO_DATE('2022-03-18', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 121 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (121, 61, 'Rua do Comércio', 68940-001, 'Admin');

-- Logradouro 122 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (122, 61, 'Avenida da Paz', 68940-002, 'Admin');

-- Logradouro 123 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (123, 62, 'Rua da Esperança', 68940-003, 'Admin');

-- Logradouro 124 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (124, 62, 'Avenida dos Sonhos', 68940-004, 'Admin');

-- Cidade: Tartarugalzinho, Amapá
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (63, 32, 'Bairro Central', 'CENTRO', TO_DATE('2021-09-07', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (64, 32, 'Bairro Novo', 'ZONA SUL', TO_DATE('2019-12-14', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 125 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (125, 63, 'Rua do Comércio', 68960-001, 'Admin');

-- Logradouro 126 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (126, 63, 'Avenida da Paz', 68960-002, 'Admin');

-- Logradouro 127 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (127, 64, 'Rua da Esperança', 68960-003, 'Admin');

-- Logradouro 128 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (128, 64, 'Avenida dos Sonhos', 68960-004, 'Admin');
-- Cidade: Vitória do Jari, Amapá
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (65, 33, 'Bairro Central', 'CENTRO', TO_DATE('2021-04-11', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (66, 33, 'Bairro Novo', 'ZONA SUL', TO_DATE('2022-01-25', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 129 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (129, 65, 'Rua do Comércio', 68980-001, 'Admin');

-- Logradouro 130 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (130, 65, 'Avenida da Paz', 68980-002, 'Admin');

-- Logradouro 131 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (131, 66, 'Rua da Esperança', 68980-003, 'Admin');

-- Logradouro 132 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (132, 66, 'Avenida dos Sonhos', 68980-004, 'Admin');

-- Cidade: Cutias, Amapá
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (67, 34, 'Bairro Central', 'CENTRO', TO_DATE('2020-11-20', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (68, 34, 'Bairro Novo', 'ZONA SUL', TO_DATE('2021-06-02', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 133 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (133, 67, 'Rua do Comércio', 68985-001, 'Admin');

-- Logradouro 134 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (134, 67, 'Avenida da Paz', 68985-002, 'Admin');

-- Logradouro 135 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (135, 68, 'Rua da Esperança', 68985-003, 'Admin');

-- Logradouro 136 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (136, 68, 'Avenida dos Sonhos', 68985-004, 'Admin');
-- Cidade: Porto Grande, Amapá
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (69, 35, 'Bairro Central', 'CENTRO', TO_DATE('2021-12-03', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (70, 35, 'Bairro Novo', 'ZONA SUL', TO_DATE('2022-05-27', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 137 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (137, 69, 'Rua do Comércio', 68995-001, 'Admin');

-- Logradouro 138 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (138, 69, 'Avenida da Paz', 68995-002, 'Admin');

-- Logradouro 139 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (139, 70, 'Rua da Esperança', 68995-003, 'Admin');

-- Logradouro 140 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (140, 70, 'Avenida dos Sonhos', 68995-004, 'Admin');

-- Cidade: Serra do Navio, Amapá
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (71, 36, 'Bairro Central', 'CENTRO', TO_DATE('2021-07-14', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (72, 36, 'Bairro Novo', 'ZONA SUL', TO_DATE('2020-09-30', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 141 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (141, 71, 'Rua do Comércio', 68990-001, 'Admin');

-- Logradouro 142 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (142, 71, 'Avenida da Paz', 68990-002, 'Admin');

-- Logradouro 143 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (143, 72, 'Rua da Esperança', 68990-003, 'Admin');

-- Logradouro 144 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (144, 72, 'Avenida dos Sonhos', 68990-004, 'Admin');
-- Cidade: Manaus, Amazonas
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (77, 39, 'Bairro Central', 'CENTRO', TO_DATE('2022-02-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (78, 39, 'Bairro Industrial', 'ZONA OESTE', TO_DATE('2021-11-20', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 153 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (153, 77, 'Avenida das Flores', 69000-001, 'Admin');

-- Logradouro 154 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (154, 77, 'Rua do Comércio', 69000-002, 'Admin');

-- Logradouro 155 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (155, 78, 'Avenida da Indústria', 69000-003, 'Admin');

-- Logradouro 156 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (156, 78, 'Rua da Produção', 69000-004, 'Admin');

-- Cidade: Parintins, Amazonas
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (79, 40, 'Bairro da Praia', 'ZONA NORTE', TO_DATE('2022-04-11', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (80, 40, 'Bairro Novo Horizonte', 'ZONA SUL', TO_DATE('2021-08-27', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 157 (para Bairro da Praia)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (157, 79, 'Avenida Beira Rio', 69100-001, 'Admin');

-- Logradouro 158 (para Bairro da Praia)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (158, 79, 'Rua das Ondas', 69100-002, 'Admin');

-- Logradouro 159 (para Bairro Novo Horizonte)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (159, 80, 'Avenida dos Sonhos', 69100-003, 'Admin');

-- Logradouro 160 (para Bairro Novo Horizonte)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (160, 80, 'Rua da Esperança', 69100-004, 'Admin');

-- Cidade: Coari, Amazonas
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (81, 41, 'Bairro do Lago', 'CENTRO', TO_DATE('2022-06-05', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (82, 41, 'Bairro do Sol', 'ZONA LESTE', TO_DATE('2021-12-10', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 161 (para Bairro do Lago)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (161, 81, 'Avenida das Águas', 69460-001, 'Admin');

-- Logradouro 162 (para Bairro do Lago)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (162, 81, 'Rua dos Peixes', 69460-002, 'Admin');

-- Logradouro 163 (para Bairro do Sol)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (163, 82, 'Avenida do Sol', 69460-003, 'Admin');
-- Cidade: Itacoatiara, Amazonas
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (83, 42, 'Bairro Novo', 'ZONA OESTE', TO_DATE('2022-08-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (84, 42, 'Bairro dos Pássaros', 'ZONA SUL', TO_DATE('2021-12-05', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 165 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (165, 83, 'Avenida das Palmeiras', 69100-005, 'Admin');

-- Logradouro 166 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (166, 83, 'Rua das Flores', 69100-006, 'Admin');

-- Logradouro 167 (para Bairro dos Pássaros)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (167, 84, 'Avenida dos Pássaros', 69100-007, 'Admin');

-- Logradouro 168 (para Bairro dos Pássaros)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (168, 84, 'Rua das Aves', 69100-008, 'Admin');

-- Cidade: Manacapuru, Amazonas
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (85, 43, 'Bairro do Lago', 'CENTRO', TO_DATE('2022-07-20', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (86, 43, 'Bairro Novo Horizonte', 'ZONA SUL', TO_DATE('2021-11-30', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 169 (para Bairro do Lago)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (169, 85, 'Avenida das Águas', 69400-001, 'Admin');

-- Logradouro 170 (para Bairro do Lago)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (170, 85, 'Rua dos Peixes', 69400-002, 'Admin');

-- Logradouro 171 (para Bairro Novo Horizonte)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (171, 86, 'Avenida dos Sonhos', 69400-003, 'Admin');

-- Logradouro 172 (para Bairro Novo Horizonte)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (172, 86, 'Rua da Esperança', 69400-004, 'Admin');

-- Cidade: Tefé, Amazonas
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (87, 44, 'Bairro das Flores', 'CENTRO', TO_DATE('2023-01-12', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (88, 44, 'Bairro dos Pássaros', 'ZONA SUL', TO_DATE('2021-10-25', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 173 (para Bairro das Flores)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (173, 87, 'Avenida das Árvores', 69480-001, 'Admin');

-- Logradouro 174 (para Bairro das Flores)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (174, 87, 'Rua das Plantas', 69480-002, 'Admin');

-- Logradouro 175 (para Bairro dos Pássaros)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (175, 88, 'Avenida dos Pássaros', 69480-003, 'Admin');

-- Logradouro 176 (para Bairro dos Pássaros)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (176, 88, 'Rua das Aves', 69480-004, 'Admin');

-- Cidade: Tabatinga, Amazonas
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (89, 45, 'Bairro Central', 'CENTRO', TO_DATE('2023-03-05', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (90, 45, 'Bairro Novo', 'ZONA SUL', TO_DATE('2022-10-10', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 177 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (177, 89, 'Avenida da Cidade', 69660-001, 'Admin');

-- Logradouro 178 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (178, 89, 'Rua do Comércio', 69660-002, 'Admin');

-- Logradouro 179 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (179, 90, 'Avenida dos Sonhos', 69660-003, 'Admin');

-- Logradouro 180 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (180, 90, 'Rua da Esperança', 69660-004, 'Admin');

-- Cidade: Humaitá, Amazonas
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (91, 46, 'Bairro da Paz', 'CENTRO', TO_DATE('2022-08-22', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (92, 46, 'Bairro Novo', 'ZONA LESTE', TO_DATE('2021-11-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 181 (para Bairro da Paz)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (181, 91, 'Avenida da Paz', 69800-001, 'Admin');

-- Logradouro 182 (para Bairro da Paz)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (182, 91, 'Rua das Flores', 69800-002, 'Admin');

-- Logradouro 183 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (183, 92, 'Avenida do Sol', 69800-003, 'Admin');

-- Logradouro 184 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (184, 92, 'Rua dos Pássaros', 69800-004, 'Admin');
-- Cidade: Salvador, Bahia
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (97, 50, 'Pelourinho', 'CENTRO', TO_DATE('2022-06-30', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (98, 50, 'Barra', 'ZONA LESTE', TO_DATE('2021-11-25', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 193 (para Pelourinho)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (193, 97, 'Rua do Pelourinho', 40026-280, 'Admin');

-- Logradouro 194 (para Pelourinho)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (194, 97, 'Largo da Misericórdia', 40026-290, 'Admin');

-- Logradouro 195 (para Barra)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (195, 98, 'Avenida da Orla', 40140-130, 'Admin');

-- Logradouro 196 (para Barra)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (196, 98, 'Rua das Palmeiras', 40140-140, 'Admin');

-- Cidade: Feira de Santana, Bahia
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (99, 51, 'Centro', 'CENTRO', TO_DATE('2023-01-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (100, 51, 'Queimadinha', 'ZONA NORTE', TO_DATE('2022-05-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 197 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (197, 99, 'Avenida Getúlio Vargas', 44001-968, 'Admin');

-- Logradouro 198 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (198, 99, 'Rua da Praça', 44001-970, 'Admin');

-- Logradouro 199 (para Queimadinha)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (199, 100, 'Avenida das Mangueiras', 44001-973, 'Admin');

-- Logradouro 200 (para Queimadinha)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (200, 100, 'Rua das Acácias', 44001-975, 'Admin');

-- Cidade: Vitória da Conquista, Bahia
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (101, 52, 'Centro', 'CENTRO', TO_DATE('2022-12-02', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (102, 52, 'Candeias', 'ZONA SUL', TO_DATE('2021-10-25', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 201 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (201, 101, 'Avenida da Conquista', 45000-123, 'Admin');

-- Logradouro 202 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (202, 101, 'Rua das Praças', 45000-125, 'Admin');

-- Logradouro 203 (para Candeias)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (203, 102, 'Avenida das Palmeiras', 45000-128, 'Admin');

-- Logradouro 204 (para Candeias)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (204, 102, 'Rua das Flores', 45000-130, 'Admin');

-- Cidade: Itabuna, Bahia
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (103, 53, 'Centro', 'CENTRO', TO_DATE('2023-02-18', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (104, 53, 'São Caetano', 'ZONA SUL', TO_DATE('2022-07-29', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 205 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (205, 103, 'Avenida Principal', 45600-100, 'Admin');

-- Logradouro 206 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (206, 103, 'Rua das Lojas', 45600-101, 'Admin');

-- Logradouro 207 (para São Caetano)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (207, 104, 'Avenida São Caetano', 45600-103, 'Admin');

-- Logradouro 208 (para São Caetano)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (208, 104, 'Rua dos Comerciantes', 45600-104, 'Admin');

-- Cidade: Ilhéus, Bahia
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (105, 54, 'Cidade Nova', 'ZONA NORTE', TO_DATE('2023-03-05', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (106, 54, 'Centro', 'CENTRO', TO_DATE('2022-10-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 209 (para Cidade Nova)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (209, 105, 'Avenida das Palmas', 45654-200, 'Admin');

-- Logradouro 210 (para Cidade Nova)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (210, 105, 'Rua dos Jardins', 45654-201, 'Admin');

-- Logradouro 211 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (211, 106, 'Avenida Principal', 45654-202, 'Admin');

-- Logradouro 212 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (212, 106, 'Rua das Lojas', 45654-203, 'Admin');

-- Cidade: Barreiras, Bahia
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (107, 55, 'Centro', 'CENTRO', TO_DATE('2022-04-22', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (108, 55, 'Vila Brasil', 'ZONA SUL', TO_DATE('2021-07-30', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 213 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (213, 107, 'Avenida Central', 47800-123, 'Admin');

-- Logradouro 214 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (214, 107, 'Rua das Praças', 47800-124, 'Admin');

-- Logradouro 215 (para Vila Brasil)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (215, 108, 'Avenida dos Sonhos', 47800-126, 'Admin');

-- Logradouro 216 (para Vila Brasil)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (216, 108, 'Rua das Esperanças', 47800-128, 'Admin');
-- Cidade: Luís Eduardo Magalhães, Bahia
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (109, 56, 'Centro', 'CENTRO', TO_DATE('2023-04-11', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (110, 56, 'Jardim das Flores', 'ZONA NORTE', TO_DATE('2022-08-07', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 217 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (217, 109, 'Avenida Principal', 47850-100, 'Admin');

-- Logradouro 218 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (218, 109, 'Rua das Lojas', 47850-101, 'Admin');

-- Logradouro 219 (para Jardim das Flores)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (219, 110, 'Avenida das Flores', 47850-103, 'Admin');

-- Logradouro 220 (para Jardim das Flores)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (220, 110, 'Rua das Plantas', 47850-104, 'Admin');

-- Cidade: Teixeira de Freitas, Bahia
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (111, 57, 'Centro', 'CENTRO', TO_DATE('2021-09-18', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (112, 57, 'Jardim América', 'ZONE NORTE', TO_DATE('2020-05-14', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 221 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (221, 111, 'Avenida Principal', 45900-100, 'Admin');

-- Logradouro 222 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (222, 111, 'Rua das Lojas', 45900-101, 'Admin');

-- Logradouro 223 (para Jardim América)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (223, 112, 'Avenida das Flores', 45900-103, 'Admin');

-- Logradouro 224 (para Jardim América)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (224, 112, 'Rua das Plantas', 45900-104, 'Admin');
-- Cidade: Ilhéus, Bahia
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (117, 60, 'Centro', 'CENTRO', TO_DATE('2021-08-25', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (118, 60, 'Jardim das Praias', 'ZONA SUL', TO_DATE('2022-06-11', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 233 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (233, 117, 'Avenida Principal', 45670-100, 'Admin');

-- Logradouro 234 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (234, 117, 'Rua das Lojas', 45670-101, 'Admin');

-- Logradouro 235 (para Jardim das Praias)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (235, 118, 'Avenida das Praias', 45670-103, 'Admin');

-- Logradouro 236 (para Jardim das Praias)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (236, 118, 'Rua das Areias', 45670-104, 'Admin');

-- Cidade: Eunápolis, Bahia
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (119, 61, 'Centro', 'CENTRO', TO_DATE('2020-12-07', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (120, 61, 'Jardim das Palmeiras', 'ZONA SUL', TO_DATE('2021-11-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 237 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (237, 119, 'Avenida Principal', 45880-100, 'Admin');

-- Logradouro 238 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (238, 119, 'Rua das Lojas', 45880-101, 'Admin');

-- Logradouro 239 (para Jardim das Palmeiras)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (239, 120, 'Avenida das Palmeiras', 45880-103, 'Admin');

-- Logradouro 240 (para Jardim das Palmeiras)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (240, 120, 'Rua das Flores', 45880-104, 'Admin');
-- Cidade: Fortaleza, Ceará
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (121, 62, 'Bairro Central', 'CENTRO', TO_DATE('2021-05-20', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (122, 62, 'Bairro Industrial', 'ZONA NORTE', TO_DATE('2022-02-11', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 241 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (241, 121, 'Avenida Principal', 60000-100, 'Admin');

-- Logradouro 242 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (242, 121, 'Rua das Lojas', 60000-101, 'Admin');

-- Logradouro 243 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (243, 122, 'Rua da Indústria', 60000-102, 'Admin');

-- Logradouro 244 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (244, 122, 'Avenida da Produção', 60000-103, 'Admin');

-- Cidade: Juazeiro do Norte, Ceará
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (123, 63, 'Bairro São José', 'ZONA SUL', TO_DATE('2020-08-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (124, 63, 'Bairro Santo Antonio', 'ZONA SUL', TO_DATE('2021-12-22', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 245 (para Bairro São José)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (245, 123, 'Avenida das Flores', 63100-201, 'Admin');

-- Logradouro 246 (para Bairro São José)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (246, 123, 'Rua dos Pássaros', 63100-202, 'Admin');

-- Logradouro 247 (para Bairro Santo Antonio)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (247, 124, 'Avenida dos Santos', 63100-203, 'Admin');

-- Logradouro 248 (para Bairro Santo Antonio)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (248, 124, 'Rua das Oliveiras', 63100-204, 'Admin');
-- Cidade: Sobral, Ceará
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (125, 64, 'Bairro do Centro', 'CENTRO', TO_DATE('2020-10-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (126, 64, 'Bairro Aldeota', 'ZONA NORTE', TO_DATE('2021-08-30', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 249 (para Bairro do Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (249, 125, 'Rua Principal', 62000-100, 'Admin');

-- Logradouro 250 (para Bairro do Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (250, 125, 'Avenida das Lojas', 62000-101, 'Admin');

-- Logradouro 251 (para Bairro Aldeota)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (251, 126, 'Rua da Aldeia', 62000-102, 'Admin');

-- Logradouro 252 (para Bairro Aldeota)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (252, 126, 'Avenida dos Comerciantes', 62000-103, 'Admin');

-- Cidade: Crato, Ceará
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (127, 65, 'Bairro do Crato', 'CENTRO', TO_DATE('2021-07-05', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (128, 65, 'Bairro Santo Antonio', 'ZONA SUL', TO_DATE('2022-01-14', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 253 (para Bairro do Crato)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (253, 127, 'Rua da Igreja', 63100-300, 'Admin');

-- Logradouro 254 (para Bairro do Crato)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (254, 127, 'Avenida dos Estudantes', 63100-301, 'Admin');

-- Logradouro 255 (para Bairro Santo Antonio)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (255, 128, 'Rua dos Santos', 63100-302, 'Admin');

-- Logradouro 256 (para Bairro Santo Antonio)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (256, 128, 'Avenida das Flores', 63100-303, 'Admin');
-- Cidade: Iguatu, Ceará
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (129, 66, 'Bairro do Centro', 'CENTRO', TO_DATE('2020-12-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (130, 66, 'Bairro São Francisco', 'ZONA NORTE', TO_DATE('2021-11-25', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 257 (para Bairro do Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (257, 129, 'Rua Principal', 63500-100, 'Admin');

-- Logradouro 258 (para Bairro do Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (258, 129, 'Avenida Comercial', 63500-101, 'Admin');

-- Logradouro 259 (para Bairro São Francisco)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (259, 130, 'Rua dos Artistas', 63500-102, 'Admin');

-- Logradouro 260 (para Bairro São Francisco)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (260, 130, 'Avenida das Artes', 63500-103, 'Admin');

-- Cidade: Limoeiro do Norte, Ceará
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (131, 67, 'Bairro da Paz', 'CENTRO', TO_DATE('2020-06-18', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (132, 67, 'Bairro São João', 'ZONA NORTE', TO_DATE('2021-09-03', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 261 (para Bairro da Paz)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (261, 131, 'Rua da Harmonia', 63400-200, 'Admin');

-- Logradouro 262 (para Bairro da Paz)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (262, 131, 'Avenida das Flores', 63400-201, 'Admin');

-- Logradouro 263 (para Bairro São João)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (263, 132, 'Rua dos Artistas', 63400-202, 'Admin');

-- Logradouro 264 (para Bairro São João)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (264, 132, 'Avenida São João', 63400-203, 'Admin');
-- Cidade: Maracanaú, Ceará
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (133, 68, 'Bairro Central', 'CENTRO', TO_DATE('2020-12-01', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (134, 68, 'Bairro São José', 'ZONA NORTE', TO_DATE('2021-09-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 265 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (265, 133, 'Rua das Lojas', 61900-100, 'Admin');

-- Logradouro 266 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (266, 133, 'Avenida do Comércio', 61900-101, 'Admin');

-- Logradouro 267 (para Bairro São José)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (267, 134, 'Rua São José', 61900-102, 'Admin');

-- Logradouro 268 (para Bairro São José)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (268, 134, 'Avenida São João', 61900-103, 'Admin');

-- Cidade: Quixadá, Ceará
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (135, 69, 'Bairro do Centro', 'CENTRO', TO_DATE('2021-01-20', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (136, 69, 'Bairro da Liberdade', 'ZONA SUL', TO_DATE('2022-02-10', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 269 (para Bairro do Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (269, 135, 'Rua da Liberdade', 63900-200, 'Admin');

-- Logradouro 270 (para Bairro do Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (270, 135, 'Avenida do Centro', 63900-201, 'Admin');

-- Logradouro 271 (para Bairro da Liberdade)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (271, 136, 'Rua das Arvores', 63900-202, 'Admin');

-- Logradouro 272 (para Bairro da Liberdade)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (272, 136, 'Avenida da Paz', 63900-203, 'Admin');
-- Cidade: Sobral, Ceará
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (137, 70, 'Bairro Central', 'CENTRO', TO_DATE('2021-02-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (138, 70, 'Bairro São Vicente', 'ZONA NORTE', TO_DATE('2021-08-10', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 273 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (273, 137, 'Rua do Comércio', 62000-100, 'Admin');

-- Logradouro 274 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (274, 137, 'Avenida da Paz', 62000-101, 'Admin');

-- Logradouro 275 (para Bairro São Vicente)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (275, 138, 'Rua São Vicente', 62000-102, 'Admin');

-- Logradouro 276 (para Bairro São Vicente)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (276, 138, 'Avenida São Francisco', 62000-103, 'Admin');

-- Cidade: Crato, Ceará
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (139, 71, 'Bairro do Centro', 'CENTRO', TO_DATE('2021-03-20', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (140, 71, 'Bairro São João', 'ZONA NORTE', TO_DATE('2022-07-05', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 277 (para Bairro do Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (277, 139, 'Rua Principal', 63100-200, 'Admin');

-- Logradouro 278 (para Bairro do Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (278, 139, 'Avenida Comercial', 63100-201, 'Admin');

-- Logradouro 279 (para Bairro São João)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (279, 140, 'Rua São João', 63100-202, 'Admin');

-- Logradouro 280 (para Bairro São João)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (280, 140, 'Avenida São João', 63100-203, 'Admin');
-- Cidade: Vitória, Espírito Santo
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (141, 72, 'Bairro Central', 'CENTRO', TO_DATE('2021-04-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (142, 72, 'Bairro da Praia', 'ZONA SUL', TO_DATE('2021-05-20', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 281 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (281, 141, 'Avenida Central', 29000-100, 'Admin');

-- Logradouro 282 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (282, 141, 'Rua Comercial', 29000-101, 'Admin');

-- Logradouro 283 (para Bairro da Praia)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (283, 142, 'Avenida Beira-Mar', 29000-200, 'Admin');

-- Logradouro 284 (para Bairro da Praia)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (284, 142, 'Rua dos Coqueiros', 29000-201, 'Admin');

-- Cidade: Vila Velha, Espírito Santo
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (143, 73, 'Bairro da Glória', 'CENTRO', TO_DATE('2020-12-05', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (144, 73, 'Bairro de Itaparica', 'ZONA SUL', TO_DATE('2021-09-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 285 (para Bairro da Glória)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (285, 143, 'Avenida da Glória', 29100-100, 'Admin');

-- Logradouro 286 (para Bairro da Glória)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (286, 143, 'Rua da Paz', 29100-101, 'Admin');

-- Logradouro 287 (para Bairro de Itaparica)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (287, 144, 'Avenida de Itaparica', 29100-200, 'Admin');

-- Logradouro 288 (para Bairro de Itaparica)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (288, 144, 'Rua das Ondas', 29100-201, 'Admin');
-- Cidade: Cariacica, Espírito Santo
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (145, 74, 'Bairro da Serra', 'ZONA SUL', TO_DATE('2021-07-30', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (146, 74, 'Bairro do Campo', 'ZONA OESTE', TO_DATE('2019-11-18', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 289 (para Bairro da Serra)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (289, 145, 'Avenida da Montanha', 29200-100, 'Admin');

-- Logradouro 290 (para Bairro da Serra)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (290, 145, 'Rua das Pedras', 29200-101, 'Admin');

-- Logradouro 291 (para Bairro do Campo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (291, 146, 'Avenida dos Campos', 29200-200, 'Admin');

-- Logradouro 292 (para Bairro do Campo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (292, 146, 'Rua da Roça', 29200-201, 'Admin');

-- Cidade: Guarapari, Espírito Santo
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (147, 75, 'Bairro da Praia', 'ZONA SUL', TO_DATE('2021-08-14', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (148, 75, 'Bairro das Montanhas', 'ZONA SUL', TO_DATE('2020-10-29', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 293 (para Bairro da Praia)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (293, 147, 'Avenida Beira-Mar', 29300-100, 'Admin');

-- Logradouro 294 (para Bairro da Praia)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (294, 147, 'Rua das Ondas', 29300-101, 'Admin');

-- Logradouro 295 (para Bairro das Montanhas)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (295, 148, 'Avenida da Serra', 29300-200, 'Admin');

-- Logradouro 296 (para Bairro das Montanhas)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (296, 148, 'Rua da Floresta', 29300-201, 'Admin');
-- Cidade: Cachoeiro de Itapemirim, Espírito Santo
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (153, 78, 'Bairro do Centro', 'CENTRO', TO_DATE('2021-05-20', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (154, 78, 'Bairro das Colinas', 'ZONA NORTE', TO_DATE('2020-11-02', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 301 (para Bairro do Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (301, 153, 'Avenida Principal', 29300-100, 'Admin');

-- Logradouro 302 (para Bairro do Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (302, 153, 'Rua Comercial', 29300-101, 'Admin');

-- Logradouro 303 (para Bairro das Colinas)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (303, 154, 'Avenida das Montanhas', 29300-200, 'Admin');

-- Logradouro 304 (para Bairro das Colinas)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (304, 154, 'Rua das Árvores', 29300-201, 'Admin');

-- Cidade: Linhares, Espírito Santo
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (155, 79, 'Bairro do Centro', 'CENTRO', TO_DATE('2021-06-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (156, 79, 'Bairro das Praias', 'ZONA SUL', TO_DATE('2020-09-28', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 305 (para Bairro do Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (305, 155, 'Avenida Principal', 29900-100, 'Admin');

-- Logradouro 306 (para Bairro do Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (306, 155, 'Rua Comercial', 29900-101, 'Admin');

-- Logradouro 307 (para Bairro das Praias)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (307, 156, 'Avenida da Orla', 29900-200, 'Admin');

-- Logradouro 308 (para Bairro das Praias)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (308, 156, 'Rua das Areias', 29900-201, 'Admin');

-- Cidade: São Mateus, Espírito Santo
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (157, 80, 'Bairro do Centro', 'CENTRO', TO_DATE('2021-06-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (158, 80, 'Bairro dos Coqueiros', 'ZONA NORTE', TO_DATE('2020-09-28', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 309 (para Bairro do Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (309, 157, 'Avenida Principal', 29800-100, 'Admin');

-- Logradouro 310 (para Bairro do Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (310, 157, 'Rua Comercial', 29800-101, 'Admin');

-- Logradouro 311 (para Bairro dos Coqueiros)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (311, 158, 'Avenida das Palmeiras', 29800-200, 'Admin');

-- Logradouro 312 (para Bairro dos Coqueiros)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (312, 158, 'Rua das Praias', 29800-201, 'Admin');
-- Cidade: Vitória, Espírito Santo
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (159, 81, 'Bairro do Centro', 'CENTRO', TO_DATE('2021-06-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (160, 81, 'Bairro da Praia', 'ZONA SUL', TO_DATE('2020-09-28', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 313 (para Bairro do Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (313, 159, 'Avenida Principal', 29000-100, 'Admin');

-- Logradouro 314 (para Bairro do Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (314, 159, 'Rua Comercial', 29000-101, 'Admin');

-- Logradouro 315 (para Bairro da Praia)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (315, 160, 'Avenida Beira-Mar', 29000-200, 'Admin');

-- Logradouro 316 (para Bairro da Praia)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (316, 160, 'Rua das Ondas', 29000-201, 'Admin');

-- Cidade: Vila Velha, Espírito Santo
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (161, 82, 'Bairro da Praia', 'ZONA SUL', TO_DATE('2021-06-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (162, 82, 'Bairro do Centro', 'CENTRO', TO_DATE('2020-09-28', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 317 (para Bairro da Praia)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (317, 161, 'Avenida Beira-Mar', 29100-100, 'Admin');

-- Logradouro 318 (para Bairro da Praia)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (318, 161, 'Rua das Ondas', 29100-101, 'Admin');

-- Logradouro 319 (para Bairro do Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (319, 162, 'Avenida Principal', 29100-200, 'Admin');

-- Logradouro 320 (para Bairro do Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (320, 162, 'Rua Comercial', 29100-201, 'Admin');
-- Cidade: Goiânia, Goiás
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (149, 76, 'Setor Central', 'CENTRO', TO_DATE('2021-06-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (150, 76, 'Setor Bueno', 'ZONA SUL', TO_DATE('2020-09-28', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 297 (para Setor Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (297, 149, 'Avenida Principal', 74000-001, 'Admin');

-- Logradouro 298 (para Setor Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (298, 149, 'Rua do Comércio', 74000-002, 'Admin');

-- Logradouro 299 (para Setor Bueno)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (299, 150, 'Avenida das Lojas', 74000-003, 'Admin');

-- Logradouro 300 (para Setor Bueno)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (300, 150, 'Rua das Residências', 74000-004, 'Admin');

-- Cidade: Anápolis, Goiás
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (151, 77, 'Setor Industrial', 'ZONA LESTE', TO_DATE('2021-04-12', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (152, 77, 'Setor Industrial', 'ZONA SUL', TO_DATE('2021-04-12', 'YYYY-MM-DD'), 'Admin');
-- Associação de logradouros fictícios para os bairros
-- Logradouro 301 (para Setor Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (301, 151, 'Avenida da Indústria', 75100-001, 'Admin');

-- Logradouro 302 (para Setor Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (302, 151, 'Rua dos Operários', 75100-002, 'Admin');

-- Logradouro 303 (para Setor Comercial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (303, 152, 'Avenida do Comércio', 75100-003, 'Admin');

-- Logradouro 304 (para Setor Comercial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (304, 152, 'Rua das Lojas', 75100-004, 'Admin');

-- Cidade: Aparecida de Goiânia, Goiás
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (153, 78, 'Setor Central', 'CENTRO', TO_DATE('2021-05-30', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (154, 78, 'Setor Jardim', 'ZONA OESTE', TO_DATE('2020-12-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 305 (para Setor Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (305, 153, 'Avenida Principal', 74900-001, 'Admin');

-- Logradouro 306 (para Setor Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (306, 153, 'Rua das Lojas', 74900-002, 'Admin');

-- Logradouro 307 (para Setor Jardim)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (307, 154, 'Avenida das Flores', 74900-003, 'Admin');

-- Logradouro 308 (para Setor Jardim)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (308, 154, 'Rua dos Jardins', 74900-004, 'Admin');

-- Cidade: Trindade, Goiás
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (155, 80, 'Setor Central', 'CENTRO', TO_DATE('2021-09-05', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (156, 80, 'Setor Sul', 'ZONA SUL', TO_DATE('2021-10-22', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 315 (para Setor Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (315, 155, 'Avenida Principal', 75300-001, 'Admin');

-- Logradouro 316 (para Setor Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (316, 155, 'Rua do Comércio', 75300-002, 'Admin');

-- Logradouro 317 (para Setor Sul)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (317, 156, 'Avenida das Praias', 75300-003, 'Admin');

-- Logradouro 318 (para Setor Sul)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (318, 156, 'Rua das Residências', 75300-004, 'Admin');

-- Cidade: Luziânia, Goiás
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (157, 81, 'Setor Central', 'CENTRO', TO_DATE('2021-06-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (158, 81, 'Setor Norte', 'ZONA NORTE', TO_DATE('2021-08-28', 'YYYY-MM-DD'), 'Admin');
-- Cidade: Valparaíso de Goiás, Goiás
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (159, 82, 'Setor de Casas', 'RESIDENCIAL', TO_DATE('2021-07-20', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (160, 82, 'Setor Comercial', 'COMERCIAL', TO_DATE('2020-09-12', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 319 (para Setor de Casas)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (319, 159, 'Rua das Residências', 72870-001, 'Admin');

-- Logradouro 320 (para Setor de Casas)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (320, 159, 'Avenida dos Moradores', 72870-002, 'Admin');

-- Logradouro 321 (para Setor Comercial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (321, 160, 'Avenida do Comércio', 72870-003, 'Admin');

-- Logradouro 322 (para Setor Comercial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (322, 160, 'Rua das Lojas', 72870-004, 'Admin');

-- Cidade: Rio Verde, Goiás
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (161, 83, 'Setor Central', 'CENTRO', TO_DATE('2021-03-22', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (162, 83, 'Setor Industrial', 'INDUSTRIAL', TO_DATE('2020-08-17', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 323 (para Setor Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (323, 161, 'Avenida Principal', 75900-001, 'Admin');

-- Logradouro 324 (para Setor Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (324, 161, 'Rua do Comércio', 75900-002, 'Admin');

-- Logradouro 325 (para Setor Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (325, 162, 'Avenida da Indústria', 75900-003, 'Admin');

-- Logradouro 326 (para Setor Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (326, 162, 'Rua das Fábricas', 75900-004, 'Admin');
-- Cidade: São Luís, Maranhão
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (167, 81, 'Centro', 'CENTRO', TO_DATE('2021-06-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (168, 81, 'Bairro Novo', 'ZONA NORTE', TO_DATE('2020-12-05', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 335 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (335, 167, 'Avenida Principal', '65000-001', 'Admin');

-- Logradouro 336 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (336, 167, 'Rua das Lojas', '65000-002', 'Admin');

-- Logradouro 337 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (337, 168, 'Avenida do Progresso', '65000-003', 'Admin');

-- Logradouro 338 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (338, 168, 'Rua das Residências', '65000-004', 'Admin');

-- Cidade: São José de Ribamar, Maranhão
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (169, 82, 'Bairro Central', 'CENTRO', TO_DATE('2021-07-20', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (170, 82, 'Bairro Novo', 'ZONA LESTE', TO_DATE('2020-11-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 339 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (339, 169, 'Avenida Principal', '65100-001', 'Admin');

-- Logradouro 340 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (340, 169, 'Rua das Lojas', '65100-002', 'Admin');

-- Logradouro 341 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (341, 170, 'Avenida do Progresso', '65100-003', 'Admin');

-- Logradouro 342 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (342, 170, 'Rua das Residências', '65100-004', 'Admin');

-- Cidade: Timon, Maranhão
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (171, 83, 'Bairro Central', 'CENTRO', TO_DATE('2021-08-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (172, 83, 'Bairro Novo', 'ZONA NORTE', TO_DATE('2020-12-12', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 343 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (343, 171, 'Avenida Principal', '65630-001', 'Admin');

-- Logradouro 344 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (344, 171, 'Rua das Lojas', '65630-002', 'Admin');

-- Logradouro 345 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (345, 172, 'Avenida do Progresso', '65630-003', 'Admin');

-- Logradouro 346 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (346, 172, 'Rua das Residências', '65630-004', 'Admin');
-- Cidade: Caxias, Maranhão
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (173, 84, 'Bairro Central', 'CENTRO', TO_DATE('2021-06-14', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (174, 84, 'Bairro Novo', 'ZONA LESTE', TO_DATE('2020-11-05', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 347 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (347, 173, 'Avenida Principal', '65600-001', 'Admin');

-- Logradouro 348 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (348, 173, 'Rua das Lojas', '65600-002', 'Admin');

-- Logradouro 349 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (349, 174, 'Avenida do Progresso', '65600-003', 'Admin');

-- Logradouro 350 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (350, 174, 'Rua das Residências', '65600-004', 'Admin');

-- Cidade: Imperatriz, Maranhão
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (183, 89, 'Bairro Centro', 'CENTRO', TO_DATE('2021-08-22', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (184, 89, 'Bairro Novo', 'ZONA LESTE', TO_DATE('2020-12-17', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 367 (para Bairro Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (367, 183, 'Avenida Principal', '65900-001', 'Admin');

-- Logradouro 368 (para Bairro Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (368, 183, 'Rua do Comércio', '65900-002', 'Admin');

-- Logradouro 369 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (369, 184, 'Avenida do Progresso', '65900-003', 'Admin');

-- Logradouro 370 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (370, 184, 'Rua das Residências', '65900-004', 'Admin');

-- Cidade: Timon, Maranhão
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (185, 90, 'Bairro Centro', 'CENTRO', TO_DATE('2021-06-30', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (186, 90, 'Bairro Novo', 'ZONA LESTE', TO_DATE('2020-09-25', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 371 (para Bairro Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (371, 180, 'Avenida Principal', '75700-001', 'Admin');

-- Logradouro 372 (para Bairro Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (372, 185, 'Rua do Comércio', '65600-002', 'Admin');

-- Logradouro 373 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (373, 186, 'Avenida do Progresso', '65600-003', 'Admin');

-- Logradouro 374 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (374, 186, 'Rua das Residências', '65600-004', 'Admin');

-- Cidade: Codó, Maranhão
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (187, 91, 'Bairro Centro', 'CENTRO', TO_DATE('2021-04-14', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (188, 91, 'Bairro Novo', 'ZONA LESTE', TO_DATE('2020-10-26', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 375 (para Bairro Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (375, 187, 'Avenida Principal', '75900-001', 'Admin');

-- Logradouro 376 (para Bairro Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (376, 187, 'Rua do Comércio', '65400-002', 'Admin');

-- Logradouro 377 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (377, 188, 'Avenida do Progresso', '65400-003', 'Admin');

-- Logradouro 378 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (378, 188, 'Rua das Residências', '75900-001', 'Admin');
-- Cidade: Bacabal, Maranhão
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (191, 93, 'Bairro Centro', 'CENTRO', TO_DATE('2021-06-12', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (192, 93, 'Bairro Novo', 'ZONA LESTE', TO_DATE('2020-10-24', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 383 (para Bairro Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (383, 191, 'Avenida Principal', '65700-001', 'Admin');

-- Logradouro 384 (para Bairro Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (384, 191, 'Rua do Comércio', '65700-002', 'Admin');

-- Logradouro 385 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (385, 192, 'Avenida do Progresso', '65700-003', 'Admin');

-- Logradouro 386 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (386, 192, 'Rua das Residências', '65700-004', 'Admin');

-- Cidade: São José de Ribamar, Maranhão
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (193, 94, 'Bairro Centro', 'CENTRO', TO_DATE('2021-05-30', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (194, 94, 'Bairro Novo', 'ZONA LESTE', TO_DATE('2020-09-16', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 387 (para Bairro Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (387, 193, 'Avenida Principal', '65100-001', 'Admin');

-- Logradouro 388 (para Bairro Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (388, 193, 'Rua do Comércio', '65100-002', 'Admin');

-- Logradouro 389 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (389, 194, 'Avenida do Progresso', '65100-003', 'Admin');

-- Logradouro 390 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (390, 194, 'Rua das Residências', '65100-004', 'Admin');

-- Cidade: Imperatriz, Maranhão
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (195, 95, 'Bairro Centro', 'CENTRO', TO_DATE('2021-06-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (196, 95, 'Bairro Industrial', 'INDUSTRIAL', TO_DATE('2020-08-28', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 391 (para Bairro Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (391, 195, 'Avenida Principal', '65900-001', 'Admin');

-- Logradouro 392 (para Bairro Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (392, 195, 'Rua do Comércio', '65900-002', 'Admin');

-- Logradouro 393 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (393, 196, 'Avenida da Indústria', '65900-003', 'Admin');

-- Logradouro 394 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (394, 196, 'Rua das Fábricas', '65900-004', 'Admin');
-- Cidade: Balsas, Maranhão
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (199, 97, 'Bairro Centro', 'CENTRO', TO_DATE('2021-06-30', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (200, 97, 'Bairro Industrial', 'INDUSTRIAL', TO_DATE('2020-08-28', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 399 (para Bairro Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (399, 199, 'Avenida Principal', '65800-001', 'Admin');

-- Logradouro 400 (para Bairro Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (400, 199, 'Rua do Comércio', '65800-002', 'Admin');

-- Logradouro 401 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (401, 200, 'Avenida da Indústria', '65800-003', 'Admin');

-- Logradouro 402 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (402, 200, 'Rua das Fábricas', '65800-004', 'Admin');
-- Cidade: São Luís, Maranhão
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (205, 100, 'Bairro Centro', 'CENTRO', TO_DATE('2021-04-12', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (206, 100, 'Bairro Turu', 'ZONA SUL', TO_DATE('2020-08-03', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 411 (para Bairro Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (411, 205, 'Avenida Principal', '65000-001', 'Admin');

-- Logradouro 412 (para Bairro Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (412, 205, 'Rua do Comércio', '65000-002', 'Admin');

-- Logradouro 413 (para Bairro Turu)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (413, 206, 'Avenida das Praias', '65000-003', 'Admin');

-- Logradouro 414 (para Bairro Turu)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (414, 206, 'Rua das Areias', '65000-004', 'Admin');
-- Estado: Mato Grosso
-- Cidade: Cuiabá
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (177, 84, 'Centro', 'CENTRO', TO_DATE('2021-05-28', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (178, 84, 'Alvorada', 'ZONA NORTE', TO_DATE('2020-08-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 349 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (349, 177, 'Avenida Central', 78000-001, 'Admin');

-- Logradouro 350 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (350, 177, 'Rua das Lojas', 78000-002, 'Admin');

-- Logradouro 351 (para Alvorada)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (351, 178, 'Avenida da Alvorada', 78000-003, 'Admin');

-- Logradouro 352 (para Alvorada)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (352, 178, 'Rua das Flores', 78000-004, 'Admin');

-- Cidade: Várzea Grande
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (179, 85, 'Jardim Cuiabá', 'ZONA NORTE', TO_DATE('2021-04-17', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (180, 85, 'Jardim Glória', 'ZONA SUL', TO_DATE('2019-10-25', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 353 (para Jardim Cuiabá)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (353, 179, 'Avenida dos Jardins', 78100-001, 'Admin');

-- Logradouro 354 (para Jardim Cuiabá)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (354, 179, 'Rua das Palmeiras', 78100-002, 'Admin');

-- Logradouro 355 (para Jardim Glória)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (355, 180, 'Avenida da Glória', 78100-003, 'Admin');

-- Logradouro 356 (para Jardim Glória)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (356, 180, 'Rua dos Sonhos', 78100-004, 'Admin');
- Cidade: Rondonópolis
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (181, 86, 'Vila Aurora', 'CENTRO', TO_DATE('2021-07-03', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (182, 86, 'Vila Birigui', 'RURAL', TO_DATE('2020-08-19', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 357 (para Vila Aurora)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (357, 181, 'Avenida Principal', 78700-001, 'Admin');

-- Logradouro 358 (para Vila Aurora)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (358, 181, 'Rua do Comércio', 78700-002, 'Admin');

-- Logradouro 359 (para Vila Birigui)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (359, 182, 'Avenida Rural', 78700-003, 'Admin');

-- Logradouro 360 (para Vila Birigui)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (360, 182, 'Rua das Fazendas', 78700-004, 'Admin');

-- Cidade: Sinop
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (183, 87, 'Centro', 'CENTRO', TO_DATE('2021-06-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (184, 87, 'Jardim Itaú', 'ZONA NORTE', TO_DATE('2019-10-31', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 361 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (361, 183, 'Avenida Central', 78500-001, 'Admin');

-- Logradouro 362 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (362, 183, 'Rua das Lojas', 78500-002, 'Admin');

-- Logradouro 363 (para Jardim Itaú)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (363, 184, 'Avenida dos Jardins', 78500-003, 'Admin');

-- Logradouro 364 (para Jardim Itaú)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (364, 184, 'Rua das Palmeiras', 78500-004, 'Admin');
-- Cidade: Tangará da Serra
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (187, 89, 'Centro', 'CENTRO', TO_DATE('2021-03-05', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (188, 89, 'Jardim dos Ipês', 'ZONA NORTE', TO_DATE('2020-10-28', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 369 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (369, 187, 'Avenida Principal', 78300-001, 'Admin');

-- Logradouro 370 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (370, 187, 'Rua do Comércio', 78300-002, 'Admin');

-- Logradouro 371 (para Jardim dos Ipês)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (371, 188, 'Avenida das Flores', 78300-003, 'Admin');

-- Logradouro 372 (para Jardim dos Ipês)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (372, 188, 'Rua das Casas', 78300-004, 'Admin');

-- Cidade: Rondonópolis
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (189, 90, 'Centro', 'CENTRO', TO_DATE('2021-06-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (190, 90, 'Cidade Salmen', 'ZONA LESTE', TO_DATE('2020-10-02', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 373 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (373, 189, 'Avenida Principal', 78700-001, 'Admin');

-- Logradouro 374 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (374, 189, 'Rua do Comércio', 78700-002, 'Admin');

-- Logradouro 375 (para Cidade Salmen)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (375, 190, 'Avenida dos Parques', 78700-003, 'Admin');

-- Logradouro 376 (para Cidade Salmen)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (376, 190, 'Rua das Residências', 78700-004, 'Admin');

-- Cidade: Pontes e Lacerda
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (191, 91, 'Centro', 'CENTRO', TO_DATE('2021-03-18', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (192, 91, 'Jardim das Flores', 'ZONA NORTE', TO_DATE('2020-09-12', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 377 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (377, 191, 'Avenida Principal', 78200-001, 'Admin');

-- Logradouro 378 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (378, 191, 'Rua do Comércio', 78200-002, 'Admin');

-- Logradouro 379 (para Jardim das Flores)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (379, 192, 'Avenida das Flores', 78200-003, 'Admin');

-- Logradouro 380 (para Jardim das Flores)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (380, 192, 'Rua das Casas', 78200-004, 'Admin');

-- Cidade: Primavera do Leste
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (193, 92, 'Centro', 'CENTRO', TO_DATE('2021-07-30', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (194, 92, 'Jardim das Palmeiras', 'ZONA OESTE', TO_DATE('2020-11-22', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 381 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (381, 193, 'Avenida Principal', 78850-001, 'Admin');

-- Logradouro 382 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (382, 193, 'Rua do Comércio', 78850-002, 'Admin');

-- Logradouro 383 (para Jardim das Palmeiras)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (383, 194, 'Avenida das Palmeiras', 78850-003, 'Admin');

-- Logradouro 384 (para Jardim das Palmeiras)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (384, 194, 'Rua das Flores', 78850-004, 'Admin');

-- Cidade: Barra do Garças
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (195, 93, 'Centro', 'CENTRO', TO_DATE('2021-03-05', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (196, 93, 'Bairro Novo', 'ZONA NORTE', TO_DATE('2020-07-28', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 385 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (385, 195, 'Avenida Principal', 78600-001, 'Admin');

-- Logradouro 386 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (386, 195, 'Rua do Comércio', 78600-002, 'Admin');

-- Logradouro 387 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (387, 196, 'Avenida das Casas', 78600-003, 'Admin');

-- Logradouro 388 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (388, 196, 'Rua das Flores', 78600-004, 'Admin');

-- Cidade: São Félix do Araguaia
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (197, 94, 'Centro', 'CENTRO', TO_DATE('2021-04-12', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (198, 94, 'Vila Nova', 'ZONA SUL', TO_DATE('2020-09-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 389 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (389, 197, 'Avenida Principal', 78670-001, 'Admin');

-- Logradouro 390 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (390, 197, 'Rua do Comércio', 78670-002, 'Admin');

-- Logradouro 391 (para Vila Nova)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (391, 198, 'Avenida das Casas', 78670-003, 'Admin');

-- Logradouro 392 (para Vila Nova)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (392, 198, 'Rua das Flores', 78670-004, 'Admin');

-- Cidade: Campo Verde
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (199, 95, 'Centro', 'CENTRO', TO_DATE('2021-06-25', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (200, 95, 'Jardim Primavera', 'ZONA NORTE', TO_DATE('2020-11-10', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 393 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (393, 199, 'Avenida Principal', 78840-001, 'Admin');

-- Logradouro 394 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (394, 199, 'Rua do Comércio', 78840-002, 'Admin');

-- Logradouro 395 (para Jardim Primavera)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (395, 200, 'Avenida das Flores', 78840-003, 'Admin');

-- Logradouro 396 (para Jardim Primavera)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (396, 200, 'Rua das Casas', 78840-004, 'Admin');

-- Cidade: Sapezal
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (201, 96, 'Centro', 'CENTRO', TO_DATE('2021-03-14', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (202, 96, 'Jardim das Palmeiras', 'ZONA OESTE', TO_DATE('2020-09-18', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 397 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (397, 201, 'Avenida Principal', 78250-001, 'Admin');

-- Logradouro 398 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (398, 201, 'Rua do Comércio', 78250-002, 'Admin');

-- Logradouro 399 (para Jardim das Palmeiras)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (399, 202, 'Avenida das Palmeiras', 78250-003, 'Admin');

-- Logradouro 400 (para Jardim das Palmeiras)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (400, 202, 'Rua das Flores', 78250-004, 'Admin');
-- Cidade: Campo Grande, Mato Grosso do Sul
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (327, 84, 'Centro', 'CENTRO', TO_DATE('2021-07-12', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (328, 84, 'Jardim Paulista', 'ZONA SUL', TO_DATE('2020-09-28', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 327 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (327, 327, 'Avenida Principal', 79000-001, 'Admin');

-- Logradouro 328 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (328, 327, 'Rua do Comércio', 79000-002, 'Admin');

-- Logradouro 329 (para Jardim Paulista)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (329, 328, 'Avenida das Flores', 79000-003, 'Admin');

-- Logradouro 330 (para Jardim Paulista)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (330, 328, 'Rua das Árvores', 79000-004, 'Admin');

-- Cidade: Dourados, Mato Grosso do Sul
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (331, 85, 'Centro', 'CENTRO', TO_DATE('2021-08-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (332, 85, 'Jardim Itapuã', 'ZONA SUL', TO_DATE('2020-11-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 331 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (331, 331, 'Avenida Principal', 79800-001, 'Admin');

-- Logradouro 332 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (332, 331, 'Rua do Comércio', 79800-002, 'Admin');

-- Logradouro 333 (para Jardim Itapuã)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (333, 332, 'Avenida das Flores', 79800-003, 'Admin');

-- Logradouro 334 (para Jardim Itapuã)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (334, 332, 'Rua das Árvores', 79800-004, 'Admin');
-- Cidade: Três Lagoas, Mato Grosso do Sul
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (335, 86, 'Bairro Central', 'CENTRO', TO_DATE('2021-05-25', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (336, 86, 'Bairro Industrial', 'INDUSTRIAL', TO_DATE('2020-10-10', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 335 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (335, 335, 'Avenida Principal', 79500-001, 'Admin');

-- Logradouro 336 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (336, 335, 'Rua do Comércio', 79500-002, 'Admin');

-- Logradouro 337 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (337, 336, 'Avenida da Indústria', 79500-003, 'Admin');

-- Logradouro 338 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (338, 336, 'Rua das Fábricas', 79500-004, 'Admin');

-- Cidade: Ponta Porã, Mato Grosso do Sul
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (339, 87, 'Centro', 'CENTRO', TO_DATE('2021-08-18', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (340, 87, 'Bairro Jardim', 'RESIDENCIAL', TO_DATE('2020-09-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 339 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (339, 339, 'Avenida Principal', 79900-001, 'Admin');

-- Logradouro 340 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (340, 339, 'Rua do Comércio', 79900-002, 'Admin');

-- Logradouro 341 (para Bairro Jardim)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (341, 340, 'Avenida das Flores', 79900-003, 'Admin');

-- Logradouro 342 (para Bairro Jardim)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (342, 340, 'Rua das Residências', 79900-004, 'Admin');

-- Cidade: Corumbá, Mato Grosso do Sul
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (343, 88, 'Bairro Central', 'CENTRO', TO_DATE('2021-07-05', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (344, 88, 'Bairro Industrial', 'INDUSTRIAL', TO_DATE('2020-11-10', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 343 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (343, 343, 'Avenida Principal', 79300-001, 'Admin');

-- Logradouro 344 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (344, 343, 'Rua do Comércio', 79300-002, 'Admin');

-- Logradouro 345 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (345, 344, 'Avenida da Indústria', 79300-003, 'Admin');

-- Logradouro 346 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (346, 344, 'Rua das Fábricas', 79300-004, 'Admin');

-- Cidade: Naviraí, Mato Grosso do Sul
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (347, 89, 'Bairro Centro', 'CENTRO', TO_DATE('2021-06-12', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (348, 89, 'Bairro Novo', 'RESIDENCIAL', TO_DATE('2020-10-28', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 347 (para Bairro Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (347, 347, 'Avenida Principal', 79950-001, 'Admin');

-- Logradouro 348 (para Bairro Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (348, 347, 'Rua do Comércio', 79950-002, 'Admin');

-- Logradouro 349 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (349, 348, 'Avenida das Residências', 79950-003, 'Admin');

-- Logradouro 350 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (350, 348, 'Rua das Árvores', 79950-004, 'Admin');
-- Cidade: Nova Andradina, Mato Grosso do Sul
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (351, 90, 'Bairro Central', 'CENTRO', TO_DATE('2021-05-29', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (352, 90, 'Bairro Novo', 'RESIDENCIAL', TO_DATE('2020-09-14', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 351 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (351, 351, 'Avenida Principal', 79700-001, 'Admin');

-- Logradouro 352 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (352, 351, 'Rua do Comércio', 79700-002, 'Admin');

-- Logradouro 353 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (353, 352, 'Avenida das Residências', 79700-003, 'Admin');

-- Logradouro 354 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (354, 352, 'Rua das Árvores', 79700-004, 'Admin');

-- Cidade: São Gabriel do Oeste, Mato Grosso do Sul
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (355, 91, 'Bairro Centro', 'CENTRO', TO_DATE('2021-03-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (356, 91, 'Bairro Jardim', 'RESIDENCIAL', TO_DATE('2020-08-29', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 355 (para Bairro Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (355, 355, 'Avenida Principal', 79150-001, 'Admin');

-- Logradouro 356 (para Bairro Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (356, 355, 'Rua do Comércio', 79150-002, 'Admin');

-- Logradouro 357 (para Bairro Jardim)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (357, 356, 'Avenida das Flores', 79150-003, 'Admin');

-- Logradouro 358 (para Bairro Jardim)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (358, 356, 'Rua das Residências', 79150-004, 'Admin');
-- Cidade: Belo Horizonte, Minas Gerais
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (359, 92, 'Centro', 'CENTRO', TO_DATE('2021-07-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (360, 92, 'Savassi', 'ZONA SUL', TO_DATE('2020-09-18', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 359 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (359, 359, 'Avenida Principal', 30000-001, 'Admin');

-- Logradouro 360 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (360, 359, 'Rua do Comércio', 30000-002, 'Admin');

-- Logradouro 361 (para Savassi)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (361, 360, 'Avenida das Lojas', 30000-003, 'Admin');

-- Logradouro 362 (para Savassi)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (362, 360, 'Rua das Residências', 30000-004, 'Admin');

-- Cidade: Contagem, Minas Gerais
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (363, 93, 'Bairro Industrial', 'INDUSTRIAL', TO_DATE('2021-06-02', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (364, 93, 'Bairro Residencial', 'RESIDENCIAL', TO_DATE('2020-08-27', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 363 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (363, 363, 'Avenida da Indústria', 32000-001, 'Admin');

-- Logradouro 364 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (364, 363, 'Rua das Fábricas', 32000-002, 'Admin');

-- Logradouro 365 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (365, 364, 'Avenida das Residências', 32000-003, 'Admin');

-- Logradouro 366 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (366, 364, 'Rua das Casas', 32000-004, 'Admin');
-- Cidade: Uberlândia, Minas Gerais
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (367, 94, 'Centro', 'CENTRO', TO_DATE('2021-05-12', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (368, 94, 'Bairro Novo', 'RESIDENCIAL', TO_DATE('2020-10-01', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 367 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (367, 367, 'Avenida Principal', 38400-001, 'Admin');

-- Logradouro 368 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (368, 367, 'Rua do Comércio', 38400-002, 'Admin');

-- Logradouro 369 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (369, 368, 'Avenida das Residências', 38400-003, 'Admin');

-- Logradouro 370 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (370, 368, 'Rua das Casas', 38400-004, 'Admin');

-- Cidade: Juiz de Fora, Minas Gerais
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (371, 95, 'Bairro Central', 'CENTRO', TO_DATE('2021-06-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (372, 95, 'Bairro da Serra', 'SERRA', TO_DATE('2020-09-18', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 371 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (371, 371, 'Avenida do Centro', 36000-001, 'Admin');

-- Logradouro 372 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (372, 371, 'Rua das Lojas', 36000-002, 'Admin');

-- Logradouro 373 (para Bairro da Serra)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (373, 372, 'Avenida da Montanha', 36000-003, 'Admin');

-- Logradouro 374 (para Bairro da Serra)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (374, 372, 'Rua das Pedras', 36000-004, 'Admin');
-- Cidade: Betim, Minas Gerais
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (375, 96, 'Centro', 'CENTRO', TO_DATE('2021-07-30', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (376, 96, 'Bairro Industrial', 'INDUSTRIAL', TO_DATE('2019-11-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 375 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (375, 375, 'Avenida Principal', 32600-001, 'Admin');

-- Logradouro 376 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (376, 375, 'Rua do Comércio', 32600-002, 'Admin');

-- Logradouro 377 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (377, 376, 'Avenida da Indústria', 32600-003, 'Admin');

-- Logradouro 378 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (378, 376, 'Rua das Fábricas', 32600-004, 'Admin');

-- Cidade: Montes Claros, Minas Gerais
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (379, 97, 'Bairro Central', 'CENTRO', TO_DATE('2021-05-22', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (380, 97, 'Bairro Novo', 'RESIDENCIAL', TO_DATE('2020-10-28', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 379 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (379, 379, 'Avenida Principal', 39400-001, 'Admin');

-- Logradouro 380 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (380, 379, 'Rua do Comércio', 39400-002, 'Admin');

-- Logradouro 381 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (381, 380, 'Avenida das Residências', 39400-003, 'Admin');

-- Logradouro 382 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (382, 380, 'Rua das Casas', 39400-004, 'Admin');
-- Cidade: Montes Claros, Minas Gerais
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (385, 100, 'Bairro Central', 'CENTRO', TO_DATE('2021-05-19', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (386, 100, 'Bairro Industrial', 'INDUSTRIAL', TO_DATE('2020-09-22', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 391 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (391, 385, 'Avenida Principal', 39400-001, 'Admin');

-- Logradouro 392 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (392, 385, 'Rua do Comércio', 39400-002, 'Admin');

-- Logradouro 393 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (393, 386, 'Avenida da Indústria', 39400-003, 'Admin');

-- Logradouro 394 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (394, 386, 'Rua das Fábricas', 39400-004, 'Admin');

-- Cidade: Pouso Alegre, Minas Gerais
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (387, 101, 'Bairro Central', 'CENTRO', TO_DATE('2021-04-05', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (388, 101, 'Bairro Novo', 'RESIDENCIAL', TO_DATE('2020-10-28', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 395 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (395, 387, 'Avenida Principal', 37500-001, 'Admin');

-- Logradouro 396 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (396, 387, 'Rua do Comércio', 37500-002, 'Admin');

-- Logradouro 397 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (397, 388, 'Avenida das Residências', 37500-003, 'Admin');

-- Logradouro 398 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (398, 388, 'Rua das Casas', 37500-004, 'Admin');
-- Cidade: Belém, Pará
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (399, 102, 'Bairro da Cidade Velha', 'CENTRO', TO_DATE('2021-03-12', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (400, 102, 'Bairro da Pedreira', 'ZONA NORTE', TO_DATE('2020-09-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 399 (para Bairro da Cidade Velha)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (399, 399, 'Avenida da História', 66000-001, 'Admin');

-- Logradouro 400 (para Bairro da Cidade Velha)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (400, 399, 'Rua Antiga', 66000-002, 'Admin');

-- Logradouro 401 (para Bairro da Pedreira)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (401, 400, 'Avenida das Pedras', 66000-003, 'Admin');

-- Logradouro 402 (para Bairro da Pedreira)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (402, 400, 'Rua da Mina', 66000-004, 'Admin');

-- Cidade: Santarém, Pará
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (403, 103, 'Bairro do Porto', 'CENTRO', TO_DATE('2021-04-20', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (404, 103, 'Bairro da Floresta', 'ZONA NORTE', TO_DATE('2020-10-25', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 403 (para Bairro do Porto)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (403, 403, 'Avenida do Rio', 68000-001, 'Admin');

-- Logradouro 404 (para Bairro do Porto)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (404, 403, 'Rua das Águas', 68000-002, 'Admin');

-- Logradouro 405 (para Bairro da Floresta)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (405, 404, 'Avenida das Árvores', 68000-003, 'Admin');

-- Logradouro 406 (para Bairro da Floresta)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (406, 404, 'Rua da Natureza', 68000-004, 'Admin');
-- Cidade: Marabá, Pará
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (407, 104, 'Bairro da Cidade Nova', 'ZONA SUL', TO_DATE('2021-05-28', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (408, 104, 'Bairro do Rio', 'RIBEIRINHA', TO_DATE('2020-11-10', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 407 (para Bairro da Cidade Nova)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (407, 407, 'Avenida dos Comerciantes', 68500-001, 'Admin');

-- Logradouro 408 (para Bairro da Cidade Nova)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (408, 407, 'Rua das Escolas', 68500-002, 'Admin');

-- Logradouro 409 (para Bairro do Rio)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (409, 408, 'Avenida do Rio', 68500-003, 'Admin');

-- Logradouro 410 (para Bairro do Rio)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (410, 408, 'Rua dos Pescadores', 68500-004, 'Admin');

-- Cidade: Castanhal, Pará
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (411, 105, 'Bairro Central', 'CENTRO', TO_DATE('2021-07-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (412, 105, 'Bairro da Matriz', 'CENTRO', TO_DATE('2020-08-22', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 411 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (411, 411, 'Avenida Principal', 68700-001, 'Admin');

-- Logradouro 412 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (412, 411, 'Rua das Lojas', 68700-002, 'Admin');

-- Logradouro 413 (para Bairro da Matriz)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (413, 412, 'Avenida da Igreja', 68700-003, 'Admin');

-- Logradouro 414 (para Bairro da Matriz)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (414, 412, 'Rua dos Fiéis', 68700-004, 'Admin');
-- Cidade: Marituba, Pará
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (415, 106, 'Bairro Central', 'CENTRO', TO_DATE('2021-04-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (416, 106, 'Bairro dos Lagos', 'LAGO', TO_DATE('2020-07-18', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 415 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (415, 415, 'Avenida Principal', 67200-001, 'Admin');

-- Logradouro 416 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (416, 415, 'Rua do Comércio', 67200-002, 'Admin');

-- Logradouro 417 (para Bairro dos Lagos)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (417, 416, 'Avenida dos Lagos', 67200-003, 'Admin');

-- Logradouro 418 (para Bairro dos Lagos)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (418, 416, 'Rua das Águas', 67200-004, 'Admin');

-- Cidade: Abaetetuba, Pará
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (419, 107, 'Bairro da Estação', 'CENTRO', TO_DATE('2021-06-20', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (420, 107, 'Bairro do Porto', 'RIBEIRINHA', TO_DATE('2020-09-11', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 419 (para Bairro da Estação)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (419, 419, 'Avenida da Ferrovia', 68440-001, 'Admin');

-- Logradouro 420 (para Bairro da Estação)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (420, 419, 'Rua dos Passageiros', 68440-002, 'Admin');

-- Logradouro 421 (para Bairro do Porto)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (421, 420, 'Avenida do Porto', 68440-003, 'Admin');

-- Logradouro 422 (para Bairro do Porto)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (422, 420, 'Rua dos Pescadores', 68440-004, 'Admin');
-- Cidade: Cametá, Pará
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (423, 108, 'Bairro Central', 'CENTRO', TO_DATE('2021-05-30', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (424, 108, 'Bairro do Rio', 'RIBEIRINHA', TO_DATE('2019-08-10', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 423 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (423, 423, 'Avenida Principal', 68400-001, 'Admin');

-- Logradouro 424 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (424, 423, 'Rua Comercial', 68400-002, 'Admin');

-- Logradouro 425 (para Bairro do Rio)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (425, 424, 'Avenida do Rio', 68400-003, 'Admin');

-- Logradouro 426 (para Bairro do Rio)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (426, 424, 'Rua das Águas', 68400-004, 'Admin');

-- Cidade: Paragominas, Pará
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (427, 109, 'Bairro Central', 'CENTRO', TO_DATE('2021-02-28', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (428, 109, 'Bairro dos Lagos', 'LAGO', TO_DATE('2019-06-14', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 427 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (427, 427, 'Avenida Principal', 68625-001, 'Admin');

-- Logradouro 428 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (428, 427, 'Rua do Comércio', 68625-002, 'Admin');

-- Logradouro 429 (para Bairro dos Lagos)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (429, 428, 'Avenida dos Lagos', 68625-003, 'Admin');

-- Logradouro 430 (para Bairro dos Lagos)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (430, 428, 'Rua das Águas', 68625-004, 'Admin');
-- Cidade: João Pessoa, Paraíba
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (439, 112, 'Bairro Centro', 'CENTRO', TO_DATE('2021-08-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (440, 112, 'Bairro da Praia', 'LITORAL', TO_DATE('2020-09-25', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 439 (para Bairro Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (439, 439, 'Avenida Principal', 58000-001, 'Admin');

-- Logradouro 440 (para Bairro Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (440, 439, 'Rua Comercial', 58000-002, 'Admin');

-- Logradouro 441 (para Bairro da Praia)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (441, 440, 'Avenida da Praia', 58000-003, 'Admin');

-- Logradouro 442 (para Bairro da Praia)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (442, 440, 'Rua das Ondas', 58000-004, 'Admin');

-- Cidade: Campina Grande, Paraíba
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (443, 113, 'Bairro Central', 'CENTRO', TO_DATE('2021-06-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (444, 113, 'Bairro da Serra', 'SERRA', TO_DATE('2020-08-20', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 443 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (443, 443, 'Avenida Principal', 58400-001, 'Admin');

-- Logradouro 444 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (444, 443, 'Rua do Comércio', 58400-002, 'Admin');

-- Logradouro 445 (para Bairro da Serra)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (445, 444, 'Avenida da Serra', 58400-003, 'Admin');

-- Logradouro 446 (para Bairro da Serra)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (446, 444, 'Rua das Montanhas', 58400-004, 'Admin');
-- Cidade: Santa Rita, Paraíba
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (445, 114, 'Bairro do Centro', 'CENTRO', TO_DATE('2021-07-12', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (446, 114, 'Bairro da Vila', 'RESIDENCIAL', TO_DATE('2020-10-28', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 447 (para Bairro do Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (447, 445, 'Avenida Principal', 58300-001, 'Admin');

-- Logradouro 448 (para Bairro do Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (448, 445, 'Rua do Comércio', 58300-002, 'Admin');

-- Logradouro 449 (para Bairro da Vila)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (449, 446, 'Avenida da Vila', 58300-003, 'Admin');

-- Logradouro 450 (para Bairro da Vila)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (450, 446, 'Rua das Casas', 58300-004, 'Admin');

-- Cidade: Patos, Paraíba
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (447, 115, 'Bairro Central', 'CENTRO', TO_DATE('2021-05-08', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (448, 115, 'Bairro do Sertão', 'SERTÃO', TO_DATE('2020-09-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 451 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (451, 447, 'Avenida da Cidade', 58700-001, 'Admin');

-- Logradouro 452 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (452, 447, 'Rua Comercial', 58700-002, 'Admin');

-- Logradouro 453 (para Bairro do Sertão)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (453, 448, 'Avenida do Sertão', 58700-003, 'Admin');

-- Logradouro 454 (para Bairro do Sertão)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (454, 448, 'Rua das Casas', 58700-004, 'Admin');
-- Cidade: Campina Grande, Paraíba
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (455, 116, 'Bairro do Centro', 'CENTRO', TO_DATE('2021-04-25', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (456, 116, 'Bairro da Liberdade', 'ZONA LESTE', TO_DATE('2020-07-11', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 455 (para Bairro do Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (455, 455, 'Avenida Principal', 58100-001, 'Admin');

-- Logradouro 456 (para Bairro do Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (456, 455, 'Rua Comercial', 58100-002, 'Admin');

-- Logradouro 457 (para Bairro da Liberdade)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (457, 456, 'Avenida da Liberdade', 58100-003, 'Admin');

-- Logradouro 458 (para Bairro da Liberdade)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (458, 456, 'Rua da Praça', 58100-004, 'Admin');

-- Cidade: Sousa, Paraíba
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (459, 117, 'Bairro Central', 'CENTRO', TO_DATE('2021-06-19', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (460, 117, 'Bairro do Comércio', 'COMERCIAL', TO_DATE('2020-11-30', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 459 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (459, 459, 'Avenida Principal', 58800-001, 'Admin');

-- Logradouro 460 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (460, 459, 'Rua das Lojas', 58800-002, 'Admin');

-- Logradouro 461 (para Bairro do Comércio)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (461, 460, 'Avenida do Comércio', 58800-003, 'Admin');

-- Logradouro 462 (para Bairro do Comércio)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (462, 460, 'Rua dos Comerciantes', 58800-004, 'Admin');
-- Cidade: Guarabira, Paraíba
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (463, 118, 'Bairro do Centro', 'CENTRO', TO_DATE('2021-03-14', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (464, 118, 'Bairro Novo', 'ZONA LESTE', TO_DATE('2020-09-28', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 463 (para Bairro do Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (463, 463, 'Avenida Principal', 58200-001, 'Admin');

-- Logradouro 464 (para Bairro do Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (464, 463, 'Rua do Comércio', 58200-002, 'Admin');

-- Logradouro 465 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (465, 464, 'Avenida das Praças', 58200-003, 'Admin');

-- Logradouro 466 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (466, 464, 'Rua das Lojas', 58200-004, 'Admin');

-- Cidade: Patos, Paraíba
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (467, 119, 'Bairro Central', 'CENTRO', TO_DATE('2021-08-02', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (468, 119, 'Bairro da Estação', 'ZONA SUL', TO_DATE('2020-10-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 467 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (467, 467, 'Avenida Principal', 58700-001, 'Admin');

-- Logradouro 468 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (468, 467, 'Rua do Comércio', 58700-002, 'Admin');

-- Logradouro 469 (para Bairro da Estação)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (469, 468, 'Avenida da Estação', 58700-003, 'Admin');

-- Logradouro 470 (para Bairro da Estação)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (470, 468, 'Rua dos Trens', 58700-004, 'Admin');
-- Cidade: Maringá, Paraná
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (487, 124, 'Bairro Central', 'CENTRO', TO_DATE('2021-06-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (488, 124, 'Bairro Jardim', 'RESIDENCIAL', TO_DATE('2020-11-25', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 487 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (487, 487, 'Avenida Principal', 87000-001, 'Admin');

-- Logradouro 488 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (488, 487, 'Rua do Comércio', 87000-002, 'Admin');

-- Logradouro 489 (para Bairro Jardim)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (489, 488, 'Avenida dos Jardins', 87000-003, 'Admin');

-- Logradouro 490 (para Bairro Jardim)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (490, 488, 'Rua das Flores', 87000-004, 'Admin');

-- Cidade: Ponta Grossa, Paraná
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (491, 125, 'Bairro Central', 'CENTRO', TO_DATE('2021-07-05', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (492, 125, 'Bairro Industrial', 'INDUSTRIAL', TO_DATE('2020-08-19', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 491 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (491, 491, 'Avenida Principal', 84000-001, 'Admin');

-- Logradouro 492 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (492, 491, 'Rua do Comércio', 84000-002, 'Admin');

-- Logradouro 493 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (493, 492, 'Avenida da Indústria', 84000-003, 'Admin');

-- Logradouro 494 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (494, 492, 'Rua das Fábricas', 84000-004, 'Admin');
-- Cidade: Londrina, Paraná
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (495, 126, 'Bairro Central', 'CENTRO', TO_DATE('2029-02-18', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (496, 126, 'Bairro Jardim', 'RESIDENCIAL', TO_DATE('2028-11-30', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 495 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (495, 495, 'Avenida Principal', 86000-001, 'Admin');

-- Logradouro 496 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (496, 495, 'Rua do Comércio', 86000-002, 'Admin');

-- Logradouro 497 (para Bairro Jardim)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (497, 496, 'Avenida dos Jardins', 86000-003, 'Admin');

-- Logradouro 498 (para Bairro Jardim)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (498, 496, 'Rua das Flores', 86000-004, 'Admin');

-- Cidade: Foz do Iguaçu, Paraná
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (499, 127, 'Bairro Central', 'CENTRO', TO_DATE('2030-05-22', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (500, 127, 'Bairro Residencial', 'RESIDENCIAL', TO_DATE('2029-08-17', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 499 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (499, 499, 'Avenida Principal', 85800-001, 'Admin');

-- Logradouro 500 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (500, 499, 'Rua do Comércio', 85800-002, 'Admin');

-- Logradouro 501 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (501, 500, 'Avenida dos Moradores', 85800-003, 'Admin');

-- Logradouro 502 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (502, 500, 'Rua das Casas', 85800-004, 'Admin');
-- Cidade: Toledo, Paraná
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (515, 131, 'Bairro Central', 'CENTRO', TO_DATE('2029-11-01', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (516, 131, 'Bairro Residencial', 'RESIDENCIAL', TO_DATE('2029-08-22', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 515 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (515, 515, 'Avenida Principal', 85900-001, 'Admin');

-- Logradouro 516 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (516, 515, 'Rua do Comércio', 85900-002, 'Admin');

-- Logradouro 517 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (517, 516, 'Avenida dos Moradores', 85900-003, 'Admin');

-- Logradouro 518 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (518, 516, 'Rua das Casas', 85900-004, 'Admin');
-- Cidade: Umuarama, Paraná
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (517, 132, 'Bairro Central', 'CENTRO', TO_DATE('2029-07-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (518, 132, 'Bairro Residencial', 'RESIDENCIAL', TO_DATE('2029-05-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 519 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (519, 517, 'Avenida Principal', 87500-001, 'Admin');

-- Logradouro 520 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (520, 517, 'Rua do Comércio', 87500-002, 'Admin');

-- Logradouro 521 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (521, 518, 'Avenida dos Moradores', 87500-003, 'Admin');

-- Logradouro 522 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (522, 518, 'Rua das Casas', 87500-004, 'Admin');

-- Cidade: Paranaguá, Paraná
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (523, 133, 'Bairro Histórico', 'HISTÓRICO', TO_DATE('2029-09-01', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (524, 133, 'Bairro Residencial', 'RESIDENCIAL', TO_DATE('2029-10-05', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 523 (para Bairro Histórico)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (523, 523, 'Avenida do Passado', 83200-001, 'Admin');

-- Logradouro 524 (para Bairro Histórico)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (524, 523, 'Rua das Memórias', 83200-002, 'Admin');

-- Logradouro 525 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (525, 524, 'Avenida dos Moradores', 83200-003, 'Admin');

-- Logradouro 526 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (526, 524, 'Rua das Casas', 83200-004, 'Admin');

-- Cidade: Francisco Beltrão, Paraná
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (527, 134, 'Bairro Central', 'CENTRO', TO_DATE('2029-07-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (528, 134, 'Bairro Residencial', 'RESIDENCIAL', TO_DATE('2029-05-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 527 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (527, 527, 'Avenida Principal', 85600-001, 'Admin');

-- Logradouro 528 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (528, 527, 'Rua do Comércio', 85600-002, 'Admin');

-- Logradouro 529 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (529, 528, 'Avenida dos Moradores', 85600-003, 'Admin');

-- Logradouro 530 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (530, 528, 'Rua das Casas', 85600-004, 'Admin');

-- Cidade: Cianorte, Paraná
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (531, 135, 'Bairro Central', 'CENTRO', TO_DATE('2029-03-01', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (532, 135, 'Bairro Residencial', 'RESIDENCIAL', TO_DATE('2029-04-05', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 531 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (531, 531, 'Avenida Principal', 87200-001, 'Admin');

-- Logradouro 532 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (532, 531, 'Rua do Comércio', 87200-002, 'Admin');

-- Logradouro 533 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (533, 532, 'Avenida dos Moradores', 87200-003, 'Admin');

-- Logradouro 534 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (534, 532, 'Rua das Casas', 87200-004, 'Admin');
-- Cidade: Recife, Pernambuco
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (535, 136, 'Bairro Central', 'CENTRO', TO_DATE('2029-02-20', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (536, 136, 'Bairro Histórico', 'HISTÓRICO', TO_DATE('2029-04-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 535 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (535, 535, 'Avenida Principal', '50000-001', 'Admin');

-- Logradouro 536 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (536, 535, 'Rua do Comércio', '50000-002', 'Admin');

-- Logradouro 537 (para Bairro Histórico)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (537, 536, 'Avenida do Passado', '50000-003', 'Admin');

-- Logradouro 538 (para Bairro Histórico)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (538, 536, 'Rua das Memórias', '50000-004', 'Admin');

-- Cidade: Olinda, Pernambuco
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (539, 137, 'Bairro Histórico', 'HISTÓRICO', TO_DATE('2029-08-01', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (540, 137, 'Bairro Residencial', 'RESIDENCIAL', TO_DATE('2029-07-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 539 (para Bairro Histórico)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (539, 539, 'Avenida do Passado', '53100-001', 'Admin');

-- Logradouro 540 (para Bairro Histórico)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (540, 539, 'Rua das Memórias', '53100-002', 'Admin');

-- Logradouro 541 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (541, 540, 'Avenida dos Moradores', '53100-003', 'Admin');

-- Logradouro 542 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (542, 540, 'Rua das Casas', '53100-004', 'Admin');

-- Cidade: Caruaru, Pernambuco
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (543, 138, 'Bairro Central', 'CENTRO', TO_DATE('2029-01-20', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (544, 138, 'Bairro Comercial', 'COMERCIAL', TO_DATE('2029-03-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 543 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (543, 543, 'Avenida Principal', '55000-001', 'Admin');

-- Logradouro 544 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (544, 543, 'Rua do Comércio', '55000-002', 'Admin');

-- Logradouro 545 (para Bairro Comercial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (545, 544, 'Avenida das Lojas', '55000-003', 'Admin');

-- Logradouro 546 (para Bairro Comercial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (546, 544, 'Rua das Empresas', '55000-004', 'Admin');

-- Cidade: Jaboatão dos Guararapes, Pernambuco
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (547, 139, 'Bairro Residencial', 'RESIDENCIAL', TO_DATE('2029-05-05', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (548, 139, 'Bairro Industrial', 'INDUSTRIAL', TO_DATE('2029-07-25', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 547 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (547, 547, 'Avenida dos Moradores', '54300-001', 'Admin');

-- Logradouro 548 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (548, 547, 'Rua das Casas', '54300-002', 'Admin');

-- Logradouro 549 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (549, 548, 'Avenida da Indústria', '54300-003', 'Admin');

-- Logradouro 550 (para Bairro Industrial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (550, 548, 'Rua das Fábricas', '54300-004', 'Admin');
-- Cidade: Petrolina, Pernambuco
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (551, 140, 'Bairro Central', 'CENTRO', TO_DATE('2029-03-02', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (552, 140, 'Bairro Residencial', 'RESIDENCIAL', TO_DATE('2029-05-28', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 551 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (551, 551, 'Avenida Principal', '56300-001', 'Admin');

-- Logradouro 552 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (552, 551, 'Rua do Comércio', '56300-002', 'Admin');

-- Logradouro 553 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (553, 552, 'Avenida dos Moradores', '56300-003', 'Admin');

-- Logradouro 554 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (554, 552, 'Rua das Casas', '56300-004', 'Admin');

-- Cidade: Cabo de Santo Agostinho, Pernambuco
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (555, 141, 'Bairro Central', 'CENTRO', TO_DATE('2029-03-12', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (556, 141, 'Bairro Residencial', 'RESIDENCIAL', TO_DATE('2029-04-18', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 555 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (555, 555, 'Avenida Principal', '54500-001', 'Admin');

-- Logradouro 556 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (556, 555, 'Rua do Comércio', '54500-002', 'Admin');

-- Logradouro 557 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (557, 556, 'Avenida dos Moradores', '54500-003', 'Admin');

-- Logradouro 558 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (558, 556, 'Rua das Casas', '54500-004', 'Admin');

-- Cidade: Paulista, Pernambuco
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (559, 142, 'Bairro Central', 'CENTRO', TO_DATE('2029-03-19', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (560, 142, 'Bairro Comercial', 'COMERCIAL', TO_DATE('2029-06-10', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 559 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (559, 559, 'Avenida Principal', '54400-001', 'Admin');

-- Logradouro 560 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (560, 559, 'Rua do Comércio', '54400-002', 'Admin');

-- Logradouro 561 (para Bairro Comercial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (561, 560, 'Avenida das Lojas', '54400-003', 'Admin');

-- Logradouro 562 (para Bairro Comercial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (562, 560, 'Rua das Empresas', '54400-004', 'Admin');

-- Cidade: Caruaru, Pernambuco
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (563, 143, 'Bairro Central', 'CENTRO', TO_DATE('2029-03-29', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (564, 143, 'Bairro Residencial', 'RESIDENCIAL', TO_DATE('2029-05-14', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 563 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (563, 563, 'Avenida Principal', '55500-001', 'Admin');

-- Logradouro 564 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (564, 563, 'Rua do Comércio', '55500-002', 'Admin');

-- Logradouro 565 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (565, 564, 'Avenida dos Moradores', '55500-003', 'Admin');

-- Logradouro 566 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (566, 564, 'Rua das Casas', '55500-004', 'Admin');

-- Cidade: Olinda, Pernambuco
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (567, 144, 'Bairro Histórico', 'HISTÓRICO', TO_DATE('2029-04-05', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (568, 144, 'Bairro Comercial', 'COMERCIAL', TO_DATE('2029-06-27', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 567 (para Bairro Histórico)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (567, 567, 'Avenida da História', '53600-001', 'Admin');

-- Logradouro 568 (para Bairro Histórico)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (568, 567, 'Rua dos Monumentos', '53600-002', 'Admin');

-- Logradouro 569 (para Bairro Comercial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (569, 568, 'Avenida das Lojas', '53600-003', 'Admin');

-- Logradouro 570 (para Bairro Comercial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (570, 568, 'Rua do Comércio', '53600-004', 'Admin');
-- Cidade: Teresina, Piauí
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (571, 145, 'Bairro Central', 'CENTRO', TO_DATE('2029-03-29', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (572, 145, 'Bairro Residencial', 'RESIDENCIAL', TO_DATE('2029-05-14', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 571 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (571, 571, 'Avenida Principal', '64000-001', 'Admin');

-- Logradouro 572 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (572, 571, 'Rua do Comércio', '64000-002', 'Admin');

-- Logradouro 573 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (573, 572, 'Avenida dos Moradores', '64000-003', 'Admin');

-- Logradouro 574 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (574, 572, 'Rua das Casas', '64000-004', 'Admin');

-- Cidade: Parnaíba, Piauí
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (575, 146, 'Bairro Histórico', 'HISTÓRICO', TO_DATE('2029-04-05', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (576, 146, 'Bairro Comercial', 'COMERCIAL', TO_DATE('2029-06-27', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 575 (para Bairro Histórico)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (575, 575, 'Avenida da História', '64200-001', 'Admin');

-- Logradouro 576 (para Bairro Histórico)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (576, 575, 'Rua dos Monumentos', '64200-002', 'Admin');

-- Logradouro 577 (para Bairro Comercial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (577, 576, 'Avenida das Lojas', '64200-003', 'Admin');

-- Logradouro 578 (para Bairro Comercial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (578, 576, 'Rua do Comércio', '64200-004', 'Admin');
-- Cidade: Picos, Piauí
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (579, 147, 'Bairro Central', 'CENTRO', TO_DATE('2029-07-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (580, 147, 'Bairro Residencial', 'RESIDENCIAL', TO_DATE('2029-08-21', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 579 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (579, 579, 'Avenida Principal', '64600-001', 'Admin');

-- Logradouro 580 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (580, 579, 'Rua da Praça', '64600-002', 'Admin');

-- Logradouro 581 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (581, 580, 'Avenida das Casas', '64600-003', 'Admin');

-- Logradouro 582 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (582, 580, 'Rua das Árvores', '64600-004', 'Admin');

-- Cidade: Floriano, Piauí
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (583, 148, 'Bairro Central', 'CENTRO', TO_DATE('2029-08-05', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (584, 148, 'Bairro Residencial', 'RESIDENCIAL', TO_DATE('2029-09-17', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 583 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (583, 583, 'Avenida Principal', '64800-001', 'Admin');

-- Logradouro 584 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (584, 583, 'Rua da Praça', '64800-002', 'Admin');

-- Logradouro 585 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (585, 584, 'Avenida das Casas', '64800-003', 'Admin');

-- Logradouro 586 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (586, 584, 'Rua das Árvores', '64800-004', 'Admin');

-- Cidade: Piripiri, Piauí
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (587, 149, 'Bairro Central', 'CENTRO', TO_DATE('2029-09-25', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (588, 149, 'Bairro Residencial', 'RESIDENCIAL', TO_DATE('2029-10-28', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 587 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (587, 587, 'Avenida Principal', '64260-001', 'Admin');

-- Logradouro 588 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (588, 587, 'Rua da Praça', '64260-002', 'Admin');

-- Logradouro 589 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (589, 588, 'Avenida das Casas', '64260-003', 'Admin');

-- Logradouro 590 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (590, 588, 'Rua das Árvores', '64260-004', 'Admin');

-- Cidade: Campo Maior, Piauí
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (591, 150, 'Bairro Central', 'CENTRO', TO_DATE('2029-10-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (592, 150, 'Bairro Residencial', 'RESIDENCIAL', TO_DATE('2029-11-22', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 591 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (591, 591, 'Avenida Principal', '64230-001', 'Admin');

-- Logradouro 592 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (592, 591, 'Rua da Praça', '64230-002', 'Admin');

-- Logradouro 593 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (593, 592, 'Avenida das Casas', '64230-003', 'Admin');

-- Logradouro 594 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (594, 592, 'Rua das Árvores', '64230-004', 'Admin');

-- Cidade: Oeiras, Piauí
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (595, 151, 'Bairro Central', 'CENTRO', TO_DATE('2029-12-03', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (596, 151, 'Bairro Residencial', 'RESIDENCIAL', TO_DATE('2030-01-19', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 595 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (595, 595, 'Avenida Principal', '64500-001', 'Admin');

-- Logradouro 596 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (596, 595, 'Rua da Praça', '64500-002', 'Admin');

-- Logradouro 597 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (597, 596, 'Avenida das Casas', '64500-003', 'Admin');

-- Logradouro 598 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (598, 596, 'Rua das Árvores', '64500-004', 'Admin');
-- Cidade: União, Piauí
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (597, 152, 'Bairro Central', 'CENTRO', TO_DATE('2030-02-28', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (598, 152, 'Bairro Residencial', 'RESIDENCIAL', TO_DATE('2030-03-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 599 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (599, 597, 'Avenida Principal', '64100-001', 'Admin');

-- Logradouro 600 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (600, 597, 'Rua da Praça', '64100-002', 'Admin');

-- Logradouro 601 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (601, 598, 'Avenida das Casas', '64100-003', 'Admin');

-- Logradouro 602 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (602, 598, 'Rua das Árvores', '64100-004', 'Admin');

-- Cidade: Esperantina, Piauí
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (603, 153, 'Bairro Central', 'CENTRO', TO_DATE('2030-04-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (604, 153, 'Bairro Residencial', 'RESIDENCIAL', TO_DATE('2030-05-22', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 603 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (603, 603, 'Avenida Principal', '64180-001', 'Admin');

-- Logradouro 604 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (604, 603, 'Rua da Praça', '64180-002', 'Admin');

-- Logradouro 605 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (605, 604, 'Avenida das Casas', '64180-003', 'Admin');

-- Logradouro 606 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (606, 604, 'Rua das Árvores', '64180-004', 'Admin');

-- Cidade: Barras, Piauí
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (607, 154, 'Bairro Central', 'CENTRO', TO_DATE('2030-06-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (608, 154, 'Bairro Residencial', 'RESIDENCIAL', TO_DATE('2030-07-28', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 607 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (607, 607, 'Avenida Principal', '64160-001', 'Admin');

-- Logradouro 608 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (608, 607, 'Rua da Praça', '64160-002', 'Admin');

-- Logradouro 609 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (609, 608, 'Avenida das Casas', '64160-003', 'Admin');

-- Logradouro 610 (para Bairro Residencial)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (610, 608, 'Rua das Árvores', '64160-004', 'Admin');
-- Cidade: Rio de Janeiro, Rio de Janeiro
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (611, 155, 'Copacabana', 'ZONA SUL', TO_DATE('2030-08-05', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (612, 155, 'Tijuca', 'ZONA NORTE', TO_DATE('2030-09-14', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 611 (para Copacabana)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (611, 611, 'Avenida Atlântica', '22010-000', 'Admin');

-- Logradouro 612 (para Copacabana)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (612, 611, 'Rua das Ondas', '22010-001', 'Admin');

-- Logradouro 613 (para Tijuca)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (613, 612, 'Avenida da Tijuca', '20271-100', 'Admin');

-- Logradouro 614 (para Tijuca)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (614, 612, 'Rua das Árvores', '20271-101', 'Admin');

-- Cidade: Niterói, Rio de Janeiro
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (615, 156, 'Icaraí', 'ZONA SUL', TO_DATE('2030-10-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (616, 156, 'Santa Rosa', 'ZONA NORTE', TO_DATE('2030-11-22', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 615 (para Icaraí)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (615, 615, 'Avenida Beira-Mar', '24020-000', 'Admin');

-- Logradouro 616 (para Icaraí)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (616, 615, 'Rua da Praia', '24020-001', 'Admin');

-- Logradouro 617 (para Santa Rosa)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (617, 616, 'Avenida dos Jardins', '24030-100', 'Admin');

-- Logradouro 618 (para Santa Rosa)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (618, 616, 'Rua das Flores', '24030-101', 'Admin');

-- Cidade: Petrópolis, Rio de Janeiro
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (619, 157, 'Centro', 'CENTRO', TO_DATE('2030-12-05', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (620, 157, 'Quitandinha', 'SERRA', TO_DATE('2031-01-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 619 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (619, 619, 'Avenida Principal', '25645-000', 'Admin');

-- Logradouro 620 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (620, 619, 'Rua Comercial', '25645-001', 'Admin');

-- Logradouro 621 (para Quitandinha)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (621, 620, 'Avenida das Montanhas', '25647-100', 'Admin');

-- Logradouro 622 (para Quitandinha)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (622, 620, 'Rua das Residências', '25647-101', 'Admin');
-- Cidade: Nova Friburgo, Rio de Janeiro
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (623, 158, 'Centro', 'CENTRO', TO_DATE('2031-02-20', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (624, 158, 'Olaria', 'ZONA NORTE', TO_DATE('2031-03-10', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 623 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (623, 623, 'Avenida Principal', '28613-000', 'Admin');

-- Logradouro 624 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (624, 623, 'Rua do Comércio', '28613-001', 'Admin');

-- Logradouro 625 (para Olaria)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (625, 624, 'Avenida da Olaria', '28614-100', 'Admin');

-- Logradouro 626 (para Olaria)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (626, 624, 'Rua das Indústrias', '28614-101', 'Admin');

-- Cidade: Cabo Frio, Rio de Janeiro
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (627, 159, 'Centro', 'CENTRO', TO_DATE('2031-04-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (628, 159, 'Praia do Forte', 'LITORAL', TO_DATE('2031-05-20', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 627 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (627, 627, 'Avenida Central', '28906-000', 'Admin');

-- Logradouro 628 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (628, 627, 'Rua das Lojas', '28906-001', 'Admin');

-- Logradouro 629 (para Praia do Forte)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (629, 628, 'Avenida da Praia', '28908-100', 'Admin');

-- Logradouro 630 (para Praia do Forte)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (630, 628, 'Rua dos Coqueiros', '28908-101', 'Admin');

-- Cidade: Búzios, Rio de Janeiro
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (631, 160, 'Centro', 'CENTRO', TO_DATE('2031-06-25', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (632, 160, 'Geribá', 'LITORAL', TO_DATE('2031-07-30', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 631 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (631, 631, 'Avenida das Praças', '28950-000', 'Admin');

-- Logradouro 632 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (632, 631, 'Rua dos Restaurantes', '28950-001', 'Admin');

-- Logradouro 633 (para Geribá)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (633, 632, 'Avenida da Praia', '28952-100', 'Admin');

-- Logradouro 634 (para Geribá)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (634, 632, 'Rua dos Coqueiros', '28952-101', 'Admin');

-- Cidade: Teresópolis, Rio de Janeiro
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (635, 161, 'Centro', 'CENTRO', TO_DATE('2031-08-20', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (636, 161, 'Alto', 'ZONA NORTE', TO_DATE('2031-09-10', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 635 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (635, 635, 'Avenida Principal', '25953-000', 'Admin');

-- Logradouro 636 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (636, 635, 'Rua das Lojas', '25953-001', 'Admin');

-- Logradouro 637 (para Alto)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (637, 636, 'Avenida das Montanhas', '25955-100', 'Admin');

-- Logradouro 638 (para Alto)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (638, 636, 'Rua das Residências', '25955-101', 'Admin');

-- Cidade: Volta Redonda, Rio de Janeiro
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (639, 162, 'Aterrado', 'SUL', TO_DATE('2031-10-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (640, 162, 'Vila Santa Cecília', 'SUL', TO_DATE('2031-11-20', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 639 (para Aterrado)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (639, 639, 'Avenida Principal', '27213-000', 'Admin');

-- Logradouro 640 (para Aterrado)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (640, 639, 'Rua Comercial', '27213-001', 'Admin');

-- Logradouro 641 (para Vila Santa Cecília)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (641, 640, 'Avenida Santa Cecília', '27215-100', 'Admin');

-- Logradouro 642 (para Vila Santa Cecília)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (642, 640, 'Rua das Lojas', '27215-101', 'Admin');
-- Cidade: Natal, Rio Grande do Norte
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (643, 163, 'Cidade Alta', 'CENTRO', TO_DATE('2022-01-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (644, 163, 'Ponta Negra', 'LITORAL', TO_DATE('2021-07-10', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 643 (para Cidade Alta)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (643, 643, 'Avenida Principal', '59025-000', 'Admin');

-- Logradouro 644 (para Cidade Alta)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (644, 643, 'Rua do Comércio', '59025-001', 'Admin');

-- Logradouro 645 (para Ponta Negra)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (645, 644, 'Avenida da Praia', '59094-100', 'Admin');

-- Logradouro 646 (para Ponta Negra)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (646, 644, 'Rua dos Coqueiros', '59094-101', 'Admin');

-- Cidade: Mossoró, Rio Grande do Norte
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (647, 164, 'Belo Horizonte', 'CENTRO', TO_DATE('2022-03-20', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (648, 164, 'Abolição', 'NORTE', TO_DATE('2021-09-05', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 647 (para Belo Horizonte)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (647, 647, 'Avenida Central', '59603-000', 'Admin');

-- Logradouro 648 (para Belo Horizonte)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (648, 647, 'Rua das Lojas', '59603-001', 'Admin');

-- Logradouro 649 (para Abolição)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (649, 648, 'Avenida da Liberdade', '59613-100', 'Admin');

-- Logradouro 650 (para Abolição)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (650, 648, 'Rua dos Comerciantes', '59613-101', 'Admin');
-- Cidade: Parnamirim, Rio Grande do Norte
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (651, 165, 'Centro', 'CENTRO', TO_DATE('2022-04-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (652, 165, 'Nova Parnamirim', 'NORTE', TO_DATE('2021-11-08', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 651 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (651, 651, 'Avenida Central', '59140-000', 'Admin');

-- Logradouro 652 (para Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (652, 651, 'Rua da Praça', '59140-001', 'Admin');

-- Logradouro 653 (para Nova Parnamirim)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (653, 652, 'Avenida dos Novos', '59150-100', 'Admin');

-- Logradouro 654 (para Nova Parnamirim)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (654, 652, 'Rua das Esquinas', '59150-101', 'Admin');

-- Cidade: Caicó, Rio Grande do Norte
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (655, 166, 'Bairro Central', 'CENTRO', TO_DATE('2022-03-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (656, 166, 'Bairro Novo', 'NORTE', TO_DATE('2021-10-12', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 655 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (655, 655, 'Avenida Principal', '59300-000', 'Admin');

-- Logradouro 656 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (656, 655, 'Rua do Comércio', '59300-001', 'Admin');

-- Logradouro 657 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (657, 656, 'Avenida dos Novatos', '59301-100', 'Admin');

-- Logradouro 658 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (658, 656, 'Rua das Lojas', '59301-101', 'Admin');

-- Cidade: Currais Novos, Rio Grande do Norte
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (659, 167, 'Bairro Central', 'CENTRO', TO_DATE('2022-04-22', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (660, 167, 'Bairro Novo', 'NORTE', TO_DATE('2021-11-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 659 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (659, 659, 'Avenida Principal', '59380-000', 'Admin');

-- Logradouro 660 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (660, 659, 'Rua do Comércio', '59380-001', 'Admin');

-- Logradouro 661 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (661, 660, 'Avenida dos Novatos', '59381-100', 'Admin');

-- Logradouro 662 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (662, 660, 'Rua das Lojas', '59381-101', 'Admin');

-- Cidade: Ceará-Mirim, Rio Grande do Norte
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (663, 168, 'Bairro Central', 'CENTRO', TO_DATE('2022-03-12', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (664, 168, 'Bairro Novo', 'NORTE', TO_DATE('2021-10-18', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 663 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (663, 663, 'Avenida Principal', '59570-000', 'Admin');

-- Logradouro 664 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (664, 663, 'Rua do Comércio', '59570-001', 'Admin');

-- Logradouro 665 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (665, 664, 'Avenida dos Novatos', '59571-100', 'Admin');

-- Logradouro 666 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (666, 664, 'Rua das Lojas', '59571-101', 'Admin');
-- Cidade: Macaíba, Rio Grande do Norte
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (667, 169, 'Bairro Central', 'CENTRO', TO_DATE('2022-02-05', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (668, 169, 'Bairro Novo', 'NORTE', TO_DATE('2021-09-30', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 667 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (667, 667, 'Avenida Principal', '59280-000', 'Admin');

-- Logradouro 668 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (668, 667, 'Rua do Comércio', '59280-001', 'Admin');

-- Logradouro 669 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (669, 668, 'Avenida dos Novatos', '59281-100', 'Admin');

-- Logradouro 670 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (670, 668, 'Rua das Lojas', '59281-101', 'Admin');

-- Cidade: Pau dos Ferros, Rio Grande do Norte
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (671, 170, 'Bairro Central', 'CENTRO', TO_DATE('2022-03-14', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (672, 170, 'Bairro Novo', 'NORTE', TO_DATE('2021-10-28', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 671 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (671, 671, 'Avenida Principal', '59900-000', 'Admin');

-- Logradouro 672 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (672, 671, 'Rua do Comércio', '59900-001', 'Admin');

-- Logradouro 673 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (673, 672, 'Avenida dos Novatos', '59901-100', 'Admin');

-- Logradouro 674 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (674, 672, 'Rua das Lojas', '59901-101', 'Admin');

-- Cidade: Nova Cruz, Rio Grande do Norte
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (675, 171, 'Bairro Central', 'CENTRO', TO_DATE('2022-03-18', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (676, 171, 'Bairro Novo', 'NORTE', TO_DATE('2021-10-20', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 675 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (675, 675, 'Avenida Principal', '59215-000', 'Admin');

-- Logradouro 676 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (676, 675, 'Rua do Comércio', '59215-001', 'Admin');

-- Logradouro 677 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (677, 676, 'Avenida dos Novatos', '59216-100', 'Admin');

-- Logradouro 678 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (678, 676, 'Rua das Lojas', '59216-101', 'Admin');

-- Cidade: Apodi, Rio Grande do Norte
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (679, 172, 'Bairro Central', 'CENTRO', TO_DATE('2022-04-02', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (680, 172, 'Bairro Novo', 'NORTE', TO_DATE('2021-11-25', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 679 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (679, 679, 'Avenida Principal', '59700-000', 'Admin');

-- Logradouro 680 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (680, 679, 'Rua do Comércio', '59700-001', 'Admin');

-- Logradouro 681 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (681, 680, 'Avenida dos Novatos', '59701-100', 'Admin');

-- Logradouro 682 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (682, 680, 'Rua das Lojas', '59701-101', 'Admin');
-- Cidade: Porto Alegre, Rio Grande do Sul
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (681, 173, 'Bairro Central', 'CENTRO', TO_DATE('2022-04-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (682, 173, 'Bairro Novo', 'NORTE', TO_DATE('2021-11-10', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 681 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (681, 681, 'Avenida Principal', '90000-000', 'Admin');

-- Logradouro 682 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (682, 681, 'Rua do Comércio', '90000-001', 'Admin');

-- Logradouro 683 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (683, 682, 'Avenida dos Novatos', '90001-100', 'Admin');

-- Logradouro 684 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (684, 682, 'Rua das Lojas', '90001-101', 'Admin');
-- Cidade: Caxias do Sul, Rio Grande do Sul
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (683, 174, 'Bairro Central', 'CENTRO', TO_DATE('2022-05-20', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (684, 174, 'Bairro Novo', 'NORTE', TO_DATE('2021-12-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 685 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (685, 683, 'Avenida Principal', '95000-000', 'Admin');

-- Logradouro 686 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (686, 683, 'Rua do Comércio', '95000-001', 'Admin');

-- Logradouro 687 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (687, 684, 'Avenida dos Novatos', '95001-100', 'Admin');

-- Logradouro 688 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (688, 684, 'Rua das Lojas', '95001-101', 'Admin');

-- Cidade: Pelotas, Rio Grande do Sul
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (685, 175, 'Bairro Central', 'CENTRO', TO_DATE('2022-05-25', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (686, 175, 'Bairro Novo', 'NORTE', TO_DATE('2021-12-20', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 689 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (689, 685, 'Avenida Principal', '96000-000', 'Admin');

-- Logradouro 690 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (690, 685, 'Rua do Comércio', '96000-001', 'Admin');

-- Logradouro 691 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (691, 686, 'Avenida dos Novatos', '96001-100', 'Admin');

-- Logradouro 692 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (692, 686, 'Rua das Lojas', '96001-101', 'Admin');
-- Cidade: Passo Fundo, Rio Grande do Sul
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (687, 176, 'Bairro Central', 'CENTRO', TO_DATE('2022-06-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (688, 176, 'Bairro Novo', 'NORTE', TO_DATE('2022-01-05', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 693 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (693, 687, 'Avenida Principal', '99000-000', 'Admin');

-- Logradouro 694 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (694, 687, 'Rua do Comércio', '99000-001', 'Admin');

-- Logradouro 695 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (695, 688, 'Avenida dos Novatos', '99001-100', 'Admin');

-- Logradouro 696 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (696, 688, 'Rua das Lojas', '99001-101', 'Admin');

-- Cidade: Santa Cruz do Sul, Rio Grande do Sul
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (689, 177, 'Bairro Central', 'CENTRO', TO_DATE('2022-06-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (690, 177, 'Bairro Novo', 'NORTE', TO_DATE('2022-01-10', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 697 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (697, 689, 'Avenida Principal', '96800-000', 'Admin');

-- Logradouro 698 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (698, 689, 'Rua do Comércio', '96800-001', 'Admin');

-- Logradouro 699 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (699, 690, 'Avenida dos Novatos', '96801-100', 'Admin');

-- Logradouro 700 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (700, 690, 'Rua das Lojas', '96801-101', 'Admin');
-- Cidade: Caxias do Sul, Rio Grande do Sul
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (701, 178, 'Bairro Central', 'CENTRO', TO_DATE('2022-07-01', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (702, 178, 'Bairro Novo', 'NORTE', TO_DATE('2022-02-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 701 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (701, 701, 'Avenida Principal', '95000-000', 'Admin');

-- Logradouro 702 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (702, 701, 'Rua do Comércio', '95000-001', 'Admin');

-- Logradouro 703 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (703, 702, 'Avenida dos Novatos', '95001-100', 'Admin');

-- Logradouro 704 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (704, 702, 'Rua das Lojas', '95001-101', 'Admin');

-- Cidade: Erechim, Rio Grande do Sul
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (705, 179, 'Bairro Central', 'CENTRO', TO_DATE('2022-07-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (706, 179, 'Bairro Novo', 'NORTE', TO_DATE('2022-02-25', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 705 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (705, 705, 'Avenida Principal', '99700-000', 'Admin');

-- Logradouro 706 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (706, 705, 'Rua do Comércio', '99700-001', 'Admin');

-- Logradouro 707 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (707, 706, 'Avenida dos Novatos', '99701-100', 'Admin');

-- Logradouro 708 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (708, 706, 'Rua das Lojas', '99701-101', 'Admin');

-- Cidade: Bento Gonçalves, Rio Grande do Sul
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (709, 180, 'Bairro Central', 'CENTRO', TO_DATE('2022-07-30', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (710, 180, 'Bairro Novo', 'NORTE', TO_DATE('2022-03-10', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 709 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (709, 709, 'Avenida Principal', '95700-000', 'Admin');

-- Logradouro 710 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (710, 709, 'Rua do Comércio', '95700-001', 'Admin');

-- Logradouro 711 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (711, 710, 'Avenida dos Novatos', '95701-100', 'Admin');

-- Logradouro 712 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (712, 710, 'Rua das Lojas', '95701-101', 'Admin');

-- Cidade: Lajeado, Rio Grande do Sul
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (713, 181, 'Bairro Central', 'CENTRO', TO_DATE('2022-08-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (714, 181, 'Bairro Novo', 'NORTE', TO_DATE('2022-03-25', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 713 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (713, 713, 'Avenida Principal', '95900-000', 'Admin');

-- Logradouro 714 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (714, 713, 'Rua do Comércio', '95900-001', 'Admin');

-- Logradouro 715 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (715, 714, 'Avenida dos Novatos', '95901-100', 'Admin');

-- Logradouro 716 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (716, 714, 'Rua das Lojas', '95901-101', 'Admin');
-- Cidade: Blumenau, Santa Catarina
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (717, 182, 'Bairro Central', 'CENTRO', TO_DATE('2022-08-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (718, 182, 'Bairro Novo', 'NORTE', TO_DATE('2022-03-30', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 717 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (717, 717, 'Avenida Principal', '89000-000', 'Admin');

-- Logradouro 718 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (718, 717, 'Rua do Comércio', '89000-001', 'Admin');

-- Logradouro 719 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (719, 718, 'Avenida dos Novatos', '89001-100', 'Admin');

-- Logradouro 720 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (720, 718, 'Rua das Lojas', '89001-101', 'Admin');

-- Cidade: Chapecó, Santa Catarina
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (721, 183, 'Bairro Central', 'CENTRO', TO_DATE('2022-08-30', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (722, 183, 'Bairro Novo', 'NORTE', TO_DATE('2022-04-10', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 721 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (721, 721, 'Avenida Principal', '89800-000', 'Admin');

-- Logradouro 722 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (722, 721, 'Rua do Comércio', '89800-001', 'Admin');

-- Logradouro 723 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (723, 722, 'Avenida dos Novatos', '89801-100', 'Admin');

-- Logradouro 724 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (724, 722, 'Rua das Lojas', '89801-101', 'Admin');

-- Cidade: Criciúma, Santa Catarina
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (725, 184, 'Bairro Central', 'CENTRO', TO_DATE('2022-09-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (726, 184, 'Bairro Novo', 'NORTE', TO_DATE('2022-04-20', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 725 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (725, 725, 'Avenida Principal', '88800-000', 'Admin');

-- Logradouro 726 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (726, 725, 'Rua do Comércio', '88800-001', 'Admin');

-- Logradouro 727 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (727, 726, 'Avenida dos Novatos', '88801-100', 'Admin');

-- Logradouro 728 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (728, 726, 'Rua das Lojas', '88801-101', 'Admin');

-- Cidade: Itajaí, Santa Catarina
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (729, 185, 'Bairro Central', 'CENTRO', TO_DATE('2022-10-01', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (730, 185, 'Bairro Novo', 'NORTE', TO_DATE('2022-04-30', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 729 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (729, 729, 'Avenida Principal', '88300-000', 'Admin');

-- Logradouro 730 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (730, 729, 'Rua do Comércio', '88300-001', 'Admin');

-- Logradouro 731 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (731, 730, 'Avenida dos Novatos', '88301-100', 'Admin');

-- Logradouro 732 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (732, 730, 'Rua das Lojas', '88301-101', 'Admin');
-- Cidade: São Paulo, São Paulo
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (741, 188, 'Bairro Central', 'CENTRO', TO_DATE('2022-10-01', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (742, 188, 'Bairro Novo', 'NORTE', TO_DATE('2022-05-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 741 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (741, 741, 'Avenida Principal', '01000-000', 'Admin');

-- Logradouro 742 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (742, 741, 'Rua do Comércio', '01000-001', 'Admin');

-- Logradouro 743 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (743, 742, 'Avenida dos Novatos', '01001-100', 'Admin');

-- Logradouro 744 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (744, 742, 'Rua das Lojas', '01001-101', 'Admin');

-- Cidade: Campinas, São Paulo
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (745, 189, 'Bairro Central', 'CENTRO', TO_DATE('2022-10-03', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (746, 189, 'Bairro Novo', 'NORTE', TO_DATE('2022-05-20', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 745 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (745, 745, 'Avenida Principal', '13000-000', 'Admin');

-- Logradouro 746 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (746, 745, 'Rua do Comércio', '13000-001', 'Admin');

-- Logradouro 747 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (747, 746, 'Avenida dos Novatos', '13001-100', 'Admin');

-- Logradouro 748 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (748, 746, 'Rua das Lojas', '13001-101', 'Admin');

-- Cidade: Santos, São Paulo
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (749, 190, 'Bairro Central', 'CENTRO', TO_DATE('2022-10-05', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (750, 190, 'Bairro Novo', 'NORTE', TO_DATE('2022-05-25', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 749 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (749, 749, 'Avenida Principal', '11000-000', 'Admin');

-- Logradouro 750 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (750, 749, 'Rua do Comércio', '11000-001', 'Admin');

-- Logradouro 751 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (751, 750, 'Avenida dos Novatos', '11001-100', 'Admin');

-- Logradouro 752 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (752, 750, 'Rua das Lojas', '11001-101', 'Admin');

-- Cidade: Ribeirão Preto, São Paulo
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (753, 191, 'Bairro Central', 'CENTRO', TO_DATE('2022-10-07', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (754, 191, 'Bairro Novo', 'NORTE', TO_DATE('2022-05-30', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 753 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (753, 753, 'Avenida Principal', '14000-000', 'Admin');

-- Logradouro 754 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (754, 753, 'Rua do Comércio', '14000-001', 'Admin');

-- Logradouro 755 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (755, 754, 'Avenida dos Novatos', '14001-100', 'Admin');

-- Logradouro 756 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (756, 754, 'Rua das Lojas', '14001-101', 'Admin');
-- Cidade: São Bernardo do Campo, São Paulo
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (757, 192, 'Bairro Central', 'CENTRO', TO_DATE('2022-10-09', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (758, 192, 'Bairro Novo', 'NORTE', TO_DATE('2022-06-05', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 757 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (757, 757, 'Avenida Principal', '09700-000', 'Admin');

-- Logradouro 758 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (758, 757, 'Rua do Comércio', '09700-001', 'Admin');

-- Logradouro 759 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (759, 758, 'Avenida dos Novatos', '09701-100', 'Admin');

-- Logradouro 760 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (760, 758, 'Rua das Lojas', '09701-101', 'Admin');

-- Cidade: Sorocaba, São Paulo
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (761, 193, 'Bairro Central', 'CENTRO', TO_DATE('2022-10-11', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (762, 193, 'Bairro Novo', 'NORTE', TO_DATE('2022-06-10', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 761 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (761, 761, 'Avenida Principal', '18000-000', 'Admin');

-- Logradouro 762 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (762, 761, 'Rua do Comércio', '18000-001', 'Admin');

-- Logradouro 763 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (763, 762, 'Avenida dos Novatos', '18001-100', 'Admin');

-- Logradouro 764 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (764, 762, 'Rua das Lojas', '18001-101', 'Admin');

-- Cidade: São Vicente, São Paulo
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (765, 194, 'Bairro Central', 'CENTRO', TO_DATE('2022-10-13', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (766, 194, 'Bairro Novo', 'NORTE', TO_DATE('2022-06-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 765 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (765, 765, 'Avenida Principal', '11300-000', 'Admin');

-- Logradouro 766 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (766, 765, 'Rua do Comércio', '11300-001', 'Admin');

-- Logradouro 767 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (767, 766, 'Avenida dos Novatos', '11301-100', 'Admin');

-- Logradouro 768 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (768, 766, 'Rua das Lojas', '11301-101', 'Admin');
-- Cidade: Itaquaquecetuba, São Paulo
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (769, 195, 'Bairro Central', 'CENTRO', TO_DATE('2022-10-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (770, 195, 'Bairro Novo', 'NORTE', TO_DATE('2022-06-20', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 769 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (769, 769, 'Avenida Principal', '08500-000', 'Admin');

-- Logradouro 770 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (770, 769, 'Rua do Comércio', '08500-001', 'Admin');

-- Logradouro 771 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (771, 770, 'Avenida dos Novatos', '08501-100', 'Admin');

-- Logradouro 772 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (772, 770, 'Rua das Lojas', '08501-101', 'Admin');

-- Cidade: Franco da Rocha, São Paulo
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (773, 196, 'Bairro Central', 'CENTRO', TO_DATE('2022-10-18', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (774, 196, 'Bairro Novo', 'NORTE', TO_DATE('2022-06-25', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 773 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (773, 773, 'Avenida Principal', '07800-000', 'Admin');

-- Logradouro 774 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (774, 773, 'Rua do Comércio', '07800-001', 'Admin');

-- Logradouro 775 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (775, 774, 'Avenida dos Novatos', '07801-100', 'Admin');

-- Logradouro 776 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (776, 774, 'Rua das Lojas', '07801-101', 'Admin');

-- Cidade: Mauá, São Paulo
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (777, 197, 'Bairro Central', 'CENTRO', TO_DATE('2022-10-20', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (778, 197, 'Bairro Novo', 'NORTE', TO_DATE('2022-06-30', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 777 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (777, 777, 'Avenida Principal', '09300-000', 'Admin');

-- Logradouro 778 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (778, 777, 'Rua do Comércio', '09300-001', 'Admin');

-- Logradouro 779 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (779, 778, 'Avenida dos Novatos', '09301-100', 'Admin');

-- Logradouro 780 (para Bairro Novo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (780, 778, 'Rua das Lojas', '09301-101', 'Admin');
-- Cidade: Itabaiana, Sergipe
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (3, 174, 'Bairro Central', 'CENTRO', TO_DATE('2022-04-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (4, 174, 'Bairro Sul', 'SUL', TO_DATE('2022-04-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 5 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (5, 3, 'Avenida Principal', '49500-001', 'Admin');

-- Logradouro 6 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (6, 3, 'Rua da Praça', '49500-002', 'Admin');

-- Logradouro 7 (para Bairro Sul)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (7, 4, 'Avenida dos Comerciantes', '49501-100', 'Admin');

-- Logradouro 8 (para Bairro Sul)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (8, 4, 'Rua das Lojas', '49501-101', 'Admin');
-- Cidade: Aracaju, Sergipe
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (1, 173, 'Bairro Centro', 'CENTRO', TO_DATE('2022-04-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (2, 173, 'Bairro Norte', 'NORTE', TO_DATE('2022-04-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 1 (para Bairro Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (1, 1, 'Avenida Principal', '49000-001', 'Admin');

-- Logradouro 2 (para Bairro Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (2, 1, 'Rua do Comércio', '49000-002', 'Admin');

-- Logradouro 3 (para Bairro Norte)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (3, 2, 'Avenida dos Moradores', '49001-100', 'Admin');

-- Logradouro 4 (para Bairro Norte)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (4, 2, 'Rua das Lojas', '49001-101', 'Admin');
-- Cidade: Estância, Sergipe
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (5, 175, 'Bairro Central', 'CENTRO', TO_DATE('2022-04-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (6, 175, 'Bairro Norte', 'NORTE', TO_DATE('2022-04-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 9 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (9, 5, 'Avenida Principal', '49200-001', 'Admin');

-- Logradouro 10 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (10, 5, 'Rua do Comércio', '49200-002', 'Admin');

-- Logradouro 11 (para Bairro Norte)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (11, 6, 'Avenida dos Moradores', '49201-100', 'Admin');

-- Logradouro 12 (para Bairro Norte)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (12, 6, 'Rua das Lojas', '49201-101', 'Admin');
-- Cidade: Lagarto, Sergipe
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (7, 176, 'Bairro Centro', 'CENTRO', TO_DATE('2022-04-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (8, 176, 'Bairro Sul', 'SUL', TO_DATE('2022-04-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 13 (para Bairro Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (13, 7, 'Avenida Principal', '49300-001', 'Admin');

-- Logradouro 14 (para Bairro Centro)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (14, 7, 'Rua da Praça', '49300-002', 'Admin');

-- Logradouro 15 (para Bairro Sul)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (15, 8, 'Avenida dos Comerciantes', '49301-100', 'Admin');

-- Logradouro 16 (para Bairro Sul)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (16, 8, 'Rua das Lojas', '49301-101', 'Admin');
-- Cidade: Tobias Barreto, Sergipe
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (9, 177, 'Bairro Central', 'CENTRO', TO_DATE('2022-04-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (10, 177, 'Bairro Norte', 'NORTE', TO_DATE('2022-04-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 17 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (17, 9, 'Avenida Principal', '49500-001', 'Admin');

-- Logradouro 18 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (18, 9, 'Rua do Comércio', '49500-002', 'Admin');

-- Logradouro 19 (para Bairro Norte)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (19, 10, 'Avenida dos Moradores', '49501-100', 'Admin');

-- Logradouro 20 (para Bairro Norte)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (20, 10, 'Rua das Lojas', '49501-101', 'Admin');
-- Cidade: Nossa Senhora do Socorro, Sergipe
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (15, 180, 'Bairro Central', 'CENTRO', TO_DATE('2022-04-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (16, 180, 'Bairro Leste', 'LESTE', TO_DATE('2022-04-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 29 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (29, 15, 'Avenida Principal', '49160-001', 'Admin');

-- Logradouro 30 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (30, 15, 'Rua do Comércio', '49160-002', 'Admin');

-- Logradouro 31 (para Bairro Leste)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (31, 16, 'Avenida dos Moradores', '49161-100', 'Admin');

-- Logradouro 32 (para Bairro Leste)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (32, 16, 'Rua das Lojas', '49161-101', 'Admin');
-- Cidade: Propriá, Sergipe
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (17, 181, 'Bairro Central', 'CENTRO', TO_DATE('2022-04-16', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (18, 181, 'Bairro Oeste', 'OESTE', TO_DATE('2022-04-16', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 33 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (33, 17, 'Avenida Principal', '49900-001', 'Admin');

-- Logradouro 34 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (34, 17, 'Rua do Comércio', '49900-002', 'Admin');

-- Logradouro 35 (para Bairro Oeste)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (35, 18, 'Avenida dos Moradores', '49901-100', 'Admin');

-- Logradouro 36 (para Bairro Oeste)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (36, 18, 'Rua das Lojas', '49901-101', 'Admin');
-- Cidade: Palmas, Tocantins
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (1, 183, 'Bairro Central', 'CENTRO', TO_DATE('2022-05-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (2, 183, 'Bairro Norte', 'NORTE', TO_DATE('2022-05-10', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 1 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (1, 1, 'Avenida Principal', '77000-001', 'Admin');

-- Logradouro 2 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (2, 1, 'Rua do Comércio', '77000-002', 'Admin');

-- Logradouro 3 (para Bairro Norte)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (3, 2, 'Avenida dos Moradores', '77001-100', 'Admin');

-- Logradouro 4 (para Bairro Norte)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (4, 2, 'Rua das Lojas', '77001-101', 'Admin');
-- Cidade: Araguaína, Tocantins
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (3, 184, 'Bairro Central', 'CENTRO', TO_DATE('2022-05-12', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (4, 184, 'Bairro Sul', 'SUL', TO_DATE('2022-05-12', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 5 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (5, 3, 'Avenida Principal', '77800-001', 'Admin');

-- Logradouro 6 (para Bairro Central)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (6, 3, 'Rua do Comércio', '77800-002', 'Admin');

-- Logradouro 7 (para Bairro Sul)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (7, 4, 'Avenida dos Moradores', '77801-100', 'Admin');

-- Logradouro 8 (para Bairro Sul)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (8, 4, 'Rua das Lojas', '77801-101', 'Admin');
-- Cidade: Porto Nacional, Tocantins
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (5, 185, 'Bairro Central', 'CENTRO', TO_DATE('2022-06-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (6, 185, 'Bairro Sul', 'SUL', TO_DATE('2022-06-10', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 9 (para Bairro Central de Porto Nacional)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (9, 5, 'Avenida Principal', '77500-001', 'Admin');

-- Logradouro 10 (para Bairro Central de Porto Nacional)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (10, 5, 'Rua do Comércio', '77500-002', 'Admin');

-- Logradouro 11 (para Bairro Sul de Porto Nacional)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (11, 6, 'Avenida dos Moradores', '77501-100', 'Admin');

-- Logradouro 12 (para Bairro Sul de Porto Nacional)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (12, 6, 'Rua das Lojas', '77501-101', 'Admin');
-- Cidade: Gurupi, Tocantins
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (7, 186, 'Bairro Central', 'CENTRO', TO_DATE('2022-07-20', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (8, 186, 'Bairro Norte', 'NORTE', TO_DATE('2022-07-20', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 13 (para Bairro Central de Gurupi)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (13, 7, 'Avenida Principal', '77400-001', 'Admin');

-- Logradouro 14 (para Bairro Central de Gurupi)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (14, 7, 'Rua do Comércio', '77400-002', 'Admin');

-- Logradouro 15 (para Bairro Norte de Gurupi)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (15, 8, 'Avenida dos Moradores', '77401-100', 'Admin');

-- Logradouro 16 (para Bairro Norte de Gurupi)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (16, 8, 'Rua das Lojas', '77401-101', 'Admin');
-- Cidade: Dianópolis, Tocantins
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (9, 187, 'Bairro Central', 'CENTRO', TO_DATE('2022-08-15', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (10, 187, 'Bairro Sul', 'SUL', TO_DATE('2022-08-15', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 17 (para Bairro Central de Dianópolis)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (17, 9, 'Avenida Principal', '77300-001', 'Admin');

-- Logradouro 18 (para Bairro Central de Dianópolis)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (18, 9, 'Rua do Comércio', '77300-002', 'Admin');

-- Logradouro 19 (para Bairro Sul de Dianópolis)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (19, 10, 'Avenida dos Moradores', '77301-100', 'Admin');

-- Logradouro 20 (para Bairro Sul de Dianópolis)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (20, 10, 'Rua das Lojas', '77301-101', 'Admin');
-- Cidade: Taguatinga, Tocantins
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (11, 188, 'Bairro Central', 'CENTRO', TO_DATE('2022-09-25', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (12, 188, 'Bairro Norte', 'NORTE', TO_DATE('2022-09-25', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 21 (para Bairro Central de Taguatinga)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (21, 11, 'Avenida Principal', '77320-001', 'Admin');

-- Logradouro 22 (para Bairro Central de Taguatinga)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (22, 11, 'Rua do Comércio', '77320-002', 'Admin');

-- Logradouro 23 (para Bairro Norte de Taguatinga)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (23, 12, 'Avenida dos Moradores', '77321-100', 'Admin');

-- Logradouro 24 (para Bairro Norte de Taguatinga)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (24, 12, 'Rua das Lojas', '77321-101', 'Admin');
-- Cidade: Colinas do Tocantins, Tocantins
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (15, 190, 'Bairro Central', 'CENTRO', TO_DATE('2022-12-05', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (16, 190, 'Bairro Norte', 'NORTE', TO_DATE('2022-12-05', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 29 (para Bairro Central de Colinas do Tocantins)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (29, 15, 'Avenida Principal', '77700-001', 'Admin');

-- Logradouro 30 (para Bairro Central de Colinas do Tocantins)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (30, 15, 'Rua do Comércio', '77700-002', 'Admin');

-- Logradouro 31 (para Bairro Norte de Colinas do Tocantins)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (31, 16, 'Avenida dos Moradores', '77701-100', 'Admin');

-- Logradouro 32 (para Bairro Norte de Colinas do Tocantins)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (32, 16, 'Rua das Lojas', '77701-101', 'Admin');
-- Cidade: Paraíso do Tocantins, Tocantins
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (19, 192, 'Bairro Central', 'CENTRO', TO_DATE('2023-02-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (20, 192, 'Bairro Norte', 'NORTE', TO_DATE('2023-02-10', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 37 (para Bairro Central de Paraíso do Tocantins)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (37, 19, 'Avenida Principal', '77600-001', 'Admin');

-- Logradouro 38 (para Bairro Central de Paraíso do Tocantins)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (38, 19, 'Rua do Comércio', '77600-002', 'Admin');

-- Logradouro 39 (para Bairro Norte de Paraíso do Tocantins)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (39, 20, 'Avenida dos Moradores', '77601-100', 'Admin');

-- Logradouro 40 (para Bairro Norte de Paraíso do Tocantins)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (40, 20, 'Rua das Lojas', '77601-101', 'Admin');
-- Cidade: Brasília, Distrito Federal
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (23, 194, 'Setor Central', 'CENTRO', TO_DATE('2023-04-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (24, 194, 'Setor Norte', 'NORTE', TO_DATE('2023-04-10', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros
-- Logradouro 45 (para Setor Central de Brasília)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (45, 23, 'Avenida Principal', '70000-001', 'Admin');

-- Logradouro 46 (para Setor Central de Brasília)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (46, 23, 'Rua do Comércio', '70000-002', 'Admin');

-- Logradouro 47 (para Setor Norte de Brasília)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (47, 24, 'Avenida dos Moradores', '70001-100', 'Admin');

-- Logradouro 48 (para Setor Norte de Brasília)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (48, 24, 'Rua das Lojas', '70001-101', 'Admin');
-- Cidade: Taguatinga, Distrito Federal
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (25, 195, 'Bairro Central', 'CENTRO', TO_DATE('2023-04-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (26, 195, 'Bairro Sul', 'SUL', TO_DATE('2023-04-10', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros de Taguatinga
-- Logradouro 49 (para Bairro Central de Taguatinga)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (49, 25, 'Avenida Principal', '72100-001', 'Admin');

-- Logradouro 50 (para Bairro Central de Taguatinga)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (50, 25, 'Rua do Comércio', '72100-002', 'Admin');

-- Logradouro 51 (para Bairro Sul de Taguatinga)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (51, 26, 'Avenida dos Moradores', '72101-100', 'Admin');

-- Logradouro 52 (para Bairro Sul de Taguatinga)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (52, 26, 'Rua das Lojas', '72101-101', 'Admin');

-- Cidade: Gama, Distrito Federal
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (27, 196, 'Setor Central', 'CENTRO', TO_DATE('2023-04-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (28, 196, 'Setor Norte', 'NORTE', TO_DATE('2023-04-10', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros de Gama
-- Logradouro 53 (para Setor Central de Gama)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (53, 27, 'Avenida Principal', '72400-001', 'Admin');

-- Logradouro 54 (para Setor Central de Gama)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (54, 27, 'Rua do Comércio', '72400-002', 'Admin');

-- Logradouro 55 (para Setor Norte de Gama)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (55, 28, 'Avenida dos Moradores', '72401-100', 'Admin');

-- Logradouro 56 (para Setor Norte de Gama)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (56, 28, 'Rua das Lojas', '72401-101', 'Admin');

-- Cidade: Sobradinho, Distrito Federal
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (29, 197, 'Bairro Central', 'CENTRO', TO_DATE('2023-04-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (30, 197, 'Bairro Leste', 'LESTE', TO_DATE('2023-04-10', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros de Sobradinho
-- Logradouro 57 (para Bairro Central de Sobradinho)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (57, 29, 'Avenida Principal', '73000-001', 'Admin');

-- Logradouro 58 (para Bairro Central de Sobradinho)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (58, 29, 'Rua do Comércio', '73000-002', 'Admin');

-- Logradouro 59 (para Bairro Leste de Sobradinho)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (59, 30, 'Avenida dos Moradores', '73001-100', 'Admin');

-- Logradouro 60 (para Bairro Leste de Sobradinho)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (60, 30, 'Rua das Lojas', '73001-101', 'Admin');
-- Cidade: Paranoá, Distrito Federal
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (31, 198, 'Setor Central', 'CENTRO', TO_DATE('2023-04-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (32, 198, 'Setor Norte', 'NORTE', TO_DATE('2023-04-10', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros de Paranoá
-- Logradouro 61 (para Setor Central de Paranoá)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (61, 31, 'Avenida Principal', '71570-001', 'Admin');

-- Logradouro 62 (para Setor Central de Paranoá)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (62, 31, 'Rua do Comércio', '71570-002', 'Admin');

-- Logradouro 63 (para Setor Norte de Paranoá)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (63, 32, 'Avenida dos Moradores', '71571-100', 'Admin');

-- Logradouro 64 (para Setor Norte de Paranoá)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (64, 32, 'Rua das Lojas', '71571-101', 'Admin');

-- Cidade: Planaltina, Distrito Federal
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (33, 199, 'Setor Central', 'CENTRO', TO_DATE('2023-04-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (34, 199, 'Setor Sul', 'SUL', TO_DATE('2023-04-10', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros de Planaltina
-- Logradouro 65 (para Setor Central de Planaltina)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (65, 33, 'Avenida Principal', '73300-001', 'Admin');

-- Logradouro 66 (para Setor Central de Planaltina)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (66, 33, 'Rua do Comércio', '73300-002', 'Admin');

-- Logradouro 67 (para Setor Sul de Planaltina)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (67, 34, 'Avenida dos Moradores', '73301-100', 'Admin');

-- Logradouro 68 (para Setor Sul de Planaltina)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (68, 34, 'Rua das Lojas', '73301-101', 'Admin');

-- Cidade: Riacho Fundo, Distrito Federal
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (35, 200, 'Setor Central', 'CENTRO', TO_DATE('2023-04-10', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (36, 200, 'Setor Leste', 'LESTE', TO_DATE('2023-04-10', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros do Riacho Fundo
-- Logradouro 69 (para Setor Central do Riacho Fundo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (69, 35, 'Avenida Principal', '73350-001', 'Admin');

-- Logradouro 70 (para Setor Central do Riacho Fundo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (70, 35, 'Rua do Comércio', '73350-002', 'Admin');

-- Logradouro 71 (para Setor Leste do Riacho Fundo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (71, 36, 'Avenida dos Moradores', '73351-100', 'Admin');

-- Logradouro 72 (para Setor Leste do Riacho Fundo)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (72, 36, 'Rua das Lojas', '73351-101', 'Admin');
-- Cidade: Lago Norte, Distrito Federal
-- Bairro 1
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (39, 202, 'Setor Residencial', 'RESIDENCIAL', TO_DATE('2023-04-12', 'YYYY-MM-DD'), 'Admin');

-- Bairro 2
INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario)
VALUES (40, 202, 'Setor Comercial', 'COMERCIAL', TO_DATE('2023-04-12', 'YYYY-MM-DD'), 'Admin');

-- Associação de logradouros fictícios para os bairros de Lago Norte
-- Logradouro 77 (para Setor Residencial de Lago Norte)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (77, 39, 'Avenida dos Moradores', '71505-001', 'Admin');

-- Logradouro 78 (para Setor Residencial de Lago Norte)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (78, 39, 'Rua das Residências', '71505-002', 'Admin');

-- Logradouro 79 (para Setor Comercial de Lago Norte)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (79, 40, 'Avenida do Comércio', '71506-100', 'Admin');

-- Logradouro 80 (para Setor Comercial de Lago Norte)
INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario)
VALUES (80, 40, 'Rua das Lojas', '71506-101', 'Admin');
-- Vamos inserir alguns funcionarios
--
INSERT INTO T_RHSTU_FUNCIONARIO
(
ID_FUNC,
ID_SUPERIOR,
NM_FUNC,
DS_CARGO,
DT_NASCIMENTO,
VL_SALARIO,
NR_RG,
NR_CPF,
ST_FUNC,
DT_CADASTRO,
NM_USUARIO
)
VALUES
(
SQ_RHSTU_FUNC.NEXTVAL,
null,
'Oivlas Sakspildap',
'Presidente',
TO_DATE( '18/05/2000' , 'DD/MM/YYYY'),
65000,
176888772,
82737378312,
'A',
SYSDATE,
USER
);


INSERT INTO T_RHSTU_MEDICO
(
ID_FUNC,
NR_CRM,
DS_ESPECIALIDADE,
DT_CADASTRO,
NM_USUARIO
)
VALUES
(
SQ_RHSTU_FUNC.CURRVAL,
234765,
'Neuro CirugiÃ£o',
SYSDATE,
USER
);

--
-- Confirma as transaÃ§Ãµes pendentes
--
commit;


-- Diretor Transporte
INSERT INTO T_RHSTU_FUNCIONARIO
(
ID_FUNC,
ID_SUPERIOR,
NM_FUNC,
DS_CARGO,
DT_NASCIMENTO,
VL_SALARIO,
NR_RG,
NR_CPF,
ST_FUNC,
DT_CADASTRO,
NM_USUARIO
)
VALUES
(
SQ_RHSTU_FUNC.NEXTVAL,
1,
'Monica Julio',
'Diretora de Transporte',
TO_DATE( '11/11/1995' , 'DD/MM/YYYY'),
33000,
324237689,
023948785,
'A',
SYSDATE,
USER
);

-- Funcionario motorista

INSERT INTO T_RHSTU_FUNCIONARIO
(
ID_FUNC,
ID_SUPERIOR,
NM_FUNC,
DS_CARGO,
DT_NASCIMENTO,
VL_SALARIO,
NR_RG,
NR_CPF,
ST_FUNC,
DT_CADASTRO,
NM_USUARIO
)
VALUES
(
SQ_RHSTU_FUNC.NEXTVAL,
2,
'Sanoj Arievilo',
'Motorista de AmbulÃ¢ncia',
TO_DATE( '01/01/1940' , 'DD/MM/YYYY'),
15700,
13213213,
77767,
'A',
SYSDATE,
USER
);

 
INSERT INTO T_RHSTU_MOTORISTA
(
ID_FUNC,
NR_CNH,
NM_CATEGORIA_CNH,
DT_VALIDADE_CNH,
DT_CADASTRO,
NM_USUARIO
)
VALUES
(
SQ_RHSTU_FUNC.CURRVAL,
'12312312',
'D',
TO_DATE( '01/01/2029' , 'DD/MM/YYYY'),
SYSDATE,
USER
);

COMMIT;



-- Funcionario Alexandre

INSERT INTO T_RHSTU_FUNCIONARIO
(
ID_FUNC,
ID_SUPERIOR,
NM_FUNC,
DS_CARGO,
DT_NASCIMENTO,
VL_SALARIO,
NR_RG,
NR_CPF,
ST_FUNC,
DT_CADASTRO,
NM_USUARIO
)
VALUES
(
SQ_RHSTU_FUNC.NEXTVAL,
1,
'Erdnaxela Said ed Susej',
'Diretor Conselheiro',
TO_DATE( '25/12/1990' , 'DD/MM/YYYY'),
51000,
213124,
2438553,
'A',
SYSDATE,
USER
);
-- Declaração do loop
-- Declaração do loop
-- Declaração do loop
DECLARE
   v_num_pacientes NUMBER := 400000;
BEGIN
   FOR i IN 1..v_num_pacientes LOOP
      INSERT INTO t_rhstu_paciente (id_paciente, nm_paciente, nr_cpf, nm_rg, dt_nascimento, fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso, dt_cadastro, nm_usuario)
      VALUES (i, 'Nome do Paciente ' || i, 12345678900 + i, 'RG' || i, TO_DATE('1980-01-01', 'YYYY-MM-DD'), 'M', 'Ensino Médio', 'Solteiro', 'A+', 170.0 + (i MOD 30), 70.0 + (i MOD 50), SYSDATE, 'Admin');
      INSERT INTO t_rhstu_endereco (id_paciente, id_logradouro, dt_cadastro, nm_usuario)
      SELECT i, id_logradouro, SYSDATE, 'Admin'
      FROM (
         SELECT id_logradouro
         FROM t_rhstu_logradouro
         WHERE ROWNUM = 1 + MOD(i, (SELECT COUNT(*) FROM t_rhstu_logradouro))
      );
   END LOOP;
   --COMMIT;
END;
/









COMMIT;
