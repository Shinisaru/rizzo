require 'browser_support'
require 'host_support'

module GlobalResourcesHelper
  include BrowserSupport, HostSupport

  def primary_navigation_items
    [
      {style:'home', title:'Home', uri: www_url},
      {style:'destinations', title:'Destinations', uri: www_url("destinations")},
      {style:'forum', title:'Thorn Tree forum', uri: www_url("thorntree")},
      {style:'shop', title:'Shop', uri: shop_url},
      {style:'hotels', title:'Hotels', uri: hotels_url},
      {style:'flights', title:'Flights', uri: www_url("bookings/flights.do")},
      {style:'insurance', title:'Insurance', uri: www_url("bookings/insurance.do")}
    ]
  end

  def cart_item_element
    capture_haml do
      haml_tag(:li, class: 'globalCartHead') do
        haml_tag(:a, 'Cart: 0', href: 'http://shop.lonelyplanet.com/cart/view')
      end
    end
  end

  def membership_item_element
    capture_haml do
      haml_tag(:li, class: 'signInRegister cartDivider')
    end
  end

  def arrow_button(args)
    capture_haml do
      haml_tag(:div, class: "#{args[:color]}AngleButton") do
        haml_tag(:a, href: args[:href] || '#', class: "lpButton2010") { haml_tag(:span, args[:title]) }
      end
    end
  end

end