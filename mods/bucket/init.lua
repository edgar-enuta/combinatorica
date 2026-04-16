-- Bucket
-- Buckets for picking up and placing liquid source nodes.

bucket = {}
bucket.liquids = {}

-- Register a liquid bucket.
function bucket.register_liquid(source, flowing, itemname, inventory_image, name)
    bucket.liquids[source] = {
        source = source,
        flowing = flowing,
        itemname = itemname,
    }

    core.register_craftitem(itemname, {
        description = name,
        inventory_image = inventory_image,
        stack_max = 1,
        liquids_pointable = true,
        on_use = function(itemstack, user, pointed_thing)
            if pointed_thing.type ~= "node" then return end
            local pos = pointed_thing.above
            core.set_node(pos, {name = source})
            return ItemStack("bucket:bucket_empty")
        end,
    })
end

-- Empty bucket
core.register_craftitem("bucket:bucket_empty", {
    description = "Empty Bucket",
    inventory_image = "bucket.png",
    stack_max = 99,
    liquids_pointable = true,
    on_use = function(itemstack, user, pointed_thing)
        if pointed_thing.type ~= "node" then return end
        local pos = pointed_thing.under
        local node = core.get_node(pos)
        local liq = bucket.liquids[node.name]
        if liq then
            core.remove_node(pos)
            itemstack:take_item()
            local inv = user:get_inventory()
            if inv:room_for_item("main", ItemStack(liq.itemname)) then
                inv:add_item("main", ItemStack(liq.itemname))
            else
                core.add_item(user:get_pos(), ItemStack(liq.itemname))
            end
            return itemstack
        end
    end,
})

-- Register default liquid buckets
bucket.register_liquid("default:water_source", "default:water_flowing",
    "bucket:bucket_water", "bucket_water.png", "Water Bucket")
bucket.register_liquid("default:lava_source", "default:lava_flowing",
    "bucket:bucket_lava", "bucket_lava.png", "Lava Bucket")

core.register_craft({
    output = "bucket:bucket_empty",
    recipe = {
        {"default:steel_ingot", "", "default:steel_ingot"},
        {"", "default:steel_ingot", ""},
    },
})

core.log("action", "[bucket] Bucket system loaded")
