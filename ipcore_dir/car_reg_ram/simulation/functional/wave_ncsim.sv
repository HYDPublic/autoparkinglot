

 
 
 




window new WaveWindow  -name  "Waves for BMG Example Design"
waveform  using  "Waves for BMG Example Design"

      waveform add -signals /car_reg_ram_tb/status
      waveform add -signals /car_reg_ram_tb/car_reg_ram_synth_inst/bmg_port/RSTA
      waveform add -signals /car_reg_ram_tb/car_reg_ram_synth_inst/bmg_port/CLKA
      waveform add -signals /car_reg_ram_tb/car_reg_ram_synth_inst/bmg_port/ADDRA
      waveform add -signals /car_reg_ram_tb/car_reg_ram_synth_inst/bmg_port/DINA
      waveform add -signals /car_reg_ram_tb/car_reg_ram_synth_inst/bmg_port/WEA
      waveform add -signals /car_reg_ram_tb/car_reg_ram_synth_inst/bmg_port/DOUTA

console submit -using simulator -wait no "run"
