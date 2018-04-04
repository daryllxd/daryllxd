# frozen_string_literal: true

class HappyPath
  include HasSteps

  def steps
    [
      proc { first_step },
      proc { second_step }
    ]
  end

  def first_step
    SuccessfulOperation.new
  end

  def second_step
    SuccessfulOperation.new
  end

  def success_return_value
    'THE_RETURN_VALUE'
  end
end

RSpec.describe HasSteps do
  context 'happy path' do
    it 'executes each of the steps and returns the success_return_value' do
      expect_any_instance_of(HappyPath).to receive(:first_step).and_return(SuccessfulOperation.new)
      expect_any_instance_of(HappyPath).to receive(:second_step).and_return(SuccessfulOperation.new)

      result = HappyPath.new

      expect(result.call).to eq('THE_RETURN_VALUE')
    end
  end
end

class NoSteps
  include HasSteps
end

class NoSuccessReturnValue
  include HasSteps

  def steps
    []
  end
end

RSpec.describe HasSteps do
  context 'missing methods' do
    it 'missing `steps` method: raises an error saying there are no steps' do
      result = NoSteps.new

      expect { result.call }.to raise_error(NotImplementedError)
      expect { result.call }.to raise_error(/Method `steps` is not implemented./)
    end

    it 'missing `success_return_value` method: raises an error saying there are no steps' do
      result = NoSuccessReturnValue.new

      expect { result.call }.to raise_error(NotImplementedError)
      expect { result.call }.to raise_error(/Method `success_return_value` is not implemented./)
    end
  end
end
