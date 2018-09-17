
#if (defined _OPENACC)

#define _dir          $acc
#define _din(...)     copyin(__VA_ARGS__)
#define _dout(...)    copyout(__VA_ARGS__)
#define _dcreate(...) create(__VA_ARGS__)
#define _ddelete(...) delete(__VA_ARGS__)
#define _kin(...)     copyin(__VA_ARGS__)
#define _kout(...)    copyout(__VA_ARGS__)
#define _kinout(...)  copy(__VA_ARGS__)
#define _kcreate(...) create(__VA_ARGS__)
#define _gang         gang
#define _vector       vector
#define _async(i)     async(i)
#define _wait(i)      wait(i)
#define _par          parallel
#define _loop         loop
#define _enter_data   enter data
#define _exit_data    exit data

#elif (defined _OPENMP45)

#define _dir          $omp
#define _din(...)     map(to:__VA_ARGS__)      depend(out:__VA_ARGS__)
#define _dout(...)    map(from:__VA_ARGS__)    depend(in:__VA_ARGS__)
#define _dcreate(...) map(alloc:__VA_ARGS__)   depend(out:__VA_ARGS__)
#define _ddelete(...) map(release:__VA_ARGS__) depend(in:__VA_ARGS__)
#define _kin(...)     map(to:__VA_ARGS__)      depend(in:__VA_ARGS__)
#define _kout(...)    map(from:__VA_ARGS__)    depend(out:__VA_ARGS__)
#define _kinout(...)  map(tofrom:__VA_ARGS__)  depend(inout:__VA_ARGS__)
#define _kcreate(...) map(alloc:__VA_ARGS__)
#define _gang         distribute
#define _vector       parallel do
#define _async(i)     nowait
#define _wait(i)      taskwait
#define _par          target teams
#define _loop         
#define _enter_data   target enter data
#define _exit_data    target exit data

#elif (defined _OPENMP_LOOP)
#define _dir          $omp parallel do
#define _din(...)     
#define _dout(...)    
#define _dcreate(...) 
#define _ddelete(...) 
#define _kin(...)     
#define _kout(...)    
#define _kinout(...)  
#define _kcreate(...) 
#define _gang         
#define _vector       
#define _async(i)     
#define _wait(i)      
#define _par          
#define _loop         
#define _enter_data   
#define _exit_data    

#else

#define _dir nodirective
#define _din(...)     
#define _dout(...)    
#define _dcreate(...) 
#define _ddelete(...) 
#define _kin(...)     
#define _kout(...)    
#define _kinout(...)  
#define _kcreate(...) 
#define _gang         
#define _vector       
#define _async(i)     
#define _wait(i)      
#define _par          
#define _loop         
#define _enter_data   
#define _exit_data    

#endif


program test
  implicit none
  integer, parameter :: nz = 64
  integer, parameter :: ny = 4
  integer, parameter :: nx = 64
  real(4) :: a(nx,ny,nz), b(nx,ny,nz), c(nx,ny,nz), d(nx,ny,nz)
  integer :: i, j, k

  a=1
  b=2
  d=3

  !_dir _enter_data _din(a,b,d) _dcreate(c) _async(1)

  !_dir _par _loop _gang _vector collapse(3) _kin(a,b) _kout(c) _kinout(d) _async(1)
  do k = 1 , nz
    do j = 1 , ny
      do i = 1 , nx
        c(i,j,k) = a(i,j,k)*b(i,j,k)
        d(i,j,k) = d(i,j,k)*c(i,j,k)
      enddo
    enddo
  enddo

  !_dir _exit_data _dout(c,d) _ddelete(a,b) _async(1)

  !_dir _wait(1)


  write(*,*) sum(c), sum(d)

end program test

