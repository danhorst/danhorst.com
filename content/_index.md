---
title: "Dan Brubaker Horst"
description: "My personal website (there is some professional content too)"
---
<style>
  @keyframes reveal {
    from {
      opacity: 0;
    }

    to {
      opacity: 100;
    }
  }

  #phi-wrapper {
    margin: 2em auto;
    max-width: 100%;
  }

  #phi {
    aspect-ratio: 1.618033989 / 1;
    margin: 0 auto;
    position: relative;
  }

  .square {
    animation: reveal 300ms ease;
    animation-fill-mode: forwards;
    border: 1px solid #000;
    box-sizing: border-box;
    opacity: 0;
    position: absolute;
  }

  .square-2  { border-left: 0; }
  .square-3  { border-top: 0; }
  .square-4  { border-left: 0; border-right: 0; }
  .square-5, .square-9  { border-top: 0;                  border-bottom: 0; border-left: 0; }
  .square-6, .square-10 { border-top: 0; border-right: 0;                   border-left: 0; }
  .square-7, .square-11 { border-top: 0; border-right: 0; border-bottom: 0;                 }
  .square-8, .square-12 {                border-right: 0; border-bottom: 0; border-left: 0; }

  .square-1  { animation-delay:  300ms; left: 0%;        top: 0%;        width: 61.799%;    height: 99.99288%;  }
  .square-2  { animation-delay:  600ms; left: 61.799%;   top: 0%;        width: 38.19388%;  height: 61.799%;    }
  .square-3  { animation-delay:  900ms; left: 76.38776%; top: 61.799%;   width: 23.60512%;  height: 38.19388%;  }
  .square-4  { animation-delay: 1200ms; left: 61.799%;   top: 76.38776%; width: 14.58876%;  height: 23.60512%;  }
  .square-5  { animation-delay: 1500ms; left: 61.799%;   top: 61.799%;   width: 9.016353%;  height: 14.58876%;  }
  .square-6  { animation-delay: 1800ms; left: 70.81535%; top: 61.799%;   width: 5.572412%;  height: 9.016353%;  }
  .square-7  { animation-delay: 2100ms; left: 72.94382%; top: 70.81535%; width: 3.44394%;   height: 5.572412%;  }
  .square-8  { animation-delay: 2400ms; left: 70.81535%; top: 72.94382%; width: 2.128472%;  height: 3.44394%;   }
  .square-9  { animation-delay: 2700ms; left: 70.81535%; top: 70.81535%; width: 1.315468%;  height: 2.128472%;  }
  .square-10 { animation-delay: 3000ms; left: 72.13082%; top: 70.81535%; width: 0.813004%;  height: 1.315468%;  }
  .square-11 { animation-delay: 3300ms; left: 72.44136%; top: 71.62836%; width: 0.5024641%; height: 0.813004%;  }
  .square-11 { animation-delay: 3300ms; left: 72.44136%; top: 72.13082%; width: 0.5024641%; height: 0.813004%;  }
  .square-12 { animation-delay: 3600ms; left: 72.13082%; top: 72.44136%; width: 0.3105399%; height: 0.5024641%; }

  @media (max-aspect-ratio: 1/1) {
    #phi { aspect-ratio: 1 / 1.618033989; }

    .square { border: 1px solid #000;}
    .square-2  { border-top: 0; }
    .square-3  { border-left: 0; }
    .square-4  { border-top: 0; border-bottom: 0; }
    .square-5, .square-9  { border-top: 0; border-right: 0;                   border-left: 0; }
    .square-6, .square-10 { border-top: 0;                  border-bottom: 0; border-left: 0; }
    .square-7, .square-11 {                border-right: 0; border-bottom: 0; border-left: 0; }
    .square-8, .square-12 { border-top: 0; border-right: 0; border-bottom: 0;                 }

    .square-1  { left: 0%;        top: 0%;        width: 99.99288%;  height: 61.799%;    }
    .square-2  { left: 0%;        top: 61.799%;   width: 61.799%;    height: 38.19388%;  }
    .square-3  { left: 61.799%;   top: 76.38776%; width: 38.19388%;  height: 23.60512%;  }
    .square-4  { left: 76.38776%; top: 61.799%;   width: 23.60512%;  height: 14.58876%;  }
    .square-5  { left: 61.799%;   top: 61.799%;   width: 14.58876%;  height: 9.016353%;  }
    .square-6  { left: 61.799%;   top: 70.81535%; width: 9.016353%;  height: 5.572412%;  }
    .square-7  { left: 70.81535%; top: 72.94382%; width: 5.572412%;  height: 3.44394%;   }
    .square-8  { left: 72.94382%; top: 70.81535%; width: 3.44394%;   height: 2.128472%;  }
    .square-9  { left: 70.81535%; top: 70.81535%; width: 2.128472%;  height: 1.315468%;  }
    .square-10 { left: 70.81535%; top: 72.13082%; width: 1.315468%;  height: 0.813004%;  }
    .square-11 { left: 72.13082%; top: 72.44136%; width: 0.813004%;  height: 0.5024641%; }
    .square-12 { left: 72.44136%; top: 72.13082%; width: 0.5024641%; height: 0.3105399%; }
  }

  @media (min-width: 720px) {
    .square {
      border-width: 2px;
    }
  }

  @media (prefers-color-scheme: dark) {
    .square {
      border-color: #fff;
    }
  }

  @media (min-width: 760px) {
    body {
      max-width: 80em;
    }
  }
</style>

<figure id="phi-wrapper">
<div id="phi">
  <div class="square square-1"></div>
  <div class="square square-2"></div>
  <div class="square square-3"></div>
  <div class="square square-4"></div>
  <div class="square square-5"></div>
  <div class="square square-6"></div>
  <div class="square square-7"></div>
  <div class="square square-8"></div>
  <div class="square square-9"></div>
  <div class="square square-10"></div>
  <div class="square square-11"></div>
  <div class="square square-12"></div>
</div>
</figure>
