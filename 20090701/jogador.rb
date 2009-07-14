class JogadorExpulsoException < StandardError; end

class Jogador
  
  attr_accessor :cartoes

  def initialize
    @cartoes = Array.new        
  end

  def cometer_falta(jogador, options = { :tipo => :leve })
    raise JogadorExpulsoException if expulso?
    cartao = cartao_cor(options[:tipo])
    @cartoes.concat(cartao) if cartao
  end

  def expulso?
    @cartoes.include?('vermelho')
  end
  
  protected
  
  def cartao_cor(tipo)
    case tipo
    when :grave then penalidade_grave
    when :gravissima then penalidade_gravissima                   
    end
  end
                              
  def penalidade_grave        
    novos_cartoes = ['amarelo']
    if ja_penalizado?
      novos_cartoes.concat(['vermelho']) 
    end
    novos_cartoes
  end  
  
  def penalidade_gravissima
    ['vermelho'] 
  end
  
  def ja_penalizado?
    @cartoes == ['amarelo']
  end
  
end