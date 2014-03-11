// -----------------------------------------------------------------------------
//
// Social Toolbar
//
// -----------------------------------------------------------------------------

// TODO
//
// 1. Update the urls on the print & email buttons after ajax success
// 2. Implement an easy teardown/rebuild function after ajax success, to ensure correct data
// 3. Ship it
// 4. Re-implement (2) to see if we can update/refresh the buttons without redownloading assets

define([ "jquery", "lib/components/proximity_loader" ], function($, ProximityLoader) {

  "use strict";

  // @args = {}
  // el: {string} selector for parent element
  var SocialToolbar = function(args) {
    this.$listener = $(args.listener || "#js-row--content");
    this.el = args.el;
    this.$el = $(args.el);
    this.$el.length && this.init();
  }, _this;

  SocialToolbar.prototype.init = function() {
    _this = this;
    this.listen();
    !this.$el.hasClass("is-hidden") && this._load();
  };

  // ---------------------------------------------------------------------------
  // Subscribe to Events
  // ---------------------------------------------------------------------------

  SocialToolbar.prototype.listen = function() {

    this.$listener.on(":page/received", function(e, data) {
      if (_this._shouldLoadButtons(data)) {
        _this._load();
      } else {
        _this.$el.addClass("is-hidden");
      }
    });

  };

  // ---------------------------------------------------------------------------
  // Private Functions
  // ---------------------------------------------------------------------------

  SocialToolbar.prototype._shouldLoadButtons = function(data) {
    return !!(data && data.displaySocial);
  };

  SocialToolbar.prototype._load = function() {
    _this.$el.removeClass("is-hidden");
    _this.proximityLoader = _this.proximityLoader || new ProximityLoader({
      el: _this.el,
      list: "#js-facebook-like, #js-tweet, #js-google-plus",
      success: ":asset/uncommentScript"
    });
  };

  return SocialToolbar;

});
