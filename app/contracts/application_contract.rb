class ApplicationContract < Dry::Validation::Contract
  config.messages.backend = :i18n
  config.messages.load_paths << Rails.root.join('config/locales/en.yml')
end 