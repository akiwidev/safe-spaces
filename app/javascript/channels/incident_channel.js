import consumer from "./consumer";

const initIncidentCable = () => {
  const messagesContainer = document.getElementById('messages');
  const messageContent = document.getElementById('message_content');
  // const counter = 0;


  // function incrementCounter() {
    //   counter++;
    // }

    if (messagesContainer) {
      const id = messagesContainer.dataset.incidentId;

      consumer.subscriptions.create({ channel: "IncidentChannel", id: id }, {
        received(data) {
          console.log(1); // called when data is broadcast in the cable
          messagesContainer.insertAdjacentHTML('afterbegin', data);
          messagesContainer.scroll(0, messagesContainer.scrollHeight);
          messageContent.value = "";
          const counter = document.getElementById('counter');
          if (counter) {
            counter.innerText = parseInt(counter.innerText, 10) + 1;
          } else {
            const circle = document.querySelector(".circle")
            circle.innerHTML = "<span id='counter'>1</span>"
          }

          // counter++;
        // console.log(counter);
      },
    });
  }
}

export { initIncidentCable };
