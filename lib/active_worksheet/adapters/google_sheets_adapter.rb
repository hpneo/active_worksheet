require_relative "./base_adapter"
require "google_drive"
require "active_support/inflector"

module ActiveWorksheet
  module Adapters
    class GoogleSheetsAdapter < BaseAdapter
      ADAPTER_NAME = "GoogleSheets"

      def initialize(source: nil, authorization: {})
        super(source: source, authorization: authorization)
      end

      def all
        session = build_session(authorization)
        @workbook = session.spreadsheet_by_url(source)
        table = @workbook.worksheets.first

        headers = table.rows[0].map do |header|
          ActiveSupport::Inflector.underscore(ActiveSupport::Inflector.parameterize(header))
        end

        table.rows(1).map do |row|
          row.each_with_index.reduce({}) do |result, (value, index)|
            result[headers[index]] = value
            result
          end
        end
      end

      def find(index)
        all[index]
      end

      def first
        find(0)
      end

      def last
        find(-1)
      end

      def count
        all.count
      end

      private

      def build_session(authorization)
        return GoogleDrive::Session.new_dummy if authorization.nil?

        if authorization.has_key?(:access_token)
          GoogleDrive::Session.login_with_oauth(authorization[:access_token])
        elsif authorization.has_key?(:config)
          GoogleDrive::Session.from_config(authorization[:config])
        elsif authorization.has_key?(:credentials)
          GoogleDrive::Session.from_credentials(authorization[:credentials])
        elsif authorization.has_key?(:service_account_key)
          GoogleDrive::Session.from_service_account_key(authorization[:service_account_key])
        end
      end
    end
  end
end