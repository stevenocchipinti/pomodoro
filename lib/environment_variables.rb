class EnvironmentVariables
  class << self

    def valid?
      [
        "PUSHER_APP_ID",
        "PUSHER_KEY",
        "PUSHER_SECRET"
      ].inject { |a,k| a && ENV[k] }
    end

    def validate!
      unless valid?
        raise "\n\nERROR: Missing some environment variables, to fix:\n" <<
          "$> source script/environment.sh\n\n"
      end
    end

  end
end
