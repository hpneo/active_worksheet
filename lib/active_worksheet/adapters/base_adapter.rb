module ActiveWorksheet
  module Adapters
    class BaseAdapter
      ADAPTER_NAME = "Base"

      attr_accessor :source, :authorization

      def initialize(source: nil, authorization: {})
        @source = source
        @authorization = authorization
      end

      def all
        raise NotImplementedError
      end

      def find
        raise NotImplementedError
      end

      def first
        raise NotImplementedError
      end

      def last
        raise NotImplementedError
      end

      def new
        raise NotImplementedError
      end

      def count
        raise NotImplementedError
      end
    end
  end
end