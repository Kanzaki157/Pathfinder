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

// document.addEventListener("DOMContentLoaded", function() {
//   document.getElementById("sidebarToggle").addEventListener("click", function(e) {
//     e.preventDefault(); // ボタンのデフォルトの動作を停止
//     var sidebar = document.getElementById("sidebar");
//     sidebar.classList.toggle("active"); // .activeクラスの追加/削除
//   });
// });
document.addEventListener('turbolinks:load', () => {
  $('#sidebarToggle').click(function(e) {
    e.stopPropagation();
    toggleSidebar();
  });

  $('#overlay').click(function(e) {
    toggleSidebar();
  });

  $('#sidebar').click(function(e) {
    e.stopPropagation();
  });
});

function toggleSidebar() {
  var isSidebarOpen = $('#sidebar').css('left') == '0px';

  $('#sidebar').animate({
    left: isSidebarOpen ? '-250px' : '0px'
  }, 300);

  if (isSidebarOpen) {
    $('#overlay').fadeOut(300);
    // $('body').css('overflow', 'auto');
    $('body').removeClass('scroll-lock');
  } else {
    $('#overlay').fadeIn(300);
    $('body').css('overflow-y', 'scroll');
    $('body').addClass('scroll-lock');
  }
}
