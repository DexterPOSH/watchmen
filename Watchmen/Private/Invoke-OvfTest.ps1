function Invoke-OvfTest {
    [cmdletbinding()]
    param(
        [parameter(Mandatory, ValueFromPipeline)]
        [pscustomobject[]]$OvfTestInfo,

        [parameter(Mandatory)]
        $Test
    )

    begin { }

    process {
        foreach ($ovfTest in $OvfTestInfo) {
            Write-Verbose -Message "Invoking OVF test [$($Test.ModuleName)][$($ovfTest.Name)]"
            $params = @{
                TestInfo = $ovfTest
                IncludePesterOutput = $IncludePesterOutput
            }
        
            if ($ovfTest.ScriptParameters) {
                if ($Test.Parameters) {
                    Write-Verbose "Overriding OVF test with parameters:"
                    Write-Verbose ($Test.Parameters | fl * | out-string)
                    $params.Overrides = $Test.Parameters
                }
            }
            return (Invoke-OperationValidation @params)
        }
    }

    end {}    
}