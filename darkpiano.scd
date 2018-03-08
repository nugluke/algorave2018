///módulo de comunicação com arduino
(
p = ArduinoSMS("/dev/ttyUSB0", 9600);

///formata as entradas dentro de variáveis

p.action = { |... msg| ~pot1 = msg[1]; ~pot2 = msg[2]; ~pot3= msg[3]; ~pot4= msg[4]  };

)
SerialPort.devices


s.record



fork{loop{ p.send($r, $a); 	0.1.wait;}};

(
SynthDef(\darkpiano, {
	arg out = 0, midi = 60, amp = 0.2, cf = 1000, pan = 0, agu = 0, grav =0.5 ;
	var snd, env, snddef;
	env = EnvGen.ar(Env.perc(2, 20 , 0.2, -15), doneAction: 2);
	snddef = SinOsc.ar(midi.midicps + 80) + SinOsc.ar(midi.midicps + 50) * grav * 0.8 ;
	snd = LFSaw.ar(midi.midicps - 150)  * agu * 0.5 ;
	snd = snd  + snddef * env;
	snd = RLPF.ar(snd,cf,0.03) * amp;
	snd = FreeVerb.ar(snd,0.3,10,10);
	Out.ar(7, Pan2.ar(snd,SinOsc.kr(pan)));
}).add;
)

Pseq([58,50,56,55,52,62,69,59], inf)

(
~darkpiano = Pbind(
	\instrument, "darkpiano",
	\midi, Pseq([58,58,58,69.1,67,69.5,69.2], inf),
	\dur, 0.5,
	\cf, Pfunc({~pot1.linlin(0,1023,100,20000)}),
	\pan, Pfunc({~pot2.linlin(0,1023,0,30.0)}),
	\agu,Pfunc({~pot3.linlin(0,1023,0,0.5)}),
	\grav, Pfunc({~pot4.linlin(0,1023,0.1,0.9)}),
	\amp, 2,
).play;
)

(
SynthDef(\cut, {
	arg out = 0, midi = 60, amp = 0.2, cf = 1000, pan = 0, agu = 0, grav =0.5 ;
	var snd, env;
	snd = In.ar(7,1);
	snd = Limiter.ar(snd, 0.4, 0.01);
	Out.ar(0, Pan2.ar(snd,SinOsc.kr(pan)));
}).add;
)

~pano = Synth.new(\cut);
~pano.set(\pan,100);

~darkpiano.play
~darkpiano.stop