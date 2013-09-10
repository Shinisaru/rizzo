# 
# Params: @args {
#   selector: {string} parent element,
#   delay: {number} timeout between switching slides,
# }
# 

define ['jquery'], ($) ->
 
  class Tabs

    config = {
      animationDelay: 300
    }
    activeTimeout = null


    constructor: (args) ->

      config.tabs = $(args.selector)
      config.tabsContainer = config.tabs.find('.js-tabs-content')
      config.tabLabels = config.tabs.find('.js-tab-trigger')
      config.animationDelay = args.delay

      config.tabs.on 'click', '.js-tab-trigger', (e) ->
        tabLabel = $(@)
        tab = $(tabLabel.attr('href'))

        _openNewTab(tabLabel, tab)
        false

      config.tabs.find('img').each ->
        img = $(@)
        tab = img.closest('[id^=js-tab]')

        return unless tab.length > 0

        imgRatio = img.height() / img.width()
        containerRatio = tab.height() / tab.width()

        if imgRatio < containerRatio
          img.addClass('is-wider')
          img.css('marginLeft', ((imgRatio - containerRatio) * 100)+"%")
        else
          img.css('marginTop', ((containerRatio - imgRatio) / 2 * 100)+"%")

      config.tabsContainer.removeClass('is-loading')
      $(config.tabLabels.filter(':first').addClass('is-active').attr('href')).addClass('is-active')
    

    # Private Functions

    _openNewTab = (tabLabel, tab) ->
      unless tab.hasClass('is-active')
        
        config.tabsContainer.children('.is-active').removeClass('is-active')
        config.tabLabels.removeClass('is-active')
        tabLabel.addClass('is-active')

        activeTimeout = setTimeout ->
          config.tabsContainer.find(tab).addClass('is-active')
          config.tabsContainer.css('opacity', '1')
          activeTimeout = null
        , config.animationDelay
