program dtype_omp
  implicit none

  integer, parameter  :: dp = selected_real_kind(15,300)

  type  :: dtype_array
    real(kind=dp),dimension(128)  :: dp_vals
  end type dtype_array

  type(dtype_array)   :: dt
  integer             :: i,j

  dt%dp_vals = 0.0_dp

  !loop a billion times to show up on nvidia-smi
  !$omp target data map(tofrom:dt)
  !$omp target teams distribute parallel do
  do j=1,1000000000
    do i=1,128
      dt%dp_vals(i) = dt%dp_vals(i) + real(i)
    end do
  end do
  !$omp end target teams distribute parallel do
  !$omp end target data

  write(*,*) dt%dp_vals

end program dtype_omp
