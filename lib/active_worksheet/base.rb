require "active_worksheet/adapters/file_adapter"
require "active_worksheet/adapters/google_sheets_adapter"
require "active_resource/threadsafe_attributes"
require "ostruct"

module ActiveWorksheet
  class Base < OpenStruct
    class << self
      include ThreadsafeAttributes

      threadsafe_attribute :source, :authorization

      def all
        adapter.all.map do |row|
          new(row)
        end
      end

      def find(index)
        new(adapter.find(index))
      end

      def first
        new(adapter.first)
      end

      def last
        new(adapter.last)
      end

      def count
        adapter.count
      end

      def adapter
        if is_source_local?
          ActiveWorksheet::Adapters::FileAdapter.new(source: source)
        else
          ActiveWorksheet::Adapters::GoogleSheetsAdapter.new(
            source: source,
            authorization: authorization
          )
        end
      end

      def is_source_local?
        self.source.is_a?(File) || File.exists?(self.source)
      end

      def is_source_remote?
        !is_source_local?
      end
    end
  end
end
