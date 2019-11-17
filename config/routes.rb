Rails.application.routes.draw do

  scope ':audited_type/:audited_id', module: 'audit/admin' do
    resources :audits, only: [:index]
  end

  scope ':checking_type/:checking_id', module: 'audit/admin' do
    resources :checks
    resources :check_settings
  end
  
  scope ':approving_type/:approving_id', module: 'audit/admin' do
    resources :approvals, only: [:index]
  end

  scope :admin, module: 'audit/admin', as: :admin do
    resources :approvals, except: [:index, :new, :create]
  end

end
