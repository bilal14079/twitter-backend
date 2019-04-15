# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  class Notifications
    constructor: ->
      @getNewNotifications()
      @notifications = $("[data-behavior='notifications']")

      if @notifications.length > 0
        @handleSuccess @notifications.data('notifications')

    getNewNotifications: ->
      $.ajax(
        url: '/notifications.json'
        dataType: 'JSON'
        method: 'GET'
        success: @handleSuccess
      )

    handleSuccess: (data) =>
      items = $.map data, (notification) ->
        notifications.template

      $("[data-behavior='unread-count']").text(items.length)
      $("[data-behavior='notification-items']").append(items)