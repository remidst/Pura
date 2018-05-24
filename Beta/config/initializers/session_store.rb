Rails.application.config.session_store :cookie_store, key: '_beta_session', domain: {
  production: '.colibri.jp',
  development: '.lvh.me'
}.fetch(Rails.env.to_sym, :all)