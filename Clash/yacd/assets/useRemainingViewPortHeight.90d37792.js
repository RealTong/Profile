import{j as r}from"./vendor.7cc37624.js";const{useState:s,useRef:c,useCallback:u,useLayoutEffect:a}=r;function g(){const t=c(null),[n,i]=s(200),e=u(()=>{const{top:o}=t.current.getBoundingClientRect();i(window.innerHeight-o)},[]);return a(()=>(e(),window.addEventListener("resize",e),()=>{window.removeEventListener("resize",e)}),[e]),[t,n]}export{g as u};