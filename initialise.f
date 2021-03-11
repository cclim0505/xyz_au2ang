        MODULE initialise
        USE     constants       ,ONLY: DBL
!=========================================================================================
! VARIABLE DICTIONARY
!=========================================================================================
! Simulation parameters
        INTEGER             :: atoms
        CHARACTER(2)        :: material
        REAL(KIND=DBL),DIMENSION(:,:), ALLOCATABLE            :: coord
        REAL(KIND=DBL)      :: energy
        INTEGER             :: timestep

        CHARACTER(30)       :: input_file
        CHARACTER(40)       :: output_file

!=========================================================================================

! Session and initialization subroutines.
        PUBLIC  :: read_coord
        PUBLIC  :: print_coord

        CONTAINS

        SUBROUTINE initialise_var
        IMPLICIT NONE
        output_file="angOut_"//input_file
        END SUBROUTINE initialise_var


        SUBROUTINE read_coord(struc_file)
! Read xyz coordinates file.
        IMPLICIT NONE
        CHARACTER(20),INTENT(IN)   :: struc_file
        INTEGER         :: iter
        OPEN(21,file=struc_file,status='old')
        READ(21,*) atoms
        READ(21,*) 
        IF (ALLOCATED(coord)) DEALLOCATE(coord)
        ALLOCATE(coord(atoms,3))
        DO iter=1,atoms
          READ(21,*) material, coord(iter,1),coord(iter,2),coord(iter,3)
        END DO
        CLOSE(21)
        END SUBROUTINE read_coord
        
        SUBROUTINE print_coord
! For debugging: Print xyz coordinate files in columns.
        IMPLICIT NONE
        INTEGER  :: iter
        PRINT *, ''
        PRINT *, 'Coordinates in xyz'
        PRINT *, ''
        DO iter =1,atoms 
          PRINT *, iter, coord(iter,1), coord(iter,2), coord(iter,3)
        END DO
        PRINT *, ''
        END SUBROUTINE print_coord

        END MODULE initialise
