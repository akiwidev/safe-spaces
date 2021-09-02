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
        notificationsContainer.insertAdjacentHTML('beforebegin', `<div class="notification-content">
        <p>Someone is about to start a trip. Are you at home? If not, make your place unavailable</p>
        </div>`);
          // ${ cl_image_tag(data.space.user.photo.key, alt: "profile photo")  }
        // notificationsContainer.scroll(0, notificationsContainer.scrollHeight);
      },
    });
  }
}

export { initNotificationCable };
