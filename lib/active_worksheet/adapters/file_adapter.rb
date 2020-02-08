require_relative "./base_adapter"
require "workbook"
require "active_support/inflector"

module ActiveWorksheet
  module Adapters
    class FileAdapter < BaseAdapter
      ADAPTER_NAME = "File"

      def initialize(source: nil)
        super(source: source)

        @workbook = Workbook::Book.open(source)
      end

      def all
        table = @workbook.sheet.table

        headers = table.shift.map do |header|
          ActiveSupport::Inflector.underscore(ActiveSupport::Inflector.parameterize(header.value))
        end

        table.map do |row|
          row.each_with_index.reduce({}) do |result, (cell, index)|
            result[headers[index]] = cell.value
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
    end
  end
end