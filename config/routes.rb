Rails.application.routes.draw do

  scope module: 'rails_audit_admin', path: ':auditable_type/:auditable_id' do
    resources :audits, only: ['index']
  end

  scope module: 'rails_audit_admin', path: ':checking_type/:checking_id' do
    resources :checks
    resources :check_settings
  end

end
