'use client'

import '@google/model-viewer'

export default function ModelView() {
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
