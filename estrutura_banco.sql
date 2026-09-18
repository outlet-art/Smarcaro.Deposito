-- TABELA DE USUÁRIOS E PERMISSÕES (RBAC)
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha_hash VARCHAR(255) NOT NULL,
    funcao VARCHAR(30) NOT NULL -- 'ADMIN', 'OPERADOR_GALPAO', 'MOTORISTA', 'MONTADOR'
);

-- PRODUTOS E AS CAIXAS (VOLUMES)
CREATE TABLE produtos (
    id SERIAL PRIMARY KEY,
    sku VARCHAR(50) UNIQUE NOT NULL,
    nome VARCHAR(255) NOT NULL,
    categoria VARCHAR(50) NOT NULL -- 'Móvel' ou 'Decoração'
);

CREATE TABLE volumes_produto (
    id SERIAL PRIMARY KEY,
    produto_id INT REFERENCES produtos(id) ON DELETE CASCADE,
    codigo_barras VARCHAR(100) UNIQUE NOT NULL,
    sequencia_volume VARCHAR(20) NOT NULL, -- Ex: "1 de 3"
    comprimento_cm DECIMAL(10,2) NOT NULL,
    largura_cm DECIMAL(10,2) NOT NULL,
    altura_cm DECIMAL(10,2) NOT NULL,
    peso_kg DECIMAL(10,2) NOT NULL
);

-- EQUIPES E VEÍCULOS
CREATE TABLE veiculos (
    id SERIAL PRIMARY KEY,
    placa VARCHAR(10) UNIQUE NOT NULL,
    modelo VARCHAR(100) NOT NULL,
    capacidade_peso_kg DECIMAL(10,2) NOT NULL,
    capacidade_cubagem_m3 DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'Disponível'
);

CREATE TABLE equipes_entrega (
    id SERIAL PRIMARY KEY,
    veiculo_id INT REFERENCES veiculos(id),
    motorista_nome VARCHAR(150) NOT NULL,
    ajudante_nome VARCHAR(150),
    status VARCHAR(20) DEFAULT 'Disponível'
);

CREATE TABLE montadores (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    bairros_atendimento TEXT[] NOT NULL,
    status VARCHAR(20) DEFAULT 'Disponível'
);

-- PEDIDOS E OPERAÇÃO DE RUA
CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    numero_pedido VARCHAR(50) UNIQUE NOT NULL,
    cliente_nome VARCHAR(255) NOT NULL,
    cliente_whatsapp VARCHAR(20) NOT NULL,
    endereco_bairro VARCHAR(100) NOT NULL,
    endereco_completo TEXT NOT NULL,
    status_pedido VARCHAR(50) DEFAULT 'Aguardando Separação' -- 'Em Rota', 'Entregue', 'Concluído'
);

CREATE TABLE romaneios (
    id SERIAL PRIMARY KEY,
    equipe_id INT REFERENCES equipes_entrega(id),
    data_saida DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'Criado'
);

CREATE TABLE romaneio_pedidos (
    id SERIAL PRIMARY KEY,
    romaneio_id INT REFERENCES romaneios(id) ON DELETE CASCADE,
    pedido_id INT REFERENCES pedidos(id),
    sequencia_entrega INT NOT NULL
);

-- MONITORAMENTO DE MONTAGEM E DEVOLUÇÃO
CREATE TABLE ordens_montagem (
    id SERIAL PRIMARY KEY,
    pedido_id INT REFERENCES pedidos(id) UNIQUE,
    montador_id INT REFERENCES montadores(id),
    status VARCHAR(20) DEFAULT 'Pendente',
    data_agendada DATE,
    foto_comprovacao_url TEXT
);

CREATE TABLE ocorrencias_entrega (
    id SERIAL PRIMARY KEY,
    pedido_id INT REFERENCES pedidos(id),
    motivo_recusa TEXT NOT NULL,
    foto_avaria_url TEXT,
    status_retorno VARCHAR(30) DEFAULT 'Retornando ao Depósito'
);
