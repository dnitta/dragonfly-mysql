require 'rails/generators'
require 'rails/generators/migration'
module DragonflyMysql
  module Generators

    class InstallGenerator < ::Rails::Generators::Base
      include ::Rails::Generators::Migration

      def self.source_root
        @source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
      end

      def self.next_migration_number(dirname)
        Time.now.strftime("%Y%m%d%H%M%S")
      end

      def create_models
        template "model.rb", "app/models/dragonfly_data_store.rb"
      end

      def create_migration
        migration_template "migration.rb", "db/migrate/create_dragonfly_data_stores.rb"
      end

      def copy_initializer_file
        copy_file "initializer.rb", "config/initializers/dragonfly.rb"
      end

    end

  end

end