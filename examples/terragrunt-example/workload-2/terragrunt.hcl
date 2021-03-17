terraform {
  source = "../../paid-for-workloads/workload-2"
}

include {
  path = find_in_parent_folders()
}