Rails.application.routes.draw do

  scope ':auditable_type/:auditable_id', module: 'audit/admin' do
    resources :audits, only: ['index']
  end

  scope ':checking_type/:checking_id', module: 'audit/admin' do
    resources :checks
    resources :check_settings
  end

end
