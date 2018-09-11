module AutomationFramework
  # This Class instantiates all app support classes
  # rubocop:disable Metrics/ClassLength
  class Application < AutomationFramework::Utilities

    def regionapi
      @regionapi ||= Regionapi.new
    end
    def influxapi
      @influxapi ||= Influxapi.new
    end
    def cassandraapi
      @cassandraapi ||= Cassandraapi.new
    end
  end
  # rubocop:enable Metrics/ClassLength
end
