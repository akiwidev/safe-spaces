import consumer from "./consumer";

const initNotificationCable = () => {
  const notificationsContainer = document.querySelector('notifications');
  const notificationContent = document.querySelector('.notification-content');

  if (notificationsContainer) {

    consumer.subscriptions.create({ channel: "NotificationChannel" }, {
      received(data) {
        console.log(data); // called when data is broadcast in the cable
        notificationsContainer.insertAdjacentHTML('beforeend', data);
        notificationsContainer.scroll(0, notificationsContainer.scrollHeight);
      },
    });
  }
}

export { initNoficationCable };
