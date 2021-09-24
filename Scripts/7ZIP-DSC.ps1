Configuration Install7Zip {
    Node localhost {
        {
            Package 7zip {
                Ensure     = 'Present'
                Name       = '7-Zip 19.00 (x64 edition)'
                Path       = 'C:\Users\rutge\Downloads\7z1900-x64.msi'
                ProductId  = '23170F69-40C1-2702-1900-000001000000'
            }
        }
    }
}