Rails.application.routes.draw do

  scope module: 'admin', path: ':auditable_type/:auditable_id' do
    resources :audits, only: ['index']
    scope path: ':checking_type/:checking_id' do
      resources :checks
    end
    resources :check_settings
  end

end
