        MODULE convert
        USE constants       ,ONLY: DBL
        USE initialise      ,ONLY: atoms, material, coord, energy, &
     &    read_coord, print_coord, input_file, output_file
!     &    ref_struc_file, target_struc_file

        CONTAINS

        SUBROUTINE run_convert
        IMPLICIT NONE
        INTEGER         :: f_in, f_out
        INTEGER         :: ierr
        INTEGER         :: counter,iter
        CHARACTER       :: dummy

        counter = 0

        ! Determine atoms and material
        CALL read_coord(input_file)

        OPEN(NEWUNIT=f_in,FILE=input_file,STATUS='old')
        OPEN(NEWUNIT=f_out,FILE=output_file,STATUS='replace')

        DO
          ! Read in coordinates
          READ(f_in,*,IOSTAT=ierr) atoms
          IF (ierr /= 0) EXIT
          counter = counter + 1
          READ(f_in,*)
          IF (ALLOCATED(coord)) DEALLOCATE(coord)
          ALLOCATE(coord(atoms,3))
          DO iter=1,atoms
            READ(f_in,*) dummy,coord(iter,1),coord(iter,2),coord(iter,3)
          END DO

          CALL au2ang(coord)

          ! Output converted coordinates
          WRITE(f_out,*) atoms
          WRITE(f_out,*) 
          DO iter=1,atoms
            WRITE(f_out,*) material,coord(iter,1) &
     &                     ,coord(iter,2),coord(iter,3)
          END DO

        END DO

        CLOSE(f_in)
        CLOSE(f_out)

        PRINT *,""
        PRINT *,"Converted structures: ", counter
        PRINT *,"Output file: ", output_file
        PRINT *,"Conversion done."
        PRINT *,""


        

        END SUBROUTINE run_convert




        SUBROUTINE au2ang(array)
! Reads in array and times a factor - changing from atomic unit lengths to
! angstroms
        IMPLICIT NONE
        REAL(KIND=DBL),DIMENSION(:,:),INTENT(INOUT)   :: array
        REAL(KIND=DBL)      :: factor=0.52917721067121 ! 1 a.u. to angstrom
        array = array * factor
        END SUBROUTINE au2ang

        END MODULE convert
