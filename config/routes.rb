Rails.application.routes.draw do

  scope ':audited_type/:audited_id', module: 'audit/admin' do
    resources :audits, only: ['index']
  end

  scope ':checking_type/:checking_id', module: 'audit/admin' do
    resources :checks
    resources :check_settings
  end

end
