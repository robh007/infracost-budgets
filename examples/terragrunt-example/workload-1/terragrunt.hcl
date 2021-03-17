terraform {
  source = "../../paid-for-workloads/workload-1"
}

include {
  path = find_in_parent_folders()
}
