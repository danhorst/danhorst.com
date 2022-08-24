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
    margin: 0 auto;
    max-height: 100%;
  }

  .square {
    animation: reveal 300ms ease;
    background-color: transparent;
    animation-fill-mode: forwards;
    opacity: 0;
    stroke-width: 3px;
  }

  .square-1  { animation-delay:  300ms;}
  .square-2  { animation-delay:  600ms;}
  .square-3  { animation-delay:  900ms;}
  .square-4  { animation-delay: 1200ms;}
  .square-5  { animation-delay: 1500ms;}
  .square-6  { animation-delay: 1800ms;}
  .square-7  { animation-delay: 2100ms;}
  .square-8  { animation-delay: 2400ms;}
  .square-9  { animation-delay: 2700ms;}
  .square-10 { animation-delay: 3000ms;}
  .square-11 { animation-delay: 3300ms;}
  .square-12 { animation-delay: 3600ms;}


  @media (max-aspect-ratio: 1/1) {
    #phi {
      transform: rotate(0deg);
    }
  }

  @media (min-width: 720px) {
    #phi-wrapper {
      padding: 0 2em;
    }

    .square {
      stroke-width: 2px;
    }
  }

  @media (prefers-color-scheme: dark) {
    .square {
      stroke: #fff;
    }
  }
</style>

<figure id="phi-wrapper">
<svg xmlns="http://www.w3.org/2000/svg" id="phi" viewBox="0 0 809.016994374948 500">
  <rect class="square square-1" x="0" y="0" width="500" height="500"/>
  <rect class="square square-2" x="500" y="0" width="309.01699437" height="309.01699437"/>
  <rect class="square square-3" x="618.03398875" y="309.01699437" width="190.98300563" height="190.98300563"/>
  <rect class="square square-4" x="500" y="381.96601125" width="118.03398875" height="118.03398875"/>
  <rect class="square square-5" x="500" y="309.01699437" width="72.949016875" height="72.949016875"/>
  <rect class="square square-6" x="572.94901688" y="309.01699437" width="45.084971875" height="45.084971875"/>
  <rect class="square square-7" x="590.16994375" y="354.10196625" width="27.864045" height="27.864045"/>
  <rect class="square square-8" x="572.94901688" y="364.74508438" width="17.220926874" height="17.220926874"/>
  <rect class="square square-9" x="572.94901688" y="354.10196625" width="10.643118126" height="10.643118126"/>
  <rect class="square square-10" x="583.592135" y="354.10196625" width="6.5778087482" height="6.5778087482"/>
  <rect class="square square-11" x="586.10463437" y="360.679775" width="4.0653093779" height="4.0653093779"/>
  <rect class="square square-12" x="583.592135" y="360.679775" width="2.5124993703" height="2.5124993703"/>
</svg>
</figure>
