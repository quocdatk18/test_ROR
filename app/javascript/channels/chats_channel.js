import Rails from "@rails/ujs";
import consumer from "./consumer"

consumer.subscriptions.create("ChatsChannel", {
  connected() {
    console.log("Connected to the comments channel!");
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    let message_obj = JSON.parse(data.message)
    let is_current_user = false;
    Rails.ajax({
      url: '/api/current_user',
      type: 'GET',
      success: function (current_user) {
        is_current_user = current_user.id == message_obj.user_id;
        let message_side = is_current_user ? 'right' : 'left';
        let message_show = is_current_user ? 'darker' : '';
        let message_html = `<div class='message ${message_show}'>
          <img src=${message_obj.user.user.avatar} alt='Avatar' style='width:100%;' class='${message_side}'>
          <p>${message_obj.content}</p>
          <small class='time-right'>${message_obj.created_at}</small>
        </div>
        `
        document.getElementById("messages").innerHTML += message_html
        document.querySelector(".form-control").value ='';
        document.querySelector("#button").disabled = false;
      },
      error: function(e) {
        document.querySelector(".form-control").value ='';
        document.querySelector("#button").disabled = false;
      }
    })
  }
});
