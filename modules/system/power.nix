{ config, lib, ... }:

{
  # TLP для оптимизации батареи
  services.tlp.enable = true;
  
  # CPU governor для энергосбережения
  powerManagement.cpuFreqGovernor = "schedutil";
}
