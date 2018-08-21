module AutomationFramework
  # This Class instantiates all app support classes
  # rubocop:disable Metrics/ClassLength
  class Application < AutomationFramework::Utilities

    def regionapi
      @regionapi ||= Regionapi.new
    end
  end
  # rubocop:enable Metrics/ClassLength
end
