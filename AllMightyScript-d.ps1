# Launch Carla
$carla = Start-Process -FilePath "C:\Users\roar\Desktop\RL-Berkmajor(fixedlight)\WindowsNoEditor\CarlaUE4.exe" -PassThru
$carla = $carla | Get-Process

# Activate the conda environment
conda activate ROAR_Major

# Python Script
cd D:\tl-branch\ROAR_RL\ROAR_gym\

$e2emodel = Start-Process "C:\Users\roar\anaconda3\envs\ROAR_Major\python.exe" -ArgumentList "D:\tl-branch\ROAR_RL\ROAR_gym\e2eModel.py" -PassThru
$e2emodel = $e2emodel | Get-Process

Start-Sleep -Seconds 30

do {
    
    # If e2emodel is not running
    if( $e2emodel.HasExited )
    { 
        "e2emodel not Running"

        # Check if carla is running
        # If running kill it
        if( $carla.HasExited )
        {
            "and carla not Running :("
        }
        else
        {
            # Stop Carla
            "but Carla is running, so killing Carla"
            taskkill /IM CarlaUE4.exe /F
            Start-Sleep -Seconds 30
        }

        "Now Restarting Everything!"
        # Restart Carla
        $carla = Start-Process -FilePath "C:\Users\roar\Desktop\RL-Berkmajor(fixedlight)\WindowsNoEditor\CarlaUE4.exe" -PassThru
        $carla = $carla | Get-Process

        # Restart the Model
        $e2emodel = Start-Process "C:\Users\roar\anaconda3\envs\ROAR_Major\python.exe" -ArgumentList "D:\tl-branch\ROAR_RL\ROAR_gym\e2eModel.py" -PassThru
        $e2emodel = $e2emodel | Get-Process
    }
    else{ 
        "e2emodel Running"

        # Check if carla is running
        # If not running kill e2emodel
        if( $carla.HasExited )
        {
            "But carla not Running :("
            
            "so killing e2emodel"
            # Stop e2emodel
            $e2emodel | Stop-Process -Force
            Start-Sleep -Seconds 30

            "Now Restarting Everything!"
            # Restart Carla
            $carla = Start-Process -FilePath "C:\Users\roar\Desktop\RL-Berkmajor(fixedlight)\WindowsNoEditor\CarlaUE4.exe" -PassThru
            $carla = $carla | Get-Process

            # Restart the Model
            $e2emodel = Start-Process "C:\Users\roar\anaconda3\envs\ROAR_Major\python.exe" -ArgumentList "D:\tl-branch\ROAR_RL\ROAR_gym\e2eModel.py" -PassThru
            $e2emodel = $e2emodel | Get-Process
        }
        else
        {
            "Carla also Running, life is good :)"
        }
    }
    Start-Sleep -Seconds 30
} while ($True)