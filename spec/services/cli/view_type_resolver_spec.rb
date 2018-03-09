# frozen_string_literal: true

RSpec.describe Cli::ViewTypeResolver, type: :service do
  context 'happy path' do
    context "'t'" do
      it 'resolves to ActivityTagBreakdown' do
        view_type = execute.call(view_type_string: 't')

        expect(view_type).to eq(Pomodoros::Presenters::ActivityTagBreakdown)
      end

      context 'else case' do
        it 'resolves to ForDateRange' do
          view_type = execute.call(view_type_string: nil)

          expect(view_type).to eq(Pomodoros::Presenters::ForDateRange)
        end
      end
    end
  end
end
