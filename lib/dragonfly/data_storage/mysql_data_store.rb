module Dragonfly
  module DataStorage

    class MysqlDataStore
      include Serializer

      CLASS_NAME = 'DragonflyDataStore'
      STORE_META = true
      SALT = nil
      HASH_LENGTH = 8

      def write(temp_object, opts={})
        id = CLASS_NAME.constantize.create! { |x|
          x.data = temp_object.data
          x.meta = marshal_b64_encode(temp_object.meta) if STORE_META
        }.id
        if SALT.blank?
          id
        else
          require 'digest/sha1'
          "#{id}-#{Digest::SHA1.hexdigest(id.to_s + SALT)[0, HASH_LENGTH]}"
        end
      rescue ActiveRecord::ActiveRecordError => e
        raise UnableToStore, e.message
      end

      def read(uid)
        record = CLASS_NAME.constantize.find(get_id(uid))
        [record.data, STORE_META ? marshal_b64_decode(record.meta) : {}]
      rescue ActiveRecord::ActiveRecordError => e
        raise DataNotFound, "couldn't find file #{uid}"
      end

      def destroy(uid)
        CLASS_NAME.constantize.find(get_id(uid)).destroy
      rescue ActiveRecord::ActiveRecordError => e
        raise DataNotFound, e.message
      end

    private

      def get_id(uid)
        if SALT.blank?
          uid
        else
          require 'digest/sha1'
          id, hash = uid.split('-', 2)
          if hash.blank? or hash == Digest::SHA1.hexdigest(id + SALT)[0, HASH_LENGTH]
            id
          else
            nil
          end
        end
      end

    end

  end
end