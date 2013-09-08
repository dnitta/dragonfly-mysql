module Dragonfly
  module DataStorage

    class MysqlDataStore
      include Serializer
      include Configurable

      configurable_attr :class_name, 'DragonflyDataStore'
      configurable_attr :store_meta, true
      configurable_attr :salt, nil
      configurable_attr :hash_length, 8

      def store(temp_object, opts={})
        id = class_name.constantize.create! { |x|
          x.data = temp_object.data
          x.meta = marshal_encode(temp_object.meta) if store_meta
        }.id
        if salt.blank?
          id
        else
          require 'digest/sha1'
          "#{id}-#{Digest::SHA1.hexdigest(id.to_s + salt)[0, hash_length]}"
        end
      rescue ActiveRecord::ActiveRecordError => e
        raise UnableToStore, e.message
      end

      def retrieve(uid)
        record = class_name.constantize.find(get_id(uid))
        [record.data, store_meta ? marshal_decode(record.meta) : {}]
      rescue ActiveRecord::ActiveRecordError => e
        raise DataNotFound, "couldn't find file #{uid}"
      end

      def destroy(uid)
        class_name.constantize.find(get_id(uid)).destroy
      rescue ActiveRecord::ActiveRecordError => e
        raise DataNotFound, e.message
      end

    private

      def get_id(uid)
        if salt.blank?
          uid
        else
          require 'digest/sha1'
          id, hash = uid.split('-', 2)
          if hash.blank? or hash == Digest::SHA1.hexdigest(id + salt)[0, hash_length]
            id
          else
            nil
          end
        end
      end

    end

  end
end