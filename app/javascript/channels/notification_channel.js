import consumer from "./consumer";

const initNotificationCable = () => {
  // const notificationsContainer = document.querySelector('.notification-box');
  const notificationsContainer = document.getElementById('notification-container');
  // const notificationContent = document.querySelector('.notification-content');

  consumer.subscriptions.create("Noticed::NotificationChannel", {
    connected() {
      // Called when the subscription is ready for use on the server
    },
    received(data) {
      const unread = document.getElementById('unread');
      if (unread) { unread.innerText = parseInt(unread.innerText, 10) + 1 }
    },
  });
  if (notificationsContainer) {
    // const id = notificationsContainer.dataset.notificationId;
    consumer.subscriptions.create("Noticed::NotificationChannel", {
      connected() {
        // Called when the subscription is ready for use on the server
      },
      received(data) {
        console.log(data);
        const unreadInside = document.getElementById('unread-inside');
        if (unreadInside) { unreadInside.innerText = parseInt(unreadInside.innerText, 10) + 1 }
        if (data.incident) {
          notificationsContainer.insertAdjacentHTML('afterbegin', `
          <div id= "notification-container">
            <div class="notification-box mb-3">
              ${data.photo}
              <div class="notification-content">
                <p style="color: white">${capitalize(data.user.first_name)} is coming to your safe space! See her journey <strong><a href="/incidents/${data.incident.id}">here</a></strong></p>
              </div>
            </div>
          </div>
        `);
        } else {

          notificationsContainer.insertAdjacentHTML('afterbegin', `
          <div id= "notification-container">
            <div class="notification-box mb-3">
              <img src="images/placeholder2.jpg" alt="placeholder profile photo">
              <div class="notification-content">
                <p style="color: white">Someone is about to start a trip. Are you at home? If not, make your place unavailable <strong>${data.notification}</strong></p>
              </div>
            </div>
          </div>
          `);
        }
          // ${ cl_image_tag(data.space.user.photo.key, alt: "profile photo")  }
        // notificationsContainer.scroll(0, notificationsContainer.scrollHeight);
      },
    });
  }
}

function capitalize(word) {
  return word[0].toUpperCase() + word.slice(1).toLowerCase();
}

export { initNotificationCable };
