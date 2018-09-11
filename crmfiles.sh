#!/bin/bash

find /home/imn/ACME-ECP/components/cam/src/physics/crm -type f -iname "*.f*"  | grep -v "MICRO_M2005FRAC/" | grep -v "SGS_CLUBBkvhkvm/" | grep -v "CLUBB/" | grep -v module_mp_graupel.F90 | grep -v crm_ecpp_output_module.F90 | grep -v crm_input_module.F90 | grep -v crm_output_module.F90 | grep -v crm_rad_module.F90 | grep -v crm_state_module.F90
#echo /home/imn/ACME-ECP/components/cam/src/physics/cam/crm_physics.F90

#find /home/imn/ACME-ECP/components/cam/src/physics -type f -iname "*.f*"
