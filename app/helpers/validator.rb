# Função de validação baseada em regex para a sigla da moeda
def validate_currency_code(currency_code)
  pattern = /^[a-zA-Z]{3,4}$/
  !!(currency_code =~ pattern)
end

# Função de validação de valor convertido
def validate_amount(amount)
  amount_str = amount.to_s
  pattern = /^\d+(\.\d+)?$/
  !!(amount_str =~ pattern)
end
