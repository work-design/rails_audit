Rails.application.routes.draw do

  scope ':audited_type/:audited_id', module: 'audit/admin', defaults: { namespace: 'admin', business: 'audit' } do
    resources :audits, only: [:index]
  end

  scope ':approving_type/:approving_id', module: 'audit/admin', defaults: { namespace: 'admin', business: 'audit' } do
    resources :approvals, only: [:index]
  end

  scope :admin, module: 'audit/admin', as: :admin, defaults: { namespace: 'admin', business: 'audit' } do
    resources :approvals, except: [:index, :new, :create]
    scope path: ':verifiable_type/:verifiable_id' do
      resources :verifiers do
        collection do
          get :members
        end
      end
    end
    scope path: ':verified_type/:verified_id' do
      resources :verifications
    end
  end

end
