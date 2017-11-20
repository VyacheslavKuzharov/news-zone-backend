#
# A common class for defining API docs
#
# This class is abstract, to define your own doc
#  for controller Api::ResourcesController, create a class
#
#   class Api::ResourcesDoc < ApplicationDoc
#     resource_description do
#       # any method from Apipie
#     end
#
#     doc_for :action_name do
#       # documentation for Api::ResourcesController#action_name
#       # using Apipie methods
#     end
#   end
#
class ApplicationDoc
  extend Controllers::ApiDoc

  class << self
    # Stores provided resource description
    #  to include it later to the controller class
    #
    # @param block [Proc]
    #
    def resource_description(&block)
      @_resource_description_block = block
    end

    # Returns stored resource description (or empty proc)
    #
    # @return [Proc]
    #
    def resource_description_block
      @_resource_description_block || proc {}
    end

    # Defines documentation for provided +action_name+
    #
    # @param action_name [#to_s] should match controller action name
    # @param block [Proc] documentation for +action_name+ action
    #
    def doc_for(action_name, &block)
      docs[action_name] = block
    end

    # Returns mappign action_name => documentation
    #
    # @return [Hash]
    #
    def docs
      @_docs ||= {}
    end

    # Applies all defined DSL to provided controller class
    #
    # @param controller [ActionController::Base]
    #
    def apply(controller)
      resource_description_block = self.resource_description_block
      docs = self.docs

      controller.class_eval do
        resource_description(&resource_description_block)

        docs.each do |action_name, block|
          instance_eval(&block)

          define_method(action_name) {}
        end
      end
    end
  end
end