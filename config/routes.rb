Rails.application.routes.draw do
  scope RailsCom.default_routes_scope do
    namespace :auditor, defaults: { business: 'auditor' } do
      scope ':audited_type/:audited_id', module: 'admin', defaults: { namespace: 'admin' } do
        resources :audits, only: [:index]
      end

      scope ':approving_type/:approving_id', module: 'admin', defaults: { namespace: 'admin' } do
        resources :approvals, only: [:index]
      end

      namespace :admin, defaults: { namespace: 'admin' } do
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

      namespace :panel, defaults: { namespace: 'panel' } do
        resources :audits do
          member do
            patch :restore
          end
        end
      end
    end
  end
end
