import http from 'k6/http';
import { sleep } from 'k6';

let url = "https://bmi-api-stag.herokuapp.com/"
let request = "?height=167&weight=65"

export let options = {
  vus: 5,
  duration: '10s'
}

// run script using: k6 run test.js
export default function () {
  http.get(`${url}${request}`);
  sleep(0.5);
}
