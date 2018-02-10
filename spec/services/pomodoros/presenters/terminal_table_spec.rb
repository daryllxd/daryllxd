# frozen_string_literal: true
RSpec.describe Pomodoros::Presenters::TerminalTable do
  context 'present' do
    it 'happy path--it is an interface to creating a TerminalTable' do
      terminal_table = described_class.new(
        title: 'Swag',
        headings: ['Pants', 'Cargo Shorts'],
        rows: [
          [1, 2],
          :separator,
          ['JORTS', 'ARE US']
      ]
      ).present

      expect(terminal_table).to be_a_kind_of(Terminal::Table)
    end
  end
end
