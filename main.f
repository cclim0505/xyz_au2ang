        PROGRAM main
        USE initialise      ,ONLY: input_file, initialise_var
        USE convert         ,ONLY: run_convert
        IMPLICIT NONE

        WRITE(*,'(/A)') repeat("*",50)
        WRITE(*,*) 'Utility programme that converts xyz files'
        WRITE(*,*) 'from atomic units length to angstrom'
        WRITE(*,*) ''
        WRITE(*,*) '        Version 1.0'
        WRITE(*,*) '        11 Mar 2021'
        WRITE(*,'(/A)') repeat("*",50) 

        CALL get_command_argument(1,input_file)  
        IF(input_file =='') THEN                
          WRITE(*,*)                           
          WRITE(*,*) 'Use'                    
          WRITE(*,*) './convert.out input_file'
          WRITE(*,*) 'Try again'              
          WRITE(*,*)                         
          STOP                              
        END IF    

        CALL initialise_var
        CALL run_convert

        END PROGRAM main
