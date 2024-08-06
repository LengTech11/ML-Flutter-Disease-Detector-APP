import './bootstrap';

import Alpine from 'alpinejs';

window.Alpine = Alpine;

Alpine.start();

import {
    Modal,
    Ripple,
    initTWE,
} from "tw-elements";

initTWE({ Modal, Ripple });


function toggle(source) {
    checkboxes = document.getElementsByName('checkAll');
    for(var i=0, n=checkboxes.length;i<n;i++) {
        checkboxes[i].checked = source.checked;
    }
}





