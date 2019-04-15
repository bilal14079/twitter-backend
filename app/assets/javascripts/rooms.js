// (function() {
    
//     App.room = ActionCable.createConsumer('/cable/' + "?user_id=" + 4).subscriptions.create({
//         channel: "RoomChannel",
//     }, {
//     connected: function() {console.log("connected")}
//     }, {
//       disconnected: function() {}
//     }, console.log("disconnected"), {
//       received: function(data) {
//         console.log('data recieved');
//         return $('#messages').append(data['message']);
//       },
//       speak: function(message) {
//         console.log("in speak of client side");
//         return this.perform('speak', {
//           message: message
//         });
//       }
//     }, $(document).on('keypress', '[data-behavior~=room_speaker]', function(event) {
//       if (event.keyCode === 13) {
//         App.room.speak(event.target.value);
//         event.target.value = '';
//         return event.preventDefault();
//       }
//     }));
  
//   }).call(this);
















// //   # # # Place all the behaviors and hooks related to the matching controller here.
// // # # # All this logic will automatically be available in application.js.
// // # # # You can use CoffeeScript in this file: http://coffeescript.org/

// // # App.room = App.cable.subscriptions.create {channel: "RoomChannel" },
// // #   connected: ->
// // #   console.log("connected")
// // #     # Called when the subscription is ready for use on the server

// // #   disconnected: ->
// // #   console.log("disconnected")
// // #     # Called when the subscription has been terminated by the server

// // #   received: (data) ->
// // #     console.log('data recieved')
// // #     $('#messages').append data['message']
// // #     # Called when there's incoming data on the websocket for this channel
   
// // #   #  will be used to send data to its server-side representation.  and recieving client message and passing it to server on speak method of room_channel
// // #   speak: (message) ->
// // #     console.log("in speak of client side")
// // #     @perform 'speak', message: message


// // #   $(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
// // #     if event.keyCode is 13 # return/enter = send
// // #       App.room.speak event.target.value
// // #       event.target.value = ''
// // #       event.preventDefault()    