#using Add-Type instead of Enum because I want to group by namespace
Add-Type -ErrorAction SilentlyContinue -TypeDefinition @'
namespace CCMClient
{
     public enum EvalResult {
          Not_Yet_Evaluated = 1,
          Not_Applicable = 2,
          Evaluation_Failed = 3,
          Evaluated_Remediated_Failed = 4,
          Not_Evaluated_Dependency_Failed = 5,
          Evaluated_Remediated_Succeeded = 6,
          Evaluation_Succeeded = 7
     }
     public enum EvaluationState
     {
          None = 0,
          Available = 1,
          Submitted = 2,
          Detecting = 3,
          PreDownload = 4,
          Downloading = 5,
          WaitInstall = 6,
          Installing = 7,
          PendingSoftReboot = 8,
          PendingHardReboot = 9,
          WaitReboot = 10,
          Verifying = 11,
          InstallComplete = 12,
          Error = 13,
          WaitServiceWindow = 14,
          WaitUserLogon = 15,
          WaitUserLogoff = 16,
          WaitJobUserLogon = 17,
          WaitUserReconnect = 18,
          PendingUserLogoff = 19,
          PendingUpdate = 20,
          WaitingRetry = 21,
          WaitPresModeOff = 22,
          WaitForOrchestration = 23
     }
     public enum DCMEvaluationState {
          NonCompliant = 0,
          Compliant = 1,
          Submitted = 2,
          Unknown = 3,
          Detecting = 4,
          NotEvaluated = 5
     }
}
'@