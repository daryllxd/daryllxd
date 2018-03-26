# frozen_string_literal: true

RSpec.describe Cache::Orchestrator do
  after(:each) do
    test_env = Redis.current

    test_env.scan_each(match: 'test:*') do |key|
      test_env.del(key)
    end
  end

  context 'set and get' do
    it 'sets a Redis string' do
      cache = described_class.new

      cache.set('cache', 'hoho')

      expect(cache.get('cache')).to eq('hoho')
      expect(Redis.current.get('test:cache')).to eq('hoho')
    end
  end

  context 'setting hashes' do
    it 'sets a Redis hash and is Namespaced' do
      cache = described_class.new

      cache.set_hash('cache', hoho: 'hehe')

      expect(Redis.current.hgetall('test:cache')).to eq('hoho' => 'hehe')

      expect(cache.get_hash('cache')).to eq('hoho' => 'hehe')
    end
  end
end
