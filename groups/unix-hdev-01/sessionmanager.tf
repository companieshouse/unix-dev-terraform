resource "aws_ssm_document" "session_manager_settings" {
  name            = "SSM-SessionManagerRunShell"
  document_type   = "Session"
  document_format = "JSON"
  content         = <<DOC
{
  "schemaVersion": "1.0",
  "description": "Document to hold regional settings for Session Manager",
  "sessionType": "Standard_Stream",
  "parameters": {
    "linuxcmd": {
      "type": "String",
      "default": "sh /etc/profile.d/banner.sh",
      "description": "The command to run on connection."
    },
    "windowscmd": {
      "type": "String",
      "default": "Write-Host Connected to $([System.Net.Dns]::GetHostName())",
      "description": "The command to run on connection."
    }
  },
  "inputs": {
    "idleSessionTimeout": "15",
    "shellProfile": {
      "windows": "{{ windowscmd }}",
      "linux": "{{ linuxcmd }}"
    }
  }
}
DOC

  tags = local.default_tags
}