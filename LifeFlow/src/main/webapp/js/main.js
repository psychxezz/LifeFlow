/* main.js — LifeFlow lightweight interactions */
(function () {
  "use strict";

  /* ── Mobile navbar toggle ─────────────────────────── */
  const toggle = document.getElementById("navToggle");
  const links  = document.getElementById("navbarLinks");
  if (toggle && links) {
    toggle.addEventListener("click", function () {
      links.classList.toggle("open");
      toggle.setAttribute("aria-expanded", links.classList.contains("open"));
    });
    // Close when a link is clicked
    links.querySelectorAll("a").forEach(function (a) {
      a.addEventListener("click", function () { links.classList.remove("open"); });
    });
  }

  /* ── Scroll reveal (IntersectionObserver) ─────────── */
  var revealEls = document.querySelectorAll(".reveal");
  if ("IntersectionObserver" in window && revealEls.length) {
    var observer = new IntersectionObserver(function (entries) {
      entries.forEach(function (e) {
        if (e.isIntersecting) {
          e.target.classList.add("visible");
          observer.unobserve(e.target);
        }
      });
    }, { threshold: 0.12 });
    revealEls.forEach(function (el) { observer.observe(el); });
  } else {
    // Fallback: just show everything
    revealEls.forEach(function (el) { el.classList.add("visible"); });
  }

  /* ── Subtle parallax on hero blobs ───────────────── */
  var hero = document.querySelector(".hero");
  if (hero) {
    document.addEventListener("mousemove", function (e) {
      var blobs = hero.querySelectorAll(".blob");
      var cx = window.innerWidth  / 2;
      var cy = window.innerHeight / 2;
      var dx = (e.clientX - cx) / cx;
      var dy = (e.clientY - cy) / cy;
      blobs.forEach(function (b, i) {
        var factor = (i % 2 === 0) ? 12 : -8;
        b.style.transform = "translate(" + dx * factor + "px, " + dy * factor + "px)";
      });
    });
  }

  /* ── Auto-dismiss messages after 6 s ─────────────── */
  var msgs = document.querySelectorAll(".message, .success-message");
  msgs.forEach(function (m) {
    setTimeout(function () {
      m.style.transition = "opacity .6s";
      m.style.opacity = "0";
      setTimeout(function () { m.style.display = "none"; }, 700);
    }, 6000);
  });

  /* ── Confirm dangerous actions ───────────────────── */
  document.querySelectorAll(".delete-btn").forEach(function (btn) {
    btn.addEventListener("click", function (e) {
      if (!confirm("Are you sure you want to delete this record? This cannot be undone.")) {
        e.preventDefault();
      }
    });
  });

})();
