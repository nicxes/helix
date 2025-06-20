'use client'

import { useEffect, useState } from 'react'

export default function ModelView() {
  const [isLoaded, setIsLoaded] = useState(false)

  useEffect(() => {
    import('@google/model-viewer').then(() => {
      setIsLoaded(true)
    })
  }, [])

  if (!isLoaded) {
    return (
      <div style={{ 
        width: '100%', 
        height: '520px', 
        border: '1px solid #FFFFFF1A', 
        borderRadius: '8px',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        backgroundColor: '#f5f5f5'}}
      />
    )
  }

  return (
    <div>
      <model-viewer
        src="/models/vis_p35p_pistol.glb"
        alt="Weapon Pistol"
        camera-controls
        auto-rotate
        ar
        style={{ width: '100%', height: '520px', border: '1px solid #FFFFFF1A', borderRadius: '8px' }}
      />
    </div>
  )
}
