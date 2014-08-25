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

      def copy_migration
        migration_template "migration.rb", "db/migrate/create_dragonfly_data_stores.rb"
      end

      def modify_initializer_file
        init_file_name = "config/initializers/dragonfly.rb"
        init_file = File.read(init_file_name)
        init_file.sub!(/datastore :file/, "datastore Dragonfly::DataStorage::MysqlDataStore.new\n  # datastore :file")
        init_file.sub!(/  root_path:/, "#   root_path:")
        init_file.sub!(/  server_root:/, "#   server_root:")
        File.write(init_file_name, init_file)
      end

    end

  end

end