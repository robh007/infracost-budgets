terraform {
      // Terraform source code
      source = "${get_repo_root()}/modules/paid-for-workloads/workload-2"
}

include {
  path = find_in_parent_folders()
}
