# RailsAudit

Unlike [audited](https://github.com/collectiveidea/audited) and [paper_trail](https://github.com/airblade/paper_trail) etc. These model audit tools use model callbacks to record every changes.

`rails_audit` record ActiveRecord Model changes in Controllers, it will record context with model changes:

1. controller
2. action
3. request.remote_ip
4. current_operator
5. any other info you want to record..

### Model style audit VS controller style audit

| Model Style Audit | Controller style Audit |
| --- | --- |
| Record every changes | Record only when you marked |
| use model callback, can skip by the data persistence not commit callback | No model callback |
| use thread variables delivery state from controller to model | Just add variables you can get in controller |

## Usage

### in Model
1. include Audited

```ruby
class User < ActiveRecord::Base
  include RailsAudit::Audited
  
end

```

### in Controller

```ruby
class UsersController < ApplicationController
  include RailsAudit::Application
  # use after action, will auto record changes by use saved_changes api
  after_action only: [:update, :create, :destroy] do
    mark_audits(User, note: 'note something!', extra: { client_headers: request.headers })
  end
  
end
```

### in View
```ruby
  link_to 'Audits', audits_path('User', user.id), remote: true
```

## 许可证
许可证采用 [LGPL License](https://opensource.org/licenses/LGPL-3.0)
