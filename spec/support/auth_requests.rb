# frozen_string_literal: true
# def auth_get, auth_patch, auth_put, auth_post, auth_delete
HTTP_VERBS = [:get, :patch, :put, :post, :delete].freeze

HTTP_VERBS.each do |method|
  # Usage:
  # auth_get :create, current_user: User.first, params: { title: 'Lord Swaggetron' }
  define_method "auth_#{method}" do |path, **args|
    infer_user =
      begin
        if args.present? && args[:current_user]
          args[:current_user]
        else
          existing_user
        end
      end

    # Avoid deprecation errors (pre-Rails 5.1)
    # DEPRECATION WARNING: Using positional arguments in functional tests has been deprecated,
    ensured_params = if args.present?
                       args.except(:current_user)
                     else
                       { params: {} }
                     end

    allow(controller).to receive(:ensure_access_token_is_valid).and_return(true)
    allow(controller).to receive(:current_user).and_return(infer_user)
    send(method, path, ensured_params)
  end
end
