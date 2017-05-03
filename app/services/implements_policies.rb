module ImplementsPolicies
  def pre_method_hooks
    policies.map do |klass|
      proc { klass.new(context).call }
    end
  end
end
