======================================================================
MANUAL DE ENGENHARIA DO SISTEMA - SMARCARO.DEPÓSITO
Inspirado no Modelo Casas Bahia | Operação Regional com Frota Própria
======================================================================

1. ARQUITETURA DO BANCO DE DADOS (Como o sistema organiza as informações)
----------------------------------------------------------------------
O sistema não trabalha apenas com o "Produto", ele trabalha com "Volumes" (caixas).
Se um guarda-roupa tem 3 caixas, o banco de dados rastreia o código de barras de cada uma.
As permissões são divididas por funções (RBAC):
- Operador do Galpão: Mexe no estoque e expedição.
- Motorista: Vê rotas e confirma entregas.
- Montador: Vê ordens de serviço da sua região.

2. FLUXO OPERACIONAL POR SETORES (As regras que o Lovable vai desenhar)
----------------------------------------------------------------------
A. SETOR WMS (Depósito e Estoque):
- Checkout de Expedição: O operador bipa caixa por caixa antes do caminhão sair. Se faltar a caixa "3 de 3", o sistema bloqueia o botão "Liberar Veículo para Rota". Isso zera o erro de enviar móveis incompletos.
- Gestão de Estoque: Uma tela com a relação de produtos cadastrados e seus volumes.
- Inventário Rotativo: Tela de auditoria para comparar o que o sistema acha que tem (Sistêmico) com o que foi contado no chão (Físico).
- Relatório de Perdas e Sobras: Painel visual com cards coloridos (Vermelho para caixas sumidas ou quebras/avariadas; Verde para caixas encontradas a mais no galpão).

B. SETOR TMS (Frota e Motoristas na Rua):
- Roteirização Inteligente: O sistema organiza a lista de entregas em ordem lógica de proximidade por bairros (1º, 2º, 3º cliente) para economizar combustível.
- Cubagem e Peso: O sistema calcula o tamanho físico (metros cúbicos) e o peso das caixas para garantir que a carga não ultrapasse o limite do baú do caminhão.
- Aplicativo de Rua: O motorista tem dois botões no celular:
  * "Confirmar Entrega": Abre a câmera para tirar foto do produto na casa do cliente e colher assinatura. Dispara o status "Entregue - Aguardando Montagem".
  * "Registrar Recusa/Avaria": Se o cliente não quiser o produto ou vier quebrado, o motorista registra o motivo e o sistema cancela a montagem na hora, mandando o caminhão para a Doca de Logística Reversa.

C. SETOR DE MONTAGEM (Equipe de Campo):
- Ordem de Serviço (OS): Gerada de forma 100% automática no segundo em que o motorista confirma a entrega. O sistema acha o montador disponível que atende aquele bairro.
- Conclusão: O montador anexa a foto do móvel montado e o cliente assina, mudando o status final do pedido para "Concluído".

3. INDICADORES DE PERFORMANCE (Dashboard de KPIs)
----------------------------------------------------------------------
O painel da diretoria calcula automaticamente três métricas cruciais de mercado:
- Taxa de OTIF: Porcentagem de entregas feitas no prazo E sem nenhuma caixa faltando ou quebrada. Target ideal: acima de 92%.
- Índice de Devoluções: Quantos por cento das vendas voltaram no caminhão. Target ideal: abaixo de 3%.
- Lead Time de Montagem: Média de dias que o cliente espera pelo montador após o produto ser descarregado. Target ideal: até 2 dias.

4. LOGÍSTICA REVERSA (Devoluções)
----------------------------------------------------------------------
Quando uma entrega falha, o produto volta para a "Doca Reversa" do galpão. O operador inspeciona a caixa e decide no sistema:
- Se a caixa voltou intacta (ex: cliente não estava em casa): O produto volta para o saldo de vendas.
- Se a caixa voltou danificada: O produto vai para o status de "Assistência Técnica / Avaria" para não ser vendido por engano para outro cliente.
======================================================================

