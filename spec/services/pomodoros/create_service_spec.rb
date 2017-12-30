# frozen_string_literal: true
RSpec.describe Pomodoros::CreateService, type: :service do
  context 'happy path' do
    let!(:programming_activity_tag) { create(:activity_tag, :programming) }
    let!(:daryllxd_activity_tag) { create(:activity_tag, :daryllxd) }

    let!(:created_pomodoro) do
      execute.call(
        duration: 25,
        description: 'Did things',
        tags: [programming_activity_tag, daryllxd_activity_tag]
      )
    end

    it 'creates pomodoros and tags' do
      expect(Pomodoro.count).to eq 1
      expect(created_pomodoro.activity_tags).to match_array(
        [programming_activity_tag, daryllxd_activity_tag]
      )
    end
  end

  context 'errors' do
    context 'AR error on the Pomodoro (negative duration)' do
      it 'returns an error specifying that a tag is needed' do
        created_pomodoro = execute.call(
          duration: -25,
          description: '',
          tags: []
        )

        expect(Pomodoro.count).to eq 0
        expect(created_pomodoro).not_to be_valid
        expect(created_pomodoro.to_s).to include('Validation failed')
      end
    end

    context 'tags error' do
      it 'returns an error specifying that a tag is needed' do
        expect_any_instance_of(described_class).to receive(:create_tags!).and_return(
          double(valid?: false, errors: double(valid?: false))
        )

        created_pomodoro = execute.call(
          duration: 25,
          description: 'Did things',
          tags: ['Wutface']
        )

        expect(Pomodoro.count).to eq 0
        expect(created_pomodoro).not_to be_valid
      end
    end
  end
end
