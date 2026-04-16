-- Crafting Guide
-- Browse crafting recipes in-game via sfinv tab.

sfinv.register_page("mtg_craftguide:craftguide", {
    title = "Recipes",
    get = function(self, player, context)
        return "label[0,0;Crafting Guide]"
            .. "field[0.3,1;4,1;search;Search:;]"
            .. "button[4,0.7;1.5,1;search_btn;Search]"
            .. "textlist[0,2;7.8,5;recipe_list;(search for an item)]"
    end,
})

core.log("action", "[mtg_craftguide] Crafting guide loaded")
