# frozen_string_literal: true

module Cache
  class Orchestrator
    attr_reader :namespaced_redis

    delegate :flushall, to: :namespaced_redis

    def initialize
      @namespaced_redis = set_namespace
    end

    def set(key, value)
      namespaced_redis.set(key, value)
    end

    def get(key)
      namespaced_redis.get(key)
    end

    def set_hash(*args)
      first, *last = args

      # Really weird bug with redis-namespace, when using it in hashes, it also uses the keys in the
      Redis.current.mapped_hmset("#{namespace}:#{first}", *last)
    end

    def get_hash(*args)
      namespaced_redis.hgetall(args)
    end

    private

    def namespace
      if defined?(Rails)
        Rails.env.to_sym
      else
        :cli
      end
    end

    def set_namespace
      redis_connection = Redis.new

      Redis::Namespace.new(namespace, redis: redis_connection)
    end
  end
end
