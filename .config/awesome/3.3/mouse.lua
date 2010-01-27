root.buttons({
                button({ }, 3, function () mymainmenu:toggle() end),
                button({ }, 4, awful.tag.viewnext),
                button({ }, 5, awful.tag.viewprev)
             })
