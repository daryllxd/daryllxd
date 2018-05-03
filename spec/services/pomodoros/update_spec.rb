# frozen_string_literal: true

RSpec.describe Pomodoros::Update, type: :service do
  let!(:programming_activity_tag) { create(:activity_tag, :programming) }
  let!(:daryllxd_activity_tag) { create(:activity_tag, :daryllxd) }

  let!(:created_pomodoro) do
    Pomodoros::Create.call(
      duration: 25,
      description: 'Did things',
      tags: [programming_activity_tag]
    )
  end

  context 'happy path' do
    it 'updates everything' do
      updated_pomodoro = execute.call(
        pomodoro: created_pomodoro,
        pomodoro_attributes: { duration: 99, description: 'Whut' },
        tags: []
      )
      expect(updated_pomodoro.duration).to eq 99
      expect(updated_pomodoro.description).to eq 'Whut'
      expect(updated_pomodoro.activity_tags).to eq([programming_activity_tag])
    end

    it 'updates tags' do
      updated_pomodoro = execute.call(
        pomodoro: created_pomodoro,
        tags: [daryllxd_activity_tag]
      )

      expect(updated_pomodoro.reload.activity_tags).to eq([daryllxd_activity_tag])
    end
  end

  context 'errors' do
    context 'AR error on the Pomodoro (negative duration)' do
      it 'returns an error specifying that a tag is needed' do
        error = execute.call(
          pomodoro: created_pomodoro,
          pomodoro_attributes: { duration: -2 }
        )

        expect(error).not_to be_valid
        expect(error.message).to include('Validation failed')
      end
    end

    context 'tags error' do
      it 'TODO: how to do you do even test this?' do
      end
    end
  end
end
