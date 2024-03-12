# frozen_string_literal: true

gem 'analytics-ruby', require: 'segment/analytics'

initializer 'segment.rb', <<~RB
  # frozen_string_literal: true

  options = {
    write_key: Rails.application.credentials.fetch(:segment, {})[:write_key] || '',
    on_error: proc { |_status, msg| Sentry.capture_message(msg) },
    stub: Rails.env.local?
  }

  SegmentAnalytics = Segment::Analytics.new(options)
RB

puts '--- Segment installed. Add `segment[:write_key]` to your credentials ---'
