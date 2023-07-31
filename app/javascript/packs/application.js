// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require sidebar
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"; 

import Swiper from 'swiper';
import 'swiper/swiper-bundle.css';
import $ from 'jquery';

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener('turbolinks:load', () => {
  console.log("turbolinks:load");
  const flashMessages = document.querySelector(".flash_messages");
  if (flashMessages) {
    // Set transition property for flashMessages element
    flashMessages.style.transition = 'opacity 1s ease-in-out';
    setTimeout(function(){
      flashMessages.style.opacity = 0;
      setTimeout(function(){
        flashMessages.remove();
      }, 1000);
    }, 1000);
  }
});

document.addEventListener("DOMContentLoaded", function() {
  document.getElementById("sidebarToggle").addEventListener("click", function(e) {
    e.preventDefault(); // ボタンのデフォルトの動作を停止
    var sidebar = document.getElementById("sidebar");
    // sidebar.show()
    // sidebar.hide()
    sidebar.classList.toggle("active"); // .activeクラスの追加/削除
  });
});
