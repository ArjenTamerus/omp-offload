program notype_alloc
  implicit none

  integer, parameter  :: dp = selected_real_kind(15,300)

  real,dimension(:),allocatable  :: dp_vals
  integer             :: i,j

  allocate(dp_vals(128))
  dp_vals = 0.0_dp

  !Loop a billion times to show up on nvidia-smi...

  !$omp target enter data map(to:dp_vals)
  ! $omp target data map(tofrom:dp_vals(1:128))

  do j=1,1000
  !$omp target teams distribute parallel do
  do i=1,128
  dp_vals(i) = dp_vals(i) + real(i)
  end do
  !$omp end target teams distribute parallel do
  end do
  ! $omp end target data

  !$omp target exit data map(from:dp_vals)

  write(*,*) dp_vals

  deallocate(dp_vals)

end program notype_alloc

