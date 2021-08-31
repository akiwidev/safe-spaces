import consumer from "./consumer";

const initIncidentCable = () => {
  const messagesContainer = document.getElementById('messages');
  const messageContent = document.getElementById('message_content');
  if (messagesContainer) {
    const id = messagesContainer.dataset.incidentId;

    consumer.subscriptions.create({ channel: "IncidentChannel", id: id }, {
      received(data) {
        console.log(1); // called when data is broadcast in the cable
        messagesContainer.insertAdjacentHTML('beforeend', data);
        messagesContainer.scroll(0, messagesContainer.scrollHeight);
        messageContent.value = "";
      },
    });
  }
}

export { initIncidentCable };
