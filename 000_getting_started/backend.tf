terraform {
  cloud {
    organization = "ExamPro-TerraformLab"

    workspaces {
      name = "getting-started"
    }
  }
}