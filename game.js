(() => {
const $ = id => document.getElementById(id);
const canvas = $('track'), ctx = canvas.getContext('2d');
const TOTAL = 12;
let lap=0, energy=68, tyres=82, position=4, playerProgress=0, best=null, started=false, finished=false, lastCall='balanced', pitUsed=false;
let rivals=[
 {name:'V. Kato',team:'NOVA',progress:0.16,color:'#ff5d58',pace:0.79},
 {name:'M. Silva',team:'VOLT',progress:0.10,color:'#ffb15c',pace:0.77},
 {name:'A. Reed',team:'ORBIT',progress:0.06,color:'#a78bfa',pace:0.75},
 {name:'YOU',team:'APEX GP',progress:0.04,color:'#c9f36b',pace:0.76,player:true},
 {name:'L. Chen',team:'NOVA',progress:0.01,color:'#6cc7e8',pace:0.73},
 {name:'J. Park',team:'VOLT',progress:0,color:'#e7e7e7',pace:0.71}
];
const clamp=(n,a,b)=>Math.max(a,Math.min(b,n));
function pathPoint(t){
 const a=t*Math.PI*2;
 return {x:380+245*Math.cos(a)+36*Math.sin(2*a), y:213+142*Math.sin(a)};
}
function drawTrack(){
 ctx.clearRect(0,0,760,430);
 ctx.fillStyle='#14232a';ctx.fillRect(0,0,760,430);
 // subtle grid
 ctx.strokeStyle='#1c3036';ctx.lineWidth=1;
 for(let x=0;x<760;x+=38){ctx.beginPath();ctx.moveTo(x,0);ctx.lineTo(x,430);ctx.stroke()}
 for(let y=0;y<430;y+=38){ctx.beginPath();ctx.moveTo(0,y);ctx.lineTo(760,y);ctx.stroke()}
 const drawLoop=(width,color)=>{ctx.beginPath();for(let i=0;i<=240;i++){const p=pathPoint(i/240);i?ctx.lineTo(p.x,p.y):ctx.moveTo(p.x,p.y)}ctx.closePath();ctx.strokeStyle=color;ctx.lineWidth=width;ctx.stroke()};
 drawLoop(76,'#34434a');drawLoop(66,'#202b31');drawLoop(2,'#6d7d80');
 // kerbs
 for(let i=0;i<90;i+=2){const p=pathPoint(i/90);ctx.beginPath();ctx.arc(p.x,p.y,34,0,.13);ctx.strokeStyle=i%4?'#d85c55':'#eee';ctx.lineWidth=3;ctx.stroke()}
 // start line
 const s=pathPoint(0);ctx.save();ctx.translate(s.x,s.y);ctx.rotate(Math.PI/2);for(let i=0;i<6;i++){ctx.fillStyle=i%2?'#10151a':'#e9edf0';ctx.fillRect(-3,-31+i*10,6,10)}ctx.restore();
 // pit lane
 ctx.beginPath();ctx.moveTo(560,280);ctx.quadraticCurveTo(650,335,560,366);ctx.strokeStyle='#70b6ff';ctx.lineWidth=4;ctx.setLineDash([7,7]);ctx.stroke();ctx.setLineDash([]);
 ctx.fillStyle='#8fbde0';ctx.font='10px monospace';ctx.fillText('PIT',618,350);
 // cars
 const sorted=[...rivals].sort((a,b)=>a.progress-b.progress);
 sorted.forEach((r,idx)=>{
  const p=pathPoint((r.progress%1+1)%1);
  const tangent=pathPoint((r.progress+.002)%1);const angle=Math.atan2(tangent.y-p.y,tangent.x-p.x);
  ctx.save();ctx.translate(p.x,p.y);ctx.rotate(angle);
  ctx.fillStyle=r.color;ctx.shadowColor=r.color;ctx.shadowBlur=r.player?14:4;
  ctx.beginPath();ctx.roundRect(-12,-5,24,10,3);ctx.fill();
  ctx.fillStyle='#10151b';ctx.fillRect(-4,-4,9,8);ctx.restore();
  if(r.player){ctx.fillStyle='#c9f36b';ctx.font='bold 11px monospace';ctx.fillText('YOU',p.x+13,p.y-12)}
 });
}
function render(){
 $('lap').innerHTML=String(Math.min(lap+1,TOTAL)).padStart(2,'0')+'<span>/12</span>';
 $('position').textContent='P'+position;
 $('energyNum').textContent=energy+'%';$('energyBar').style.width=energy+'%';
 $('tyres').textContent=tyres+'%';$('progress').style.width=(lap/TOTAL*100)+'%';
 $('best').textContent=best?best.toFixed(2)+'s':'—';
 const ahead=Math.max(0,position-1);
 $('gap').textContent=ahead?`+${(0.8+ahead*.55).toFixed(1)}s to P${position-1}`:'LEADING THE FIELD';
 $('status').textContent=finished?'CHEQUERED FLAG':started?'RACE IN PROGRESS':'FORMATION COMPLETE';
 const order=[...rivals].sort((a,b)=>b.progress-a.progress);
 $('leaderboard').innerHTML=order.map((r,i)=>`<div class="driver ${r.player?'me':''}"><b>${i+1}</b><span>${r.name} <small>· ${r.team}</small></span><span>${r.player?'YOU':(i===0?'LEADER':`+${(i*.8).toFixed(1)}s`)}</span></div>`).join('');
 drawTrack();
}
function say(text){$('radio').textContent='“'+text+'”'}
function choose(mode){
 if(!started||finished){say('Start the race first, then make your strategy calls.');return}
 if(mode==='attack'){
  if(energy<18){say('Energy reserve too low for attack mode. Recharge first.');return}
  energy-=18;lastCall='attack';say('Attack mode deployed. Great exit speed — make it count!');
 }else if(mode==='conserve'){
  energy=Math.min(100,energy+12);tyres=Math.min(100,tyres+2);lastCall='conserve';say('Managing the tyres. Keep it smooth and build energy for later.');
 }else{
  if(pitUsed){say('We have already taken our stop. Stay out and push.');return}
  pitUsed=true;tyres=100;playerProgress-=.055;lastCall='pit';say('Box, box! Fresh tyres fitted. You lose a little track position but gain grip.');
 }
}
function step(){
 if(!started){started=true;$('next').innerHTML='NEXT LAP <span>→</span>';say('Green light! Keep an eye on tyre life and energy.');}
 if(finished)return;
 const lapTime= (91.5 - (lastCall==='attack'?2.2:lastCall==='conserve'?-0.8:0) + (100-tyres)*.045 + Math.random()*1.2);
 best=best===null?lapTime:Math.min(best,lapTime);
 const paceBonus=lastCall==='attack'?.035:lastCall==='conserve'?.004:0;
 playerProgress+=.076+paceBonus+(energy>75?.004:0);
 rivals.forEach(r=>{if(!r.player)r.progress+=r.pace/12+(Math.random()-.45)*.006});
 energy=clamp(energy+(lastCall==='attack'?-4:lastCall==='conserve'?7:3),0,100);
 tyres=clamp(tyres-(lastCall==='attack'?9:lastCall==='conserve'?2:5),5,100);
 lap++;lastCall='balanced';
 // progress tracks full laps, keep player's race distance in the same units
 const me=rivals.find(r=>r.player);me.progress=playerProgress;
 position=1+rivals.filter(r=>!r.player&&r.progress>playerProgress).length;
 if(lap>=TOTAL){finished=true; $('resultTitle').textContent=position===1?'VICTORY!':`P${position} FINISH`; $('resultText').textContent=`You finished ${position===1?'first':`P${position}`} after ${TOTAL} laps. Best lap: ${best.toFixed(2)} seconds. ${pitUsed?'One pit stop completed.':'You skipped the pit stop.'}`;$('result').classList.remove('hidden');say('That is the chequered flag. Great work, team.');}
 render();
}
$('push').addEventListener('click',()=>choose('attack'));
$('conserve').addEventListener('click',()=>choose('conserve'));
$('pit').addEventListener('click',()=>choose('pit'));
$('next').addEventListener('click',step);
$('restart').addEventListener('click',()=>{lap=0;energy=68;tyres=82;position=4;playerProgress=0;best=null;started=false;finished=false;lastCall='balanced';pitUsed=false;rivals.forEach((r,i)=>r.progress=[.16,.10,.06,.04,.01,0][i]);$('result').classList.add('hidden');$('next').innerHTML='START RACE <span>→</span>';say('“All systems nominal. You are P4. Let’s make this count.”');render()});
render();
})();