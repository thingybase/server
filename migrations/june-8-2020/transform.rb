# Creates an item with the name of a container, then adds the children of the
# container to itself.
class ContainerToItemMigrator
  def initialize(container:, item_parent_id: nil, dry_run: true)
    @container = container
    @logger = Rails.logger
    @item_parent_id = item_parent_id
  end

  def migrate
    parent_item = Item.create! do |item|
      %w[name account_id user_id created_at updated_at].each do |attr|
        item.write_attribute attr, @container.read_attribute(attr)
      end
      item.write_attribute :parent_id, @item_parent_id
      item.write_attribute :container, true
    end

    @logger.info "Copied #{@container.inspect} to #{parent_item.inspect}"

    # Add the label to the thing
    if label = @container.label
      @logger.info "Assigning #{label.inspect} to #{parent_item.inspect}"
      parent_item.label = label
      parent_item.label.save!
    end

    # Add children to the items
    @container.items.each do |item|
      @logger.info "Adding #{item.inspect} to child of #{parent_item.inspect}"
      parent_item.add_child item
    end

    @container.children.each do |container|
      @logger.info "Diving into child container #{container.inspect}"
      self.class.new(container: container, item_parent_id: parent_item.id).migrate
    end
  end

  def self.migrate_root_containers(dry_run: true)
    # Find all the root containers; we're going to traverse their trees.
    root_containers = Container.where(parent_id: nil)

    Container.transaction do
      root_containers.find_each do |root_container|
        new(container: root_container).migrate
      end
      raise ActiveRecord::Rollback, "Dry run" if dry_run
    end
  end
end

dry_run = ENV.fetch("DRY_RUN", true).to_s == "true"

if dry_run
  puts "DRY_RUN=true, changes will be reverted. To commit, run again with `DRY_RUN=false rails runner migrations/june-8-2020/transform.rb`."
end

ContainerToItemMigrator.migrate_root_containers(dry_run: dry_run)