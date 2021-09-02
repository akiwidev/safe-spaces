import consumer from "./consumer";

const initNotificationCable = () => {
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
        // notificationsContainer.insertAdjacentHTML('afterbegin', `You got a notification from ${data.user.first_name.capitalize}`);
        // notificationsContainer.scroll(0, notificationsContainer.scrollHeight);
      },
    });
  }
}

export { initNotificationCable };
